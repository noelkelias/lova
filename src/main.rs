use std::{collections::HashMap, env::current_dir, time::Instant, fs::read_to_string};

use nova_scotia::{
    circom::reader::load_r1cs, create_public_params, create_recursive_circuit, FileLocation, F, S,
};
use nova_snark::{
    provider,
    traits::{circuit::StepCircuit, Group},
    CompressedSNARK, PublicParams,
};
use serde_json::json;


fn run_test(circuit_filepath: String, witness_gen_filepath: String) {
   type G1 = pasta_curves::pallas::Point;
   type G2 = pasta_curves::vesta::Point;

   let root = current_dir().unwrap();

   let circuit_file = root.join(circuit_filepath);
   let r1cs = load_r1cs::<G1, G2>(&FileLocation::PathBuf(circuit_file));
   let witness_generator_file = root.join(witness_gen_filepath);

   let pp: PublicParams<G1, G2, _, _> = create_public_params(r1cs.clone());

   //Added Part
   let proof_lines = read_proof("misc/basic_proof.txt");
   let encoded_statements = encode_statement(&proof_lines);
   println!("{:?}", encoded_statements);
   let encoded_logic = encode_logic(&proof_lines);
   println!("{:?}", encoded_logic);
   let encoded_reasoning = encode_reasoning(&proof_lines, &encoded_statements);
   println!("{:?}", encoded_reasoning);

   // let encoded_logic: [[i32; 3]; 3] = [[0, 0, 0], [1, 0, 0], [0, 1, 1]];
   // let encoded_logic: [i32; 3] = [0,0,1];


   let iteration_count = 3;

   let mut private_inputs = Vec::new();
   for i in 0..iteration_count {
      let mut private_input = HashMap::new();
      private_input.insert("statement".to_string(), json!(encoded_statements[i]));
      private_input.insert("logic".to_string(), json!(encoded_logic[i]));
      private_input.insert("reason".to_string(), json!(encoded_reasoning[i]));

      private_inputs.push(private_input);
  }

  let start_public_input = [F::<G1>::from(2)];

    //Added end
    println!("Creating a RecursiveSNARK...");
    let start = Instant::now();
    let recursive_snark = create_recursive_circuit(
        FileLocation::PathBuf(witness_generator_file),
        r1cs,
        private_inputs,
        start_public_input.to_vec(),
        &pp,
    )
    .unwrap();
    println!("RecursiveSNARK creation took {:?}", start.elapsed());
 
    let z0_secondary = [F::<G2>::from(0)];
    println!("Verifying a RecursiveSNARK...");
    let start = Instant::now();
    let res = recursive_snark.verify(&pp, iteration_count, &start_public_input, &z0_secondary);
    println!(
        "RecursiveSNARK::verify: {:?}, took {:?}",
        res,
        start.elapsed()
    );
    assert!(res.is_ok());
 
    println!("Generating a CompressedSNARK using Spartan with IPA-PC...");
    let start = Instant::now();
 
    let (pk, vk) = CompressedSNARK::<_, _, _, _, S<G1>, S<G2>>::setup(&pp).unwrap();
    let res = CompressedSNARK::<_, _, _, _, S<G1>, S<G2>>::prove(&pp, &pk, &recursive_snark);
    println!(
        "CompressedSNARK::prove: {:?}, took {:?}",
        res.is_ok(),
        start.elapsed()
    );
    assert!(res.is_ok());
    let compressed_snark = res.unwrap();
 
    // verify the compressed SNARK
    println!("Verifying a CompressedSNARK...");
    let start = Instant::now();
    let res = compressed_snark.verify(
        &vk,
        iteration_count,
        start_public_input.to_vec(),
        z0_secondary.to_vec(),
    );
    println!(
        "CompressedSNARK::verify: {:?}, took {:?}",
        res.is_ok(),
        start.elapsed()
    );
    assert!(res.is_ok());
   
}

//Encode the statement into a vector of arrays 
fn encode_statement(proof_lines: &Vec<Vec<String>>) -> Vec<[i64; 3]>{
   let mut statement_dict = HashMap::from([
      ("&", 1),
      ("|", 2),
      (">",3)]);   

   let symbols = ["&", "|", ">"];
   let mut count:i64 = 4;

   let mut encoded_statements = Vec::new();
   for line in proof_lines{
      let mut statement: [i64; 3] = [0; 3];
      let mut raw_statement = line[0].split(&['&','|','>'][..]).collect::<Vec<_>>();

      for symbol in symbols{
         if line[0].contains(&symbol.to_owned()){
            raw_statement.push(symbol);
         }
      }
      
      for (index, elem) in raw_statement.iter().enumerate() {
         if statement_dict.get(elem) == None {
            statement_dict.insert(elem, count);
            statement[index] = count;
            count += 1;
         } else {
            statement[index] = *statement_dict.get(elem).unwrap_or(&0);      
         }
      }
      encoded_statements.push(statement);

   }
   encoded_statements
}

//Encode Logic steps
fn encode_logic(proof_lines: &Vec<Vec<String>>) -> Vec<i64>{
   let mut statement_dict = HashMap::from([
       ("hypothesis", 0),
      ("addition", 1),
      ("conjunction",2),
      ("simplification", 3),
      ("resolution", 4),
      ("modusponens", 5),
      ("modustollens", 6),
      ("hypotheticalsyllogism",7),
      ("disjunctivesyllogism", 8)]);   

   let mut encoded_logic: Vec<i64> = Vec::new();
   for line in proof_lines{
      let formatted_line = line[1].replace(&[','][..], "").to_lowercase();
      encoded_logic.push(*statement_dict.get(&formatted_line as &str).unwrap_or(&0));      
   }

   encoded_logic
}


//Encode Necessary Reasoning lines
fn encode_reasoning(proof_lines: &Vec<Vec<String>>, encoded_statements: &Vec<[i64; 3]>) -> Vec<[i64; 6]>{

   let mut encode_reasoning = Vec::new();
   for line in proof_lines{
      let mut reasoning_lines: [i64; 6] = [0; 6];

      if line.len() == 3{
         let raw_reasoning = line[2].split(&[','][..]).collect::<Vec<_>>(); 

         let mut array_position = 0;
         for elem in raw_reasoning{
            let index = elem.parse::<i64>().unwrap()-1;
            let temp_array = encoded_statements[index as usize];

            for val in temp_array{
               reasoning_lines[array_position] = val;
               array_position +=1;
            }
            array_position += (array_position % 3);
         }
      } 
   
      encode_reasoning.push(reasoning_lines);      
   }
   encode_reasoning
}



//Reading the proof into a vector of strings
fn read_proof(path: &str) -> Vec<Vec<String>> {
   let mut result = Vec::new();
   let file = read_to_string(path).unwrap();

   for line in file.lines() {
      let  proof_line = line.replace(&[' '][..], "").split(&['(', ')', '[', ']']).filter(|&r| r != "").map(|r| r.to_string() ).collect::<Vec<_>>();
      result.push(proof_line);
  }

  result
}

fn main() {
   let circuit_filepath = "circuits/testing/test.r1cs";
   for witness_gen_filepath in ["circuits/testing/test_cpp/test"] {
       run_test(circuit_filepath.to_string(), witness_gen_filepath.to_string());
   }

}

