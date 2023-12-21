pragma circom 2.0.0;

include "comparators.circom";
include "proof_verification.circom";

template Test() {
    signal input statement[3];
    signal input logic;
    signal input reason[6];

    signal input step_in;
    signal output step_out;


    var x = statement[0]+step_in;
    x += statement[1];
    x += statement[2];
    x += logic;

    for (var i = 0; i < 6; i++){
       x += reason[i];
    }

    component calcTotal = CalculateTotal(2);

   calcTotal.nums[0] <== x;
   calcTotal.nums[1] <== 1;

   assert(calcTotal.sum>1);

    step_out <== x;
 }

 component main {public [step_in] }= Test();
 