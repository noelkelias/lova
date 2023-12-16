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

   let circuit_file = root.join("examples/bitcoin/circom/bitcoin_benchmark.r1cs");
   let witness_generator_file = root.join("examples/bitcoin/circom/bitcoin_benchmark_cpp/bitcoin_benchmark");
   let r1cs = load_r1cs::<G1, G2>(&circuit_file); // loads R1CS file into memory

   let mut private_inputs = Vec::new();

}

fn main() {
   println!("Hello, world!");
}

