Require Import Coq.Bool.Bool.

Theorem conjunction_example : forall A B : Prop, A -> B -> A /\ B.
Proof.
  intros A B H1 H2.             
  Time (split).                  
  - exact H1.                   
  - exact H2.                  
Qed.
