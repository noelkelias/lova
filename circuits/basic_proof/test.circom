pragma circom 2.0.0;

include "comparators.circom";
include "proof_verification.circom";

template Test() {
   signal input statement[3];
   signal input logic;
   signal input reason[6];
   signal input step_in;
   signal output step_out;

   component calcTotal = CalculateTotal(2);

   //Hypothesis
   component hypCheck = IsEqual();
   hypCheck.in[0] <== 1;
   hypCheck.in[1] <== logic;

   component hyp = Hypothesis();
   calcTotal.nums[0] <== hyp.out * hypCheck.out;

   //Modus Ponens
   component mpCheck = IsEqual();
   mpCheck.in[0] <== 5;
   mpCheck.in[1] <== logic;

   component mp = ModusPonens();
   mp.statement <== statement;
   mp.reason <== reason;
   calcTotal.nums[1] <== mp.out * mpCheck.out;

   //Checking if proof step is valid
   assert(calcTotal.sum==1);

   //Output new line index
   step_out <== step_in +1;
}


component main {public [step_in] }= Test();
