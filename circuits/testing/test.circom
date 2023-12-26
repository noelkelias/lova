pragma circom 2.1.6;

include "proof_verification.circom";


template Test() {
   signal input step_in;
   signal input logic;
   signal input statement[3];
   signal input reason[6];
   signal output step_out;

   var reasoningSums[9];

   //Hypothesis 
   component hyp = Hypothesis();
   hyp.statement <== statement;
   reasoningSums[0] = hyp.out;

   //Addition 
   component add = Addition();
   add.statement <== statement;
   reasoningSums[1] = add.out;

   //Conjunction 
   component conj = Conjunction();
   conj.statement <== statement;
   reasoningSums[2] = conj.out;

   //Simplification 
   component simp = Simplification();
   simp.reason <== reason;
   reasoningSums[3] = simp.out;

   //Resolution 
   component res = Resolution();
   res.statement <== statement;
   reasoningSums[4] = simp.out;

   //Modus Ponens
   component mp = ModusPonens();
   mp.reason <== reason;
   reasoningSums[5] = mp.out;

   //Modus Tollens
   component mt = ModusTollens();
   reasoningSums[6] = mt.out;

   //Hypothetical Syllogism
   component hs = HypotheticalSyllogism();
   hs.reason <== reason;
   reasoningSums[7] = hs.out;

   //Disjunctive Syllogism
   component ds = DisjunctiveSyllogism();
   ds.statement <== statement;
   reasoningSums[8] = ds.out;

   //Calculate sum across all statement/reason
   var proofSum = 0;
   for (var i = 0; i < 3; i++){
      proofSum += statement[i];
   }

   for (var i = 0; i < 6; i++){
      proofSum += reason[i];
   }

   assert (proofSum == reasoningSums[logic]);

   step_out <== proofSum;
}

component main {public [step_in] }= Test();
