pragma circom 2.0.0;

template NovaTest() {
    signal input a;
    signal input step_in;
    signal output step_out;
    step_out <== a*step_in;
 }

 component main {public [step_in] }= NovaTest();
 