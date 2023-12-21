pragma circom 2.0.0;

include "comparators.circom";


template BasicProof() {
   signal input statement[3];
   signal input logic;
   signal input reason[6];
   signal input step_in[101];
   signal output step_out[101];

   // Deciding which logic template to use
   var success = 0;
   component x = ModusPonens();
   component y = Hypothesis();

   if (logic == 1){
      // component x = Hypothesis(); 
      // x.statement <== statement;
      // x.reason <== reason;
      // success = x.verification;
      success = 1;

   } 
   // else if (logic == 5){
   //    component y = Hypothesis();
   //    y.statement <== statement;
   //    y.reason <== reason;
   //    success = y.verification;
   // }


   // Crafting output based on verification
   assert(success==1);

   // for (var i = 0; i < 101; i++){
   //    if (i==0){
   //       step_out[i] <== step_in[i] +1;
   //    } 
      // else if (i == step_in[i]){
      //    step_out[i] <== step_in[0];
      // } else {
      //    step_out[i] <== step_in[i];
      // }
   // }

   component z = IsEqual();
   z.in[0] <== logic;
   z.in[1] <== 1;

   var p = z.out;
   // if (p){
   //    step_out[0] <== 1;
   // }

 }

template Hypothesis(){
   signal input statement[3];
   signal input reason[6];
   signal output verification;
   verification <== 1;
}

template ModusPonens(){
   signal input statement[3];
   signal input reason[6];
   signal output verification;

   var success = 1;

   //Check if A is present and formatted correctly
   if (reason[0] != reason[3]){
      success = 0;
   }

   //Check if implication is valid
   if ((reason[1]!=statement[0] || reason[2]!=4) && (reason[4]!=statement[0] && reason[5]!=4)){
      success = 0;
   }

   verification <== success;
}

// template IsZero(A,B) {
//     signal output out;

//     if (A==0){
//       out <== 0;
//     } else {
//       out <== 1;
//     }
// }

component main {public [step_in] }= BasicProof();
 