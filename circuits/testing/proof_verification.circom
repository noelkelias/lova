pragma circom 2.0.0;

include "comparators.circom";

template Hypothesis(){
   signal output out;
   out <== 1;
}

template ModusPonens(){
   signal input statement[3];
   signal input reason[6];
   signal output out;

   component calcTotal = CalculateTotal(3);

   var success = 3;

   //Check if A is present and formatted correctly
   component aEqCheck = IsEqual();
   aEqCheck.in[0] <== reason[0];
   aEqCheck.in[1] <== reason[3];

   calcTotal.nums[0] <== aEqCheck.out;

   //Check if implication is valid
   //B is in first reason with >
   component bCheck1 = IsEqual();
   bCheck1.in[0] <== reason[1];
   bCheck1.in[1] <== statement[0];

   component opCheck1 = IsEqual();
   opCheck1.in[0] <== reason[2];
   opCheck1.in[1] <== 4; 

   calcTotal.nums[1] <== bCheck1.out * opCheck1.out;

   //B is second reason with >
   component bCheck2 = IsEqual();
   bCheck2.in[0] <== reason[4];
   bCheck2.in[1] <== statement[0];

   component opCheck2 = IsEqual();
   opCheck2.in[0] <== reason[5];
   opCheck2.in[1] <== 4; 

   calcTotal.nums[2] <== bCheck2.out * opCheck2.out;

   out <== success - calcTotal.sum;
}