pragma circom 2.0.0;

include "comparators.circom";
include "proof_verification.circom";

template Test() {
   signal input statement[3];
   signal input logic;
   signal input reason[6];

   signal input step_in;
   signal output step_out;

   var bob[3];
   // for (var i = 0; i < 3; i++){
   //    bob[i] = statement[i];
   // }
   bob = statement;

   //Comments
   var x = step_in + bob[0];
   x += bob[1];
   x += bob[2];
   x += logic;

   for (var i = 0; i < 6; i++){
      x += reason[i];
   }

   //Comments
   component calcTotal = CalculateTotal(2);
   component zerCheck = IsZero();
   zerCheck.in <== 0;
   assert(zerCheck.out==1);

   component eqCheck = IsEqual();
   eqCheck.in[0] <== statement[0];
   eqCheck.in[1] <== statement[0];

   assert(eqCheck.out==1);

   component temp = Hypothesis();
   assert(temp.out ==1);

   component temp2 = ModusPonens();
   // var bob[3];
   // for (var i = 0; i < 3; i++){
   //    bob[i] = 1;
   // }
   temp2.statement <== [1,1,1];

   for (var i = 0; i < 6; i++){
      temp2.reason[i] <== 1;
   }   

   assert(temp2.out < 10);

   //Comments
   calcTotal.nums[0] <== 1;
   calcTotal.nums[1] <== 1;

   assert(calcTotal.sum>1);

   step_out <== x;
}

component main {public [step_in] }= Test();
 