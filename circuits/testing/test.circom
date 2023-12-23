pragma circom 2.1.6;

include "proof_verification.circom";

template Test() {
   signal input step_in;
   signal input logic;
   signal input statement[3];
   // signal input reason[6];
   signal output step_out;

   component temp = CalculateTotal(2);
   component hyp = Hypothesis();

   temp.nums[0] <== logic;
   temp.nums[1] <== step_in;

   var x = temp.sum + hyp.out;

   component mpTest = ModusPonens();
   mpTest.statement <== statement;

   component mpTest2 = ModusPonens();
   mpTest2.statement <== statement;

   x += mpTest.out;
   x += mpTest2.out;


   assert (x<1000);


   step_out <== x;
}

component main {public [step_in] }= Test();
