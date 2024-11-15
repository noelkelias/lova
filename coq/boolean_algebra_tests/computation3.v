Require Import boolean_ops. 

Lemma computation3 : 
  forall A B C D E F G P K L M N Q Y H J : bool,
  A = true -> B = true -> C = true -> D = true ->
  E = true -> F = true -> G = true -> P = true ->
  K = true -> L = true -> M = true -> N = true ->
  H = false -> J = false ->
   boolean_add (boolean_add (boolean_add (boolean_add (boolean_add
   (boolean_add (boolean_add (boolean_add (boolean_add (boolean_add
   (boolean_add (boolean_add (boolean_add (boolean_add (boolean_add
   (boolean_add (boolean_add (boolean_add (boolean_add
   (boolean_mult A B) C) B) B) Q) (boolean_mult B P)) (boolean_mult A P))
   (boolean_mult C P)) (boolean_mult P P)) A) P) (boolean_mult D E)) F) Y)
   (boolean_mult E G)) (boolean_mult D G)) (boolean_mult F G))
   (boolean_mult G G)) D) (boolean_add (boolean_add (boolean_add
   (boolean_mult (boolean_not H) (boolean_not J)) J)
   (boolean_not J)) (boolean_add (boolean_add (boolean_mult K L)
   (boolean_mult K M)) (boolean_mult M N))) = true.
Proof.
  intros A B C D E F G P K L M N Q Y H J
         H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 H13 H14.
  rewrite H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13, H14.
  simpl.
  destruct Q, Y; reflexivity.
Qed.

Example example_call :
   boolean_add (boolean_add (boolean_add (boolean_add (boolean_add
   (boolean_add (boolean_add (boolean_add (boolean_add (boolean_add
   (boolean_add (boolean_add (boolean_add (boolean_add (boolean_add
   (boolean_add (boolean_add (boolean_add (boolean_add
   (boolean_mult true true) true) true) true) true) 
   (boolean_mult true true)) (boolean_mult true true))
   (boolean_mult true true)) (boolean_mult true true)) true) true)
   (boolean_mult true true)) true) false) 
   (boolean_mult true true)) (boolean_mult true true))
   (boolean_mult true true)) (boolean_mult true true)) true)
   (boolean_add (boolean_add 
   (boolean_add (boolean_mult (boolean_not false) (boolean_not false)) false)
   (boolean_not false)) (boolean_add (boolean_add (boolean_mult true true)
   (boolean_mult true true)) (boolean_mult true true))) = true.
Proof.
  apply computation3; reflexivity.
Qed.




