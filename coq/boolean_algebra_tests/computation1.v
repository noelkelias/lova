Require Import boolean_ops. 

(* (A + B)C if A&C *)
Lemma computation1 : forall A B : bool,
  A = true -> (boolean_mult (boolean_add A B) true) = true.
Proof.
  intros A B H1.
  rewrite H1.
  simpl.
  simpl.
  reflexivity.
Qed.

Example main : boolean_mult (boolean_add true false) true = true.
Proof.
  apply computation1; reflexivity.
Qed.



