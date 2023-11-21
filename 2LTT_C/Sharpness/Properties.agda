{-# OPTIONS --without-K --exact-split --two-level #-}

module 2LTT_C.Sharpness.Properties where

open import 2LTT_C.Sharpness.isSharp public


----Sharpness preserved under exo-isomorphisms.
isSharp-iso : {i k : Level}{A B : UUᵉ i}
              → A ≅ B → isSharp {i} A k
              → isSharp {i} B k
isSharp-iso {i} {k} {A} {B} (F ,ᵉ G ,ᵉ GF ,ᵉ FG) (issharp cfwA frA ftA precomp)
    = issharp
        (isCofibrant-iso (F ,ᵉ G ,ᵉ GF ,ᵉ FG) cfwA)
        frA
        (λ x → ftA (G x))
        λ Y  → precomp-equiv.map3-isequiv {Y}
  where
   module precomp-equiv {Y : frA → UU k} where
    pi-type1 : UUᵉ (i ⊔ k)
    pi-type1 = C (Π frA Y)

    pi-type2 : UUᵉ (i ⊔ k)
    pi-type2 = Πᵉ A (λ x → C (Y (ftA x)))

    pi-type3 : UUᵉ (i ⊔ k)
    pi-type3 = Πᵉ B (λ x → C (Y (ftA (G x))))

    fibrant1 : isFibrant (pi-type1)
    fibrant1 = isfibrant (Π frA Y) ≅-refl

    fibrant2 : isFibrant (pi-type2)
    fibrant2 = isCofibrant-at.Π-fibrant-witness (cfwA (λ x → Y (ftA x)))

    fibrant3 : isFibrant (pi-type3)
    fibrant3 = isCofibrant-at.Π-fibrant-witness (isCofibrant-iso {i} {k} (F ,ᵉ G ,ᵉ GF ,ᵉ FG) cfwA (λ x → Y (ftA (G x))))

    map1 : pi-type1 → pi-type2
    map1 (c X) = λ a → c (X (ftA a))

    map1-isequiv : Fib-isEquiv fibrant1 fibrant2 map1
    map1-isequiv = precomp Y

    map2 : pi-type2 → pi-type3
    map2 X = λ b → X (G b)

    map2-isequiv : Fib-isEquiv fibrant2 fibrant3 map2
    map2-isequiv = Iso-to-Fib-isEquiv {i ⊔ k} {i ⊔ k} {A = pi-type2} {B = pi-type3} fibrant2 fibrant3 map2
                                                      ((λ X a → exo-tr {i} {k} (λ x → C (Y (ftA x))) (GF a) (X (F a))) ,ᵉ
                                                       (λ X → funextᵉ λ a → exo-apd {i} {k} X (GF a)) ,ᵉ
                                                       (λ X → funextᵉ λ b → exo-concat
                                                                              (exo-concat (exo-ap-tr {i} {k} {A} {λ x → C (Y (ftA x))}
                                                                               {G (F (G b))} {G b} {GF (G b)}
                                                                               {exo-ap G (FG b)} {_} (UIPᵉ _ _))
                                                                               (exo-inv (exo-tr-ap {i} {k} (FG b) {X (F (G b))})))
                                                                              (exo-apd {i} {k} X (FG b))))

    map3 : pi-type1 → pi-type3
    map3 (c X) = λ b → c (X (ftA (G b)))

    trivial-htpy : (X : pi-type1) → (map2 ∘ᵉ map1) X =ᵉ map3 X
    trivial-htpy X = reflᵉ

    map3-isequiv : Fib-isEquiv fibrant1 fibrant3 map3
    map3-isequiv = Fib-htpy-to-isEquiv {i ⊔ k} {i ⊔ k} {pi-type1} {pi-type3}
                                                         fibrant1 fibrant3
                                                         (map2 ∘ᵉ map1) map3
                                                         trivial-htpy
                                                         (Fib-comp-isEquiv {i ⊔ k} {i ⊔ k} {i ⊔ k}
                                                                           {pi-type1} {pi-type2} {pi-type3}
                                                                           fibrant1 fibrant2 fibrant3
                                                                           map1 map2 map1-isequiv map2-isequiv)
