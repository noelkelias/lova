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
   signal output out;

   component calcTotal = CalculateTotal(3);

   var success = -3;

   calcTotal.nums[0] <== statement[0] - success;
   calcTotal.nums[1] <== statement[1]* success;
   calcTotal.nums[2] <== statement[2] - success;

   out <== calcTotal.sum;
}

template TempSumming(multVal){
   signal input vals[2];
   signal output out;

   out <== vals[0] * vals[1];
}