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
   signal input statement[3];
   signal output out;

   var sum = 0;
   for (var i = 0; i < 3; i++){
      sum += statement[i];
   }

   out <== sum;
}

template ModusPonens(){
   signal input reason[6];
   signal output out;

   var sum = 0;
   sum += reason[0]*2;
   sum += reason[4]*2;
   sum += 4;

   out <== sum;
}

template ModusTollens(){
   signal output out;

   out <== 4;
}

template DisjunctiveSyllogism(){
   signal input statement[3];
   signal output out;

   var sum = 0;
   sum += statement[0]*2;
   sum += 2;

   out <== sum;
}

template HypotheticalSyllogism(){
   signal input reason[6];
   signal output out;

   var sum = 0;
   sum += reason[0]*2;
   sum += reason[1]*2;
   sum += reason[4]*2;
   sum += 4*3;

   out <== sum;
}

template Addition(){
   signal input statement[3];
   signal output out;

   var sum = 0;
   sum += statement[0]*2;
   sum += statement[1];
   sum += 3;

   out <== sum;
}

template Simplification(){
   signal input reason[6];
   signal output out;

   var sum = 0;
   sum += reason[0]*2;
   sum += reason[1];
   sum += 2;

   out <== sum;
}

template Conjunction(){
   signal input statement[3];
   signal output out;

   var sum = 0;
   sum += statement[0]*2;
   sum += statement[1]*2;
   sum += 2;

   out <== sum;
}

template Resolution(){
   signal input statement[3];
   signal output out;

   var sum = 0;
   sum += statement[0]*2;
   sum += statement[1]*2;
   sum += 3*4;

   out <== sum;
}
