inductive Bool' where
  | false : Bool'
  | true : Bool'

-- Recursive sum types are called inductive datatypes

inductive Nat' where
  | zero : Nat'
  | succ (n : Nat') : Nat'

def isZero (n : Nat) : Bool :=
  match n with
    | Nat.zero => true
    | Nat.succ _ => false

def pred (n : Nat) : Nat :=
  match n with
    | Nat.zero => Nat.zero
    | Nat.succ k => k

def even (n : Nat) : Bool :=
  match n with
    | Nat.zero => true
    | Nat.succ k => not (even k)

def evenLoops (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => not (evenLoops k)

def plus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => n
  | Nat.succ k' => Nat.succ (plus n k')

def times (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => Nat.zero
  | Nat.succ k' => plus n (times n k')

def minus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => n
  | Nat.succ k' => pred (minus n k')

def div (n : Nat) (k : Nat) : Nat :=
  if n < k then
  0
  else Nat.succ (div (n - k) k)
