Theorem hypothetical_syllogism : forall A B C : Prop, (A -> B) -> (B -> C) -> (A -> C).
Proof.
  Time intros A B C H1 H2 H3.
  apply H2. 
  apply H1.  
  assumption. 
Qed.
