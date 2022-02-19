{-# OPTIONS --without-K --two-level #-}

module 2LTT.Types.Functions where

open import 2LTT.Primitive 
open import 2LTT.Types.Exo_Equality
open import 2LTT.Types.Sigma

--Functions in Universe
id : {i : Level}{A : UU i} → (A → A)
id {A} a = a

_∘_ : {i j k : Level}
    → {A : UU i} {B : A → UU j} {C : (a : A) → B a → UU k}
    → ({a : A} → (b : B a) → C a b) → (f : (a : A) → B a) → (a : A) → C a (f a)
(g ∘ f) a = g (f a)

happlyₛ : {i j : Level} {A : UU i} {B : A → UU j} {f g : (x : A) → B x}
         → f =ₛ g → (∀ x → f x =ₛ g x) 
happlyₛ reflₛ x = reflₛ

postulate
  funextₛ : {i j : Level} {A : UU i} {B : A → UU j} {f g : (x : A) → B x}
          → (∀ x → f x =ₛ g x) → f =ₛ g

--------------------------------------------------------
