pragma circom 2.1.6;

include "proof_verification.circom";


template Test() {
   signal input step_in;
   signal input logic[2];
   signal input statement[3];
   // signal input reason[6];
   signal output step_out;

   assert (step_in < 1000);

   component temp = CalculateTotal(2);
   component hyp = Hypothesis();

   temp.nums[0] <== 2;
   temp.nums[1] <== 2;

   var x = temp.sum + hyp.out;

   component mpTest = ModusPonens();
   mpTest.statement <== statement;

   component mpTest2 = ModusPonens();
   mpTest2.statement <== statement;

   x += mpTest.out;
   x += mpTest2.out;

   var y = mpTest.out + logic[1];
   var z = mpTest2.out - logic[0];

   var t = z+y;
   var l = t+x;

   component summing = CalculateTotal(2);
   summing.nums[0] <== l+logic[0];
   summing.nums[1] <== l+logic[1];

   step_out <== summing.sum;
}

component main {public [step_in] }= Test();
