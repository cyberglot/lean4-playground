structure PPoint (α : Type) where
  x : α
  y : α
deriving Repr

def natOrigin : PPoint Nat :=
  { x := Nat.zero, y := Nat.zero }

-- ok, I can make α implicit just like in agda
def replaceX {α : Type} (point : PPoint α) (newX : α) : PPoint α :=
  { point with x := newX }

#check (replaceX)

-- I cannot pass in implicit args?
-- #check replaceX {Nat}

#check replaceX natOrigin 5

#eval replaceX natOrigin 5

inductive Sign where
  | pos
  | neg

-- interesting liquid haskell vibes
def posOrNegThree (s : Sign) :
  match s with | Sign.pos => Nat | Sign.neg => Int :=
  match s with
  | Sign.pos => (3 : Nat)
  | Sign.neg => (-3 : Int)

def primesUnder10 : List Nat := [2, 3, 5, 7]

inductive List' (α : Type) where
  | nil : List' α
  | cons : α → List' α → List' α

def explicitPrimesUnder10 : List Nat :=
  List.cons 2 (List.cons 3 (List.cons 5 (List.cons 7 List.nil)))

#eval explicitPrimesUnder10

def length (α : Type) (xs : List α) : Nat :=
  match xs with
  | List.nil => Nat.zero
  | List.cons _ ys => Nat.succ (length α ys)

def length' (α : Type) (xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (length α ys)

-- I see, you need to properly name the type variable
#check List.length (α := Int)
#check replaceX (α := Nat)

inductive Maybe (α : Type) : Type where
  | nothing : Maybe α
  | just (val : α) : Maybe α

def List.head'? {α : Type} (xs : List α) : Maybe α :=
  match xs with
  | [] => Maybe.nothing
  | y :: _ => Maybe.just y

#eval ([] : List Int).head?

structure Product (α : Type) (β : Type) : Type where
  fst : α
  snd : β

def fives : String × Int := { fst := "five", snd := 5 }
def sevens : String × Int × Nat := ("VII", 7, 4 + 3)
def sevens' : String × (Int × Nat) := ("VII", (7, 4 + 3))

inductive Sum' (α : Type) (β : Type) : Type where
  | inl : α → Sum' α β
  | inr : β → Sum' α β

def PetName : Type := String ⊕ String

def animals : List PetName :=
  [Sum.inl "Spot", Sum.inr "Tiger", Sum.inl "Fifi", Sum.inl "Rex", Sum.inr "Floof"]

def howManyDogs (pets : List PetName) : Nat :=
  match pets with
  | [] => 0
  | Sum.inl _ :: morePets => howManyDogs morePets + 1
  | Sum.inr _ :: morePets => howManyDogs morePets

inductive Unit' : Type where
  | unit : Unit'

inductive ArithExpr (ann : Type) : Type where
  | int : ann → Int → ArithExpr ann
  | plus : ann → ArithExpr ann → ArithExpr ann → ArithExpr ann
  | minus : ann → ArithExpr ann → ArithExpr ann → ArithExpr ann
  | times : ann → ArithExpr ann → ArithExpr ann → ArithExpr ann

-- exercises

def last { α : Type } (list : List α) : Option α :=
  match list with
  | [] => Option.none
  | x :: [] => Option.some x
  | _ :: xs => last xs

def List.findFirst? {α : Type} (xs : List α) (predicate : α → Bool) : Option α :=
  match xs with
  | [] => Option.none
  | x :: xs => if predicate x
               then Option.some x
               else List.findFirst? xs predicate

def Prod.swap {α β : Type} (pair : α × β) : β × α :=
  { fst := pair.snd, snd := pair.fst }

inductive PetName2 : Type where
  | fst : String -> PetName2
  | sur : String -> PetName2

def PetNameToPetName2 (pn : PetName) : PetName2 :=
  match pn with
  | Sum.inl n => PetName2.fst n
  | Sum.inr n => PetName2.sur n

def elimination {a : Type} {b : Type} {c : Type} (f : a -> c) (g : b -> c) (x : a ⊕ b)  : c :=
  match x with
  | Sum.inl y => f y
  | Sum.inr z => g z

def PetName2ToPetName (pn : PetName2) : PetName :=
  match pn with
  | PetName2.fst n => Sum.inl n
  | PetName2.sur n => Sum.inr n

def zip {α β : Type} (xs : List α) (ys : List β) : List (α × β) :=
  match (xs, ys) with
  | ([], _) => []
  | (_, []) => []
  -- can't detect structural reduction :(
  | (x :: xs', y :: ys') => (x, y) :: zip xs' ys'

def zip' {α β : Type} (xs : List α) (ys : List β) : List (α × β) :=
  match xs with
  | [] => []
  | x :: xs' => match ys with
                | [] => []
                | y :: ys' => (x, y) :: zip' xs' ys'

def take {a : Type} (n : Nat)  (xs : List a) : List a :=
  match n with
  | Nat.zero => []
  | Nat.succ n => match xs with
                | [] => []
                | x :: xs' => x :: take n xs'

#eval take 3 ["bolete", "oyster"]
#eval take 1 ["bolete", "oyster"]

-- proof of distributivity of + *
def dist1 (lhs : α × (β ⊕ γ)) : (α × β) ⊕ (α × γ) :=
  match lhs.snd with
  | Sum.inl b => Sum.inl { fst := lhs.fst , snd := b }
  | Sum.inr c => Sum.inr { fst := lhs.fst , snd := c }

def dist2 (lhs :(α × β) ⊕ (α × γ)) : α × (β ⊕ γ) :=
match lhs with
| Sum.inl ab => { fst := ab.fst , snd := Sum.inl ab.snd }
| Sum.inr ac => { fst := ac.fst , snd := Sum.inr ac.snd }

-- proof of a * 2 = a + a
def forw (lhs : Bool × α) : α ⊕ α :=
  match lhs.fst with
  | true => Sum.inl lhs.snd
  | false => Sum.inr lhs.snd

def back (lhs : α ⊕ α) : Bool × α :=
  match lhs with
  | Sum.inl a => { fst := true, snd := a }
  | Sum.inr a => { fst := false, snd := a }
