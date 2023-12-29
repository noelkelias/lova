pragma circom 2.1.6;

include "logic_verification.circom";


template ProofAnalysis() {
   signal input step_in;
   signal input logic;
   signal input statement[3];
   signal input reason[6];
   signal output step_out;

   //Logic
   var numLogics = 9;
   var lineSums[numLogics*3];

   //Symbols
   var and = 1;
   var or = 2;
   var arrow = 3;

   //Premise 
   var prem_index = 0;
   component prem = Premise();
   prem.statement <== statement;
   prem.reason <== reason;

   lineSums[prem_index] = prem.out[0];
   lineSums[prem_index+numLogics] = prem.out[1];
   lineSums[prem_index+numLogics*2] = prem.out[2];

   //Addition 
   var add_index = 1;
   component add = Addition(or);
   add.statement <== statement;
   add.reason <== reason;

   lineSums[add_index] = add.out[0];
   lineSums[add_index+numLogics] = add.out[1];
   lineSums[add_index+numLogics*2] = add.out[2];

   //Conjunction 
   var conj_index = 2;
   component conj = Conjunction(and);
   conj.statement <== statement;
   conj.reason <== reason;

   lineSums[conj_index] = conj.out[0];
   lineSums[conj_index+numLogics] = conj.out[1];
   lineSums[conj_index+numLogics*2] = conj.out[2];

   //Simplification 
   var simp_index = 3;
   component simp = Simplification(and);
   simp.statement <== statement;
   simp.reason <== reason;

   lineSums[simp_index] = simp.out[0];
   lineSums[simp_index+numLogics] = simp.out[1];
   lineSums[simp_index+numLogics*2] = simp.out[2];

   //Resolution 
   var res_index = 4;
   component res = Resolution(or);
   res.statement <== statement;
   res.reason <== reason;

   lineSums[res_index] = res.out[0];
   lineSums[res_index+numLogics] = res.out[1];
   lineSums[res_index+numLogics*2] = res.out[2];

   //Modus Ponens
   var mp_index = 5;
   component mp = ModusPonens(arrow);
   mp.statement <== statement;
   mp.reason <== reason;

   lineSums[mp_index] = mp.out[0];
   lineSums[mp_index+numLogics] = mp.out[1];
   lineSums[mp_index+numLogics*2] = mp.out[2];

   //Modus Tollens
   var mt_index = 6;
   component mt = ModusTollens(arrow);
   mt.statement <== statement;
   mt.reason <== reason;

   lineSums[mt_index] = mt.out[0];
   lineSums[mt_index+numLogics] = mt.out[1];
   lineSums[mt_index+numLogics*2] = mt.out[2];

   //Hypothetical Syllogism
   var hs_index = 7;
   component hs = HypotheticalSyllogism(arrow);
   hs.statement <== statement;
   hs.reason <== reason;

   lineSums[hs_index] = hs.out[0];
   lineSums[hs_index+numLogics] = hs.out[1];
   lineSums[hs_index+numLogics*2] = hs.out[2];

   //Disjunctive Syllogism
   var ds_index = 8;
   component ds = DisjunctiveSyllogism(or);
   ds.statement <== statement;
   ds.reason <== reason;

   lineSums[ds_index] = ds.out[0];
   lineSums[ds_index+numLogics] = ds.out[1];
   lineSums[ds_index+numLogics*2] = ds.out[2];


   //Test #1 - Sum across statement
   var statementSum = 0;
   for (var i = 0; i < 3; i++){
      statementSum += statement[i];
   }

   assert (statementSum == lineSums[logic]);

   //Test #2 - Sum across reasons
   var reasonSum = 0;
   for (var i = 0; i < 6; i++){
      reasonSum += reason[i];
   }
   assert (reasonSum == lineSums[logic+numLogics]);

   //Test #3 - Calculate sum across all statement/reason
   var proofSum = statementSum+reasonSum;
   assert (proofSum == lineSums[logic+numLogics*2]);

   step_out <== proofSum;
}

component main {public [step_in] }= ProofAnalysis();
