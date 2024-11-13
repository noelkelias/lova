Require Import rules_of_inference. 

Theorem complex_inference : forall A B C D : Prop,
  (A -> B) -> (B -> C) -> B -> ~B -> (A \/ D) -> (D /\ B).
Proof.
  intros A B C D H1 H2 H3 H4 H5.
  
  assert (HD : D).
  { apply disjunctive_syllogism with (A := A).
    - exact H5.
    - intro HA.
      apply H4.
      apply modus_ponens with (P := A).
      + exact H1.
      + exact HA. }
  
  apply conjunction.
  - exact HD.
  - exact H3.
Qed.