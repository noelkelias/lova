pragma circom 2.0.0;

include "/Users/nk-mac/circom/node_modules/circomlib/circuits/comparators.circom";

// This circuit returns the sum of the inputs.
// n must be greater than 0.
template CalculateTotal(n) {
    signal input nums[n];
    signal output sum;

    signal sums[n];
    sums[0] <== nums[0];

    for (var i=1; i < n; i++) {
        sums[i] <== sums[i - 1] + nums[i];
    }

    sum <== sums[n - 1];
}

template Hypothesis(){
   signal output out;
   out <== 1;
}

template ModusPonens(){
   signal input statement[3];
   signal input reason[6];

   signal output out;

   var sum = 0;
   for (var i = 0; i < 3; i++){
      sum += statement[0];
   }

   for (var i = 0; i < 6; i++){
      sum += reason[0];
   }

   out <== sum/2;
}

template ModusTollens(){
   signal input statement[3];
   signal input reason[6];

   signal output out;

   var sum = 0;
   for (var i = 0; i < 3; i++){
      sum += statement[0];
   }

   for (var i = 0; i < 6; i++){
      sum += reason[0];
   }

   out <== sum;
}

template DisjunctiveSyllogism(){
   signal input statement[3];
   signal input reason[6];

   signal output out;

   var sum = 0;
   for (var i = 0; i < 3; i++){
      sum += statement[0];
   }

   for (var i = 0; i < 6; i++){
      sum += reason[0];
   }

   out <== sum;
}

