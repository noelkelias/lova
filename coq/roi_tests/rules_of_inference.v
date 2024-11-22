Require Import Coq.Bool.Bool.

(* conjuction: if A and B, then A&B *)
Theorem conjunction : forall A B : Prop, A -> B -> A /\ B.
Proof.
  intros A B H1 H2.              
  split.                 
  - exact H1.                  
  - exact H2.                
Qed.

(* Addition: if A then A|B *)
Theorem addition : forall A B : Prop, A -> (A \/ B).
Proof.
  intros A B H1.
  left. 
  assumption.
Qed.

(* Modus Ponens: If P implies Q and P is true, then Q is true *)
Theorem modus_ponens : forall P Q : Prop,
  (P -> Q) -> P -> Q.
Proof.
  intros P Q H1 H2.
  apply H1 in H2.
  assumption.
Qed.

(*disjunctive_syllogism: A|B and !A --> B*)
Theorem disjunctive_syllogism : forall A B : Prop, (A \/ B) -> ~A -> B.
Proof.
  intros A B [H1 | H2] H3.
  - contradiction. 
  - assumption. 
Qed.

(*Hypothetical Syllogism: A-->B and B-->C, then A-->C *)
Theorem hypothetical_syllogism : forall A B C : Prop, (A -> B) -> (B -> C) -> (A -> C).
Proof.
  intros A B C H1 H2 H3.
  apply H2.  
  apply H1.  
  assumption.
Qed.

(*Modus Tollens: If !B and A-->B, then !A*)
Theorem modus_tollens : forall A B : Prop, (A -> B) -> ~B -> ~A.
Proof.
  intros A B H1 H2 H3.
  apply H2.  
  apply H1. 
  assumption.
Qed.

(*Simplification: A&B --> A*)
Theorem simplification : forall A B : Prop, (A /\ B) -> A.
Proof.
  intros A B H.
  destruct H as [H1 H2]. 
  exact H1. 
Qed.

