Require Import rules_of_inference. 

Theorem test1 : forall P Q R S T : Prop,
  (P -> Q) -> (P -> R) -> (Q -> S) -> (R -> T) -> (P -> (S /\ T)).
Proof.
  intros P Q R S T H1 H2 H3 H4 H5.
    apply conjunction.
  
  - apply (modus_ponens Q S).
    + exact H3. 
    + apply (modus_ponens P Q).
      * exact H1. 
      * exact H5. 
  
  - apply (modus_ponens R T).
    + exact H4. 
    + apply (modus_ponens P R).
      * exact H2. 
      * exact H5. 
Qed.


