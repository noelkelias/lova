Require Import rules_of_inference.
Require Import test.

Theorem main : forall (b1 b2 : bool),
  (b1 = true \/ b2 = true) -> (b1 = false) -> (b2 = true).
Proof.
  intros b1 b2 Hdisj Hfalse.
  apply disjunctive_syllogism_bool; assumption.
Qed.
