use std::{collections::HashMap, env::current_dir, time::Instant};

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

   let iteration_count = 2;
   let root = current_dir().unwrap();

   let circuit_file = root.join(circuit_filepath);
   let r1cs = load_r1cs::<G1, G2>(&FileLocation::PathBuf(circuit_file));
   let witness_generator_file = root.join(witness_gen_filepath);

   let pp: PublicParams<G1, G2, _, _> = create_public_params(r1cs.clone());

   let mut private_inputs = Vec::new();
   for i in 0..iteration_count {
       let mut private_input = HashMap::new();
       private_input.insert("a".to_string(), json!(i+1));
       private_inputs.push(private_input);
   }
   print!("{:?}", private_inputs);           

   let start_public_input = [F::<G1>::from(1)];
   print!("{:?}", start_public_input);           

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

fn main() {
   println!("Hello, world!");

   let circuit_filepath = "circuits/nova_test/nova_test.r1cs";
   for witness_gen_filepath in ["circuits/nova_test/nova_test_js/nova_test.wasm"] {
       run_test(circuit_filepath.to_string(), witness_gen_filepath.to_string());
   }

}

