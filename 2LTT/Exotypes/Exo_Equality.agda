{-# OPTIONS --without-K --two-level  #-}

module 2LTT.Exotypes.Exo_Equality where


open import 2LTT.Primitive


infix 4 _=ₛᵉ_ 
--Except for HoTT style, we have a strict equality. It's kind a judgmental equality. We call it exo-equality.
--Notation:
-- a =ₛᵉ b means a b are terms of exo-types and they are exo-equal
--NOTE THAT in order to prevent any possible confusion,
--we take the constructor of x =ₛᵉ x as reflₛᵉ while the constructor of x =ₛ x as reflₛ .

--exo(strict)equality for exotypes
data _=ₛᵉ_ {i : Level}{A : UUᵉ i} (x : A) : A → UUᵉ i where
  reflₛᵉ : x =ₛᵉ x

--Uniqueness of Identity Proof for =ₛᵉ
UIPᵉ : {i : Level} {A : UUᵉ i} {x y : A} (p q : x =ₛᵉ y) → p =ₛᵉ q
UIPᵉ reflₛᵉ reflₛᵉ = reflₛᵉ


--Basic Properties of =ₛᵉ
exo-invᵉ : {i : Level} {A : UUᵉ i}{x y : A} → x =ₛᵉ y → y =ₛᵉ x
exo-invᵉ  reflₛᵉ =  reflₛᵉ

exo-concatᵉ : {i : Level} {A : UUᵉ i}{x y z : A} → x =ₛᵉ y → y =ₛᵉ z → x =ₛᵉ z
exo-concatᵉ  reflₛᵉ  reflₛᵉ = reflₛᵉ

exo-left-invᵉ : {i : Level} {A : UUᵉ i} {x y : A} → (p : x =ₛᵉ y) → exo-concatᵉ (exo-invᵉ p) p =ₛᵉ reflₛᵉ
exo-left-invᵉ reflₛᵉ = reflₛᵉ

exo-right-invᵉ : {i : Level} {A : UUᵉ i} {x y : A} → (p : x =ₛᵉ y) → exo-concatᵉ p (exo-invᵉ p) =ₛᵉ reflₛᵉ
exo-right-invᵉ reflₛᵉ = reflₛᵉ

exo-left-unitᵉ : {i : Level} {A : UUᵉ i} {x y : A} → (p : x =ₛᵉ y) → exo-concatᵉ reflₛᵉ p =ₛᵉ p
exo-left-unitᵉ reflₛᵉ = reflₛᵉ

exo-right-unitᵉ : {i : Level} {A : UUᵉ i} {x y : A} → (p : x =ₛᵉ y) → exo-concatᵉ p reflₛᵉ =ₛᵉ p
exo-right-unitᵉ reflₛᵉ = reflₛᵉ

exo-trᵉ : {i j : Level} {A : UUᵉ i} (P : A → UUᵉ j) {x y : A} → x =ₛᵉ y → P x → P y
exo-trᵉ P  reflₛᵉ p = p

exo-tr-elimᵉ : {i j : Level} {A : UUᵉ i} {P : A → UUᵉ j} {x y : A} {p : x =ₛᵉ y}{z z' : P x}
                 → (z =ₛᵉ z') → exo-trᵉ P p z =ₛᵉ exo-trᵉ P p z'
exo-tr-elimᵉ reflₛᵉ = reflₛᵉ

exo-tr-left-lawᵉ : {i j : Level} {A : UUᵉ i} (P : A → UUᵉ j) {x y : A} (p : x =ₛᵉ y) {z : P y}
                   → exo-trᵉ P (exo-concatᵉ (exo-invᵉ p) p) z =ₛᵉ z
exo-tr-left-lawᵉ P reflₛᵉ = reflₛᵉ

exo-tr-right-lawᵉ : {i j : Level} {A : UUᵉ i} (P : A → UUᵉ j) {x y : A}(p : x =ₛᵉ y) {z : P x}
                   → exo-trᵉ P (exo-concatᵉ p (exo-invᵉ p)) z =ₛᵉ z
exo-tr-right-lawᵉ P reflₛᵉ = reflₛᵉ 

exo-tr-concatᵉ : {i j : Level} {A : UUᵉ i} {P : A → UUᵉ j} {x y z : A}
                  (e₁ : x =ₛᵉ y) (e₂ : y =ₛᵉ z) {p : P x}
                → exo-trᵉ P e₂ (exo-trᵉ P e₁ p) =ₛᵉ exo-trᵉ P (exo-concatᵉ e₁ e₂) p
exo-tr-concatᵉ reflₛᵉ reflₛᵉ = reflₛᵉ
{-# INLINE exo-tr-concatᵉ #-}


exo-tr-piᵉ : {i j k : Level}{A : UUᵉ i}{a a' : A}(e : a =ₛᵉ a')
                {B : UUᵉ j} (C : A → B → UUᵉ k) {f : (y : B) → C a y} {y : B}
                 → exo-trᵉ (λ x → (y : B) → C x y) e f y =ₛᵉ exo-trᵉ (λ x → C x y) e (f y)
exo-tr-piᵉ reflₛᵉ C = reflₛᵉ

exo-apᵉ : {i j : Level}{A : UUᵉ i} {B : UUᵉ j} → (f : A → B) {x₁ x₂ : A} → x₁ =ₛᵉ x₂ → f x₁ =ₛᵉ f x₂
exo-apᵉ f  reflₛᵉ = reflₛᵉ

exo-ap2ᵉ : {i j : Level}{A : UUᵉ i} {B : A → UUᵉ j} {C : UUᵉ j} (f : (x : A) → B x → C)
      → {x₁ x₂ : A} {y₁ : B x₁} {y₂ : B x₂}
      → (p : x₁ =ₛᵉ x₂) (q : exo-trᵉ B p y₁ =ₛᵉ y₂)
      → f x₁ y₁ =ₛᵉ f x₂ y₂
exo-ap2ᵉ f  reflₛᵉ reflₛᵉ =  reflₛᵉ


exo-apdᵉ : {i j : Level} {A : UUᵉ i} {P : A → UUᵉ j} (f : (a : A) → P a) {x y : A} (p : x =ₛᵉ y)
            → exo-trᵉ P p (f x) =ₛᵉ f y
exo-apdᵉ f reflₛᵉ = reflₛᵉ

exo-tr-apᵉ : {i j : Level} {A B : UUᵉ i} {f : A → B} {P : B → UUᵉ j} {x₁ x₂ : A} (e : x₁ =ₛᵉ x₂) {p : P (f x₁)}
               → exo-trᵉ (λ x → P (f x)) e p =ₛᵉ exo-trᵉ P (exo-apᵉ f e) p
exo-tr-apᵉ reflₛᵉ =  reflₛᵉ

exo-ap-trᵉ : {i j : Level} {A : UUᵉ i} {P : A → UUᵉ j} {x y : A} {e₁ e₂ : x =ₛᵉ y} {p : P x}
               → e₁ =ₛᵉ e₂ → exo-trᵉ P e₁ p =ₛᵉ exo-trᵉ P e₂ p
exo-ap-trᵉ reflₛᵉ = reflₛᵉ

ap-transportᵉ : {i j : Level} {A : UUᵉ i} {P Q : A → UUᵉ j} {x y : A} (p : x =ₛᵉ y) (f : (x : A) → P x → Q x) (z : P x)
                → f y (exo-trᵉ P p z) =ₛᵉ exo-trᵉ Q p (f x z)
ap-transportᵉ reflₛᵉ f z = reflₛᵉ

tr-fam-apᵉ : {i j : Level} {A : UUᵉ i} {P : A → UUᵉ j} {x y : A} {p : x =ₛᵉ y} {f g : P x → P x}{z : P x}
                 → (f =ₛᵉ g) → exo-trᵉ P p (f z) =ₛᵉ exo-trᵉ P p (g z)
tr-fam-apᵉ reflₛᵉ = reflₛᵉ
