{-# OPTIONS --without-K --two-level  #-}

module 2LTT.Types.Sigma where

open import 2LTT.Primitive
open import 2LTT.Types.Exo_Equality
open import 2LTT.Exotypes.Sigma


--Type formers of dependent pairs for types
record Σ {i j} (A : UU i) (B : A → UU j) : UU (i ⊔ j) where
  constructor _,_
  field
    pr1 : A
    pr2 : B pr1

open Σ public

infixr 4 _,_

--η-law for Σ type
η-law-Σ : {i j : Level}{A : UU i} {B : A → UU j} → (x : Σ A B) → (x =ₛ (pr1 x , pr2 x))
η-law-Σ x = reflₛ

--induction principle for Σ
ind-Σ : {i j k : Level}{A : UU i} {B : A → UU j} {C : Σ A B → UU k}
         → ((x : A) (y : B x) → C (x , y))
         → ((t : Σ A B) → C t)
ind-Σ f (x , y) = f x y

--currying
curry : {i j k : Level}{A : UU i} {B : A → UU j} {C : Σ A B → UU k}
         → ((t : Σ A B) → C t)
         → ((x : A) (y : B x) → C (x , y))
curry f x y = f (x , y)


exo-dep-pair : {i j : Level} {A : UU i} {B : A → UU j} (w w' : Σ A B)
              → UUᵉ (i ⊔ j)
exo-dep-pair w w' = Σᵉ ((pr1 w) =ₛ (pr1 w')) (λ p → (exo-tr _ p (pr2 w)) =ₛ (pr2 w'))

dep-pair-=ₛ :  {i j : Level} {A : UU i} {B : A → UU j} (w w' : Σ A B)
             → (exo-dep-pair w w') → w =ₛ w'
dep-pair-=ₛ (a , b) (.a , .b) (reflₛ , reflₛ) = reflₛ

inv-dep-pair-=ₛ : {i j : Level} {A : UU i} {B : A → UU j} (w w' : Σ A B)
                    → w =ₛ w' → (exo-dep-pair w w')
inv-dep-pair-=ₛ (a , b) (.a , .b) reflₛ = reflₛ , reflₛ

-------------------------------------------------
--Type formers of products for types
_×_ :  {l1 l2 : Level}(A : UU l1) (B : UU l2) → UU (l1 ⊔ l2)
A × B = Σ  A (λ a → B)

exo-pair : {i j : Level} {A : UU i} {B : UU j} (x y : A × B)
              → UUᵉ (i ⊔ j)
exo-pair x y = ((pr1 x) =ₛ (pr1 y)) ×ᵉ ((pr2 x) =ₛ (pr2 y))

pair-=ₛ : {i j : Level} {A : UU i} {B : UU j} (x y : A × B)
            → (exo-pair x y) → (x =ₛ y) 
pair-=ₛ (a , b) (.a , .b) (reflₛ , reflₛ) = reflₛ

inv-pair-=ₛ : {i j : Level} {A : UU i} {B : UU j} (x y : A × B)
                    → x =ₛ y → (exo-pair x y)
inv-pair-=ₛ x .x reflₛ = reflₛ , reflₛ

---------------------------------------------------------------------
