Require Import boolean_ops. 

Lemma computation2 : forall A B C P Q : bool,
  A = true -> B = true -> C = true -> P = true ->
  boolean_add
   (boolean_add (boolean_mult A B) (boolean_add C (boolean_add B  (boolean_add Q  
   (boolean_add (boolean_mult B P)  (boolean_add (boolean_mult A P) 
   (boolean_add (boolean_mult C P) (boolean_add (boolean_mult P P) 
   (boolean_add A P))))))))) (boolean_add A P) = true.

Proof.
  intros A B C P Q H1 H2 H3 H4.
  rewrite H1, H2, H3, H4.
  simpl. 
  reflexivity.
Qed.

Example main :
   boolean_add
   (boolean_add (boolean_mult true true) (boolean_add true (boolean_add true 
   (boolean_add false (boolean_add (boolean_mult true true) (boolean_add (boolean_mult true true) 
   (boolean_add (boolean_mult true true) (boolean_add (boolean_mult true true) 
   (boolean_add true true))))))))) (boolean_add true true) = true.

Proof.
  apply computation2; reflexivity.
Qed.









