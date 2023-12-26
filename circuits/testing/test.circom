pragma circom 2.1.6;

include "proof_verification.circom";


template Test() {
   signal input step_in;
   signal input logic[3];
   signal input statement[3];
   signal input reason[6];
   signal output step_out;

   component proofSum = CalculateTotal(3);

   var bob [4] = [1,2,3,4];
   //Hypothesis 
   component hyp = Hypothesis();

   //Modus Ponens
   component mp = ModusPonens();
   mp.statement <== statement;
   mp.reason <== reason;

   //Modus Tollens
   component mt = ModusTollens();
   mt.statement <== statement;
   mt.reason <== reason;

   proofSum.nums[0] <== hyp.out + logic[0];
   proofSum.nums[1] <== mp.out + logic[1];
   proofSum.nums[2] <== mp.out + logic[2];

   assert (proofSum.sum > reason[logic[0]+1]);

   step_out <== proofSum.sum;
}

component main {public [step_in] }= Test();
