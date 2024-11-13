Require Import rules_of_inference. 

Theorem complex_proof : forall P Q R S : Prop,
  (((P -> Q) /\ (R -> S)) /\ ((P \/ R) /\ P /\ R)) -> (S /\ Q).
Proof.
  intros P Q R S H.
  destruct H as [H1 H2].
  destruct H1 as [H3 H4].
  destruct H2 as [H5 [H6 H7]].
  
  assert (HS : S).
  { apply (modus_ponens R S). 
    - exact H4.
    - exact H7. }
  
  assert (HQ : Q).
  { apply (modus_ponens P Q).
    - exact H3.
    - exact H6. }
  
  apply conjunction.
  - exact HS.
  - exact HQ.
Qed.