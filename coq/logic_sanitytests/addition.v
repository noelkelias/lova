Require Import Coq.Bool.Bool.

Theorem addition_example : forall A B : Prop, A -> A \/ B.
Proof.
  intros A B H.                   
  Time (left; exact H).          
Qed.
