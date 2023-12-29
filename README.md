# Verifying Mathematical Proofs with Nova

Efficiently verifying mathematical proofs and computation has been a heavily researched topic within Computer Science. Particularly, as proofs become larger, even repetitive statements become much more complex on the prover side and inefficient for verifiers. To solve this problem, we can view this problem through the lens of the Incrementally Verifiable Computation (IVC) and utilize the novel Nova folding scheme that can combine multiple instances into a single folded instance. This repository provides the code of the implementation of a novel pipeline that utilizes this high-speed recursive SNARK, Nova, to develop a scheme with linear prover time, constant verifying capability, dynamic/easy modification, and privacy to efficiently validate mathematical proofs. 

## Methodology
To achieve such a feat using Nova for mathematical proofs we utilized the following pipeline described in the methodology below. Particularly, the mathematical proofs were first validated for formatting. Then the proof was sliced into independent sections: each with the statements, logic rules, and previous lines that were utilized. Third, the mathematical proof slices were converted in linear constraints based on a proof circuit. Utilizing a multiplexing approach, each instance calculated the necessary sums for all logic rules before conducting the necessary checks as indicated by the logic rule signal. Lastly, each of these linear instances were folded utilizing Nova and converted into a "recursive SNARK". To provide further proof compression, this SNARK was then utilized to form another smaller SNARK using the Spartan SNARK proof system. A diagram is found below. 
![alt text](misc/imgs/workflow.png)


