#!/usr/bin/env bash
cd circuits/proof_verification
circom proof_analysis.circom --r1cs --wasm --sym --c
cd proof_analysis_cpp/
make 
cd ..
cd .. 
cd ..
cargo run
