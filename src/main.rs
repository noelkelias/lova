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

   // let mut private_inputs = Vec::new();
   // for i in 0..iteration_count {
   //     let mut private_input = HashMap::new();
   //     private_input.insert("a".to_string(), json!(i+1));
   //     private_inputs.push(private_input);
   // }

   // print!("{:?}", private_inputs);           

   // let start_public_input = F::<G1>::from(1);
   // print!("{:?}", start_public_input);           


}

fn main() {
   println!("Hello, world!");

   let circuit_filepath = "circuits/multiplier_test/multiplier2.r1cs";
   for witness_gen_filepath in ["circuits/multiplier_test/multiplier2_js/multiplier2.wasm"] {
       run_test(circuit_filepath.to_string(), witness_gen_filepath.to_string());
   }

}

