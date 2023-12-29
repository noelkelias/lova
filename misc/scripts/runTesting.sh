#!/usr/bin/env bash
cd circuits/testing
circom test.circom --r1cs --wasm --sym --c
cd test_cpp/
make 
cd ..
cd .. 
cd ..
cargo run
