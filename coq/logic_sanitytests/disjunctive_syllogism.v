Theorem disjunctive_syllogism : forall A B : Prop, (A \/ B) -> ~A -> B.
Proof.
  Time intros A B [H1 | H2] H3.
  - contradiction. 
  - assumption. 
Qed.


