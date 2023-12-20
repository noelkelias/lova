pragma circom 2.0.0;

template BasicProof() {
   signal input statement[3];
   signal input logic;
   signal input reason[6];
   signal input step_in[101];
   signal output step_out[101];

   // Deciding which logic template to use
   var success = 0;

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

   for (var i = 0; i < 101; i++){
      if (i==0){
         step_out[i] <== step_in[i] +1;
      } else if (i == step_in[i]){
         step_out[i] <== step_in[0];
      } else {
         step_out[i] <== step_in[i];
      }
   }

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

   verification<==success;
}

template IsZero() {
  signal input in;
  signal output out;

  signal inv;

  inv <-- in!=0 ? 1/in : 0;

  out <== -in*inv +1;
  in*out === 0;
}

template IsEqual() {
    signal input in[2];
    signal output out;

    component isz = IsZero();

    in[1] - in[0] ==> isz.in;

    isz.out ==> out;
}

component main {public [step_in] }= BasicProof();
 