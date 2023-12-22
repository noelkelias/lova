#!/usr/bin/env bash
cd circuits/testing
circom test.circom --r1cs --wasm --sym --c
cd test_cpp/
make 
./test /Users/nk-mac/Documents/Research/nova_mathproofs/circuits/testing/inputs.json witness.wtns
cd ..
cd .. 
cd ..
cargo run
