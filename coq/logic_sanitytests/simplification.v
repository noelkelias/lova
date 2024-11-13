Theorem simplification : forall A B : Prop, (A /\ B) -> A.
Proof.
  Time intros A B H.
  destruct H as [H1 H2]. 
  exact H1. 
Qed.




