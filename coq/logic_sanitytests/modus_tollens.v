Theorem modus_tollens : forall A B : Prop, (A -> B) -> ~B -> ~A.
Proof.
  Time intros A B H1 H2 H3.
  apply H2.  
  apply H1.  
  assumption. 
Qed.
