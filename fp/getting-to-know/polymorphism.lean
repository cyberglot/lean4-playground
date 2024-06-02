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
