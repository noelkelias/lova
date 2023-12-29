pragma circom 2.1.6;

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

template Premise(){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = 0;
   for (var i = 0; i < 3; i++){
      statementSum += statement[i];
   }
   //Test2
   var reasonSum = 0;

   //Test3
   var proofSum = statementSum;

   out <== [statementSum, reasonSum, proofSum];
}

template ModusPonens(arrow){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = reason[4];

   //Test2
   var reasonSum = 0;
   reasonSum += reason[0]*2;
   reasonSum += statement[0];
   reasonSum += arrow;

   //Test3
   var proofSum = 0;
   proofSum += reason[3]*2;
   proofSum += reason[4]*2;
   proofSum += arrow;

   out <== [statementSum, reasonSum, proofSum];
}

template ModusTollens(arrow){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = statement[0];

   //Test2
   var reasonSum = 0;
   reasonSum += reason[3];
   reasonSum += arrow;

   //Test3
   var proofSum = arrow;

   out <== [statementSum, reasonSum, proofSum];
}

template DisjunctiveSyllogism(or){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = reason[1];

   //Test2
   var reasonSum = 0;
   reasonSum += statement[0];
   reasonSum += or;

   //Test3
   var proofSum = 0;
   proofSum += reason[1] *2;
   proofSum += or;

   out <== [statementSum, reasonSum, proofSum];
}

template HypotheticalSyllogism(arrow){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = 0;
   statementSum += reason[0];
   statementSum += reason[4];
   statementSum += arrow;

   //Test2
   var reasonSum = 0;
   reasonSum += statement[0];
   reasonSum += statement[1];
   reasonSum += reason[1]*2;
   reasonSum += arrow*2;

   //Test3
   var proofSum = 0;
   proofSum += statement[0]*2;
   proofSum += reason[1]*2;
   proofSum += reason[4]*2;
   proofSum += arrow*3;

   out <== [statementSum, reasonSum, proofSum];
}

template Addition(or){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = 0;
   statementSum += reason[0];
   statementSum += or;
   statementSum += statement[1];

   //Test2
   var reasonSum = 0;
   reasonSum += statement[0];

   //Test3
   var proofSum = 0;
   proofSum += reason[0]*2;
   proofSum += statement[1];
   proofSum += or;

   out <== [statementSum, reasonSum, proofSum];
}

template Simplification(and){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = 0;
   statementSum += reason[0];

   //Test2
   var reasonSum = 0;
   reasonSum += statement[0];
   reasonSum += reason[1];
   reasonSum += and;

   //Test3
   var proofSum = 0;
   proofSum += statement[0]*2;
   proofSum += reason[1];
   proofSum += and;

   out <== [statementSum, reasonSum, proofSum];
}

template Conjunction(and){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = 0;
   statementSum += reason[0];
   statementSum += reason[3];
   statementSum += and;

   //Test2
   var reasonSum = 0;
   reasonSum += statement[0];
   reasonSum += statement[1];

   //Test3
   var proofSum = 0;
   proofSum += statement[0]*2;
   proofSum += reason[3]*2;
   proofSum += and;

   out <== [statementSum, reasonSum, proofSum];
}

template Resolution(or){
   signal input statement[3];
   signal input reason[6];
   signal output out[3];

   //Test1
   var statementSum = 0;
   statementSum += reason[1];
   statementSum += reason[4];
   statementSum += or;

   //Test2
   var reasonSum = 0;
   reasonSum += statement[0];
   reasonSum += statement[1];
   reasonSum += or*2;

   //Test3
   var proofSum = 0;
   proofSum += statement[0]*2;
   proofSum += reason[4]*2;
   proofSum += or*3;

   out <== [statementSum, reasonSum, proofSum];
}
