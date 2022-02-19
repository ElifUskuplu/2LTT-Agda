{-# OPTIONS --without-K --two-level --cumulativity #-}

module 2LTT.Cofibration.isCofibrant where

open import 2LTT.Coercion.Fibrant_Conversion public

---Trival but necessary conversion of exo-types 
=ₛ-to-=ₛᵉ : {i : Level} {A : UU i} {a b : A} → a =ₛ b → a =ₛᵉ b
=ₛ-to-=ₛᵉ reflₛ = reflₛᵉ

=ₛᵉ-to-=ₛ : {i : Level} {A : UU i} {a b : A} → a =ₛᵉ b → a =ₛ b
=ₛᵉ-to-=ₛ reflₛᵉ = reflₛ
------------------------------------------------

--For f : A → B , being fibration 
isFibration : {i j : Level} {A : UUᵉ i} {B : UUᵉ j}(f : A → B) → UUᵉ (lsuc i ⊔ lsuc j)
isFibration {i} {j} {A} {B} f = (b : B) → isFibrant {i ⊔ j} (Σᵉ A (λ a → f a =ₛᵉ b))

--For exo-type B, being cofibrant at Y : B → UU j
record isCofibrant-at {i : Level} (B : UUᵉ i) (j : Level) (Y : B → UU j) : SSetω where
    eta-equality
    constructor iscofibrant-at
    field 
      Π-fibrant-witness : isFibrant (Πᵉ B Y)
      contr-preserve-witness : Πᵉ B (λ b → is-contr (Y b))
                           → let (isfibrant fr fw) = Π-fibrant-witness in (is-contr fr)

isCofibrant : {i : Level} (B : UUᵉ i) →  SSetω
isCofibrant B = (j : Level) → (Y : B → UU j) → isCofibrant-at B j Y

is-Fibrant-Cofibrant : {i : Level}(B : UU i) →  isCofibrant {i} B
is-Fibrant-Cofibrant {i} B j Y = iscofibrant-at (isfibrant (Π B Y) ≅-refl)                                                                  
                                                        λ K → Π-type-contr λ a → K a

is-Fibrant-Cofibrant' : {i : Level}(B : UUᵉ i) → isFibrant {i} B → isCofibrant {i} B
is-Fibrant-Cofibrant' {i} B (isfibrant fr (f , g , gf , fg)) j Y = iscofibrant-at
                                                        (isfibrant (Π {i} {j} fr (λ a → Y (f a)))
                                                         ((λ x b → exo-trᵉ {i} {j} Y (happlyₛᵉ {i} {i} fg b) (x (g b))) ,
                                                          (λ x fb → x (f fb)) ,
                                                          funextₛᵉ {i ⊔ j} {i ⊔ j} (λ x → funextₛᵉ {i} {j}
                                                          (λ y → exo-concatᵉ
                                                                   (exo-ap-trᵉ (UIPᵉ (happlyₛᵉ {i} {i} fg (f y))
                                                                                     (exo-apᵉ {i} {i} f (happlyₛᵉ {i} {i} gf y))))
                                                                   (exo-concatᵉ
                                                                       (exo-invᵉ (exo-tr-apᵉ (happlyₛᵉ {i} {i} gf y)))
                                                                       (exo-apdᵉ {i} {j} x (happlyₛᵉ {i} {i} gf y))))) ,
                                                          funextₛᵉ {i ⊔ j} {i ⊔ j}
                                                             (λ x → funextₛᵉ (λ y → exo-apdᵉ {i} {j} x (happlyₛᵉ fg y)))))
                                                         λ K → Π-type-contr {i} {j} λ a → K (f a)
                                                                              
isCofibrant-iso : {i : Level}{A B : UUᵉ i}
              → A ≅ B → isCofibrant {i} A
              → isCofibrant {i} B
isCofibrant-iso {i} {A} {B} (f , g , gf , fg) P
  = λ k Y → let (iscofibrant-at (isfibrant frA (u , v , vu , uv)) cpwA) = (P k (λ a → Y (f a)))
             in iscofibrant-at
                (isfibrant frA
                  ((λ x b → exo-trᵉ {i} {k} Y (happlyₛᵉ {i} {i} fg b) ((u x)(g b))) ,
                   (λ x → v (λ a → x (f a))) ,
                   funextₛᵉ {i ⊔ k} {i ⊔ k}
                    (λ x → exo-concatᵉ (exo-apᵉ {i ⊔ k} {i ⊔ k} {Πᵉ {i} {k} A (λ a → Y (f a))} {frA} v
                                                {λ a →  exo-trᵉ {i} {k} Y (happlyₛᵉ {i} {i} fg (f a)) ((u x) (g (f a)))} {u x}
                                        (funextₛᵉ {i} {k}
                                          (λ a → exo-concatᵉ
                                                   (exo-ap-trᵉ (UIPᵉ (happlyₛᵉ {i} {i} fg (f a)) (exo-apᵉ {i} {i} f (happlyₛᵉ {i} {i}  gf a))))
                                                   ((exo-concatᵉ (exo-invᵉ (exo-tr-apᵉ (happlyₛᵉ {i} {i} gf a)))
                                                                 (exo-apdᵉ {i} {k} (u x) (happlyₛᵉ {i} {i} gf a)))))))
                                        ((happlyₛᵉ {i ⊔ k} {i ⊔ k} vu x))) ,
                   funextₛᵉ {i ⊔ k} {i ⊔ k} (λ x → funextₛᵉ {i ⊔ k} {k}
                                                     λ b → exo-concatᵉ
                                                                (exo-tr-elimᵉ {i} {k} {B} {Y} {f (g b)} {b} {happlyₛᵉ fg b}
                                                                     (happlyₛᵉ (happlyₛᵉ {i ⊔ k} {i ⊔ k} uv (λ a → x (f a))) (g b)))
                                                                (exo-apdᵉ {i} {k} x (happlyₛᵉ {i} {i} fg b)) )))
                λ K → cpwA λ a → K (f a)
                           

⊥ᵉ-is-cofibrant : isCofibrant ⊥ᵉ
⊥ᵉ-is-cofibrant = λ k Y → iscofibrant-at
                            (isfibrant
                                ⊤
                                ((λ x x₁ → ex-falsoᵉ x₁) ,
                                (λ x → star) ,
                                reflₛᵉ ,
                                funextₛᵉ {k} {k} (λ x → (funextₛᵉ (λ x₁ → ex-falsoᵉ x₁)))))
                            λ K → star , λ {star → refl}


⊤ᵉ-is-cofibrant : isCofibrant ⊤ᵉ
⊤ᵉ-is-cofibrant = λ k Y → iscofibrant-at
                            (isfibrant
                                (Π ⊤ λ {star → Y starᵉ})
                                ((λ x → λ {starᵉ → x star}) ,
                                (λ x → λ {star → x starᵉ}) ,
                                reflₛᵉ , reflₛᵉ) )
                            λ K → Π-type-contr (λ {star → K starᵉ})


+ᵉ-preserve-Cofibrant : {i j : Level}{A : UUᵉ i}{B : UUᵉ j}
                               → isCofibrant {i} A → isCofibrant {j} B
                               → isCofibrant {i ⊔ j} (A +ᵉ B)
+ᵉ-preserve-Cofibrant {i} {j} {A} {B} P Q k Y
    = let (iscofibrant-at (isfibrant frA (f , g , gf , fg)) cpwA) =  (P k (λ x → Y (inlᵉ x))) 
          (iscofibrant-at (isfibrant frB (u , v , vu , uv)) cpwB) =  (Q k (λ x → Y (inrᵉ x)))
      in iscofibrant-at
                   (isfibrant (_×_ {i ⊔ k} {j ⊔ k} frA frB)
                           ((λ (x , y) → λ {(inlᵉ a) → f x a ; (inrᵉ b) → u y b}) ,
                            (λ w → (g (λ a → w (inlᵉ a)) , v (λ b → w (inrᵉ b)))) ,
                            (funextₛᵉ {i ⊔ j ⊔ k} {i ⊔ j ⊔ k} λ (x , y) → =ₛ-to-=ₛᵉ (pair-=ₛ {i ⊔ k} {j ⊔ k} (g (f x) , v (u y)) (x , y)
                                                             (=ₛᵉ-to-=ₛ (happlyₛᵉ gf x) ,
                                                              =ₛᵉ-to-=ₛ (happlyₛᵉ vu y)))),
                            funextₛᵉ {i ⊔ j ⊔ k} {i ⊔ j ⊔ k} (λ w → funextₛᵉ {i ⊔ j} {k}
                                                               λ {(inlᵉ a) → happlyₛᵉ (happlyₛᵉ {i ⊔ k} {i ⊔ k} fg (w ∘ᵉ inlᵉ)) a ;
                                                                  (inrᵉ b) → happlyₛᵉ (happlyₛᵉ {j ⊔ k} {j ⊔ k} uv (w ∘ᵉ inrᵉ)) b} )))  
                   (λ K → (×-contr-is-contr {i ⊔ k} {j ⊔ k} {frA} {frB}
                                              (cpwA (λ x → K (inlᵉ x))) (cpwB (λ x → K (inrᵉ x)))))



Σᵉ-preserve-Cofibrant : {i j : Level}{A : UUᵉ i}{B : A → UUᵉ j}
                        → isCofibrant {i} A → ((a : A) → isCofibrant {j} (B a))
                        → isCofibrant {i ⊔ j} (Σᵉ A B)
Σᵉ-preserve-Cofibrant {i} {j} {A} {B} P Q
    = λ k Y → let (iscofibrant-at (isfibrant frA (u , v , vu , uv)) cpwA)
                     = ((P (j ⊔ k) (λ a → let (iscofibrant-at (isfibrant frBa fwBa) cpwBa) = ((Q a) k (λ b → Y (a , b))) in frBa))) ;
                   frB  = λ a → let (iscofibrant-at (isfibrant frBa fwBa) cpwBa) = ((Q a) k (λ b → Y (a , b))) in frBa ;
                   fwB  = λ a → let (iscofibrant-at (isfibrant frBa fwBa) cpwBa) = ((Q a) k (λ b → Y (a , b))) in fwBa ;
                   cpwB  = λ a → let (iscofibrant-at (isfibrant frBa fwBa) cpwBa) = ((Q a) k (λ b → Y (a , b))) in cpwBa 
           in iscofibrant-at
                    (isfibrant frA
                               ((λ s → λ {(a , b) → let (fₐ , gₐ , gfₐ , fgₐ) = fwB a
                                                      in fₐ ((u s) a) b}),
                               (λ t → v (λ a → let (fₐ , gₐ , gfₐ , fgₐ) = fwB a
                                                  in (gₐ (λ b → t (a , b))))) ,
                               funextₛᵉ {i ⊔ j ⊔ k} {i ⊔ j ⊔ k}
                                       (λ s → exo-concatᵉ (exo-apᵉ {i ⊔ j ⊔ k} {i ⊔ j ⊔ k} v
                                                                   (funextₛᵉ {i} {j ⊔ k}
                                                                     (λ a → let (fₐ , gₐ , gfₐ , fgₐ) = fwB a
                                                                             in happlyₛᵉ gfₐ ((u s) a))))
                                                          (happlyₛᵉ vu s)) ,
                               funextₛᵉ {i ⊔ j ⊔ k} {i ⊔ j ⊔ k}
                                        (λ t → funextₛᵉ  {i ⊔ j} {k}
                                               (λ {(a , b) → let (fₐ , gₐ , gfₐ , fgₐ) = fwB a
                                                              in exo-concatᵉ
                                                               (exo-apᵉ {i ⊔ j ⊔ k} (λ (X : Πᵉ {i} {j ⊔ k} A (λ a → (frB a))) → fₐ (X a) b)
                                                                       (happlyₛᵉ uv (λ a' → let (fₐ' , gₐ' , gfₐ' , fgₐ') = fwB a'
                                                                                             in gₐ' (λ b' → t (a' , b'))) ))
                                                               (Πᵉ-elim-cong {j} {k} reflₛᵉ (happlyₛᵉ fgₐ (λ b' → t (a , b'))))}))))
                    (λ K → cpwA (λ a → (cpwB a) λ b → K (a , b)))


×ᵉ-preserve-Cofibrant : {i j : Level}{A : UUᵉ i}{B : UUᵉ j}
                               → isCofibrant {i} A → isCofibrant {j} B
                               → isCofibrant {i ⊔ j} (A ×ᵉ B)
×ᵉ-preserve-Cofibrant {i} {j} {A} {B} P Q = Σᵉ-preserve-Cofibrant {i} {j} {A} {λ _ → B} P (λ _ → Q)

 
