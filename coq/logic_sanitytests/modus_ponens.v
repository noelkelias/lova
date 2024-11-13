Theorem modus_ponens : forall A B : Prop, (A -> B) -> A -> B.
Proof.
  Time intros A B H1 H2.
  apply H1.  
  assumption.
Qed.
