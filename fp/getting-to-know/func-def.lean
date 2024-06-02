def hello := "Hello"

def lean : String := "Lean"

#eval String.append hello (String.append " " lean)

def add1 (n : Nat) : Nat := n + 1

#eval add1 7

def maximum (n : Nat) (k : Nat) : Nat :=
  if n < k then
    k
  else n

#eval maximum (5 + 8) (2 * 7)

#check (add1)
#check (maximum)

-- exercises
def joinStringsWith (a : String) (b : String) (c : String) : String :=
  String.append b (String.append a c)

#eval joinStringsWith ", " hello lean
#check (joinStringsWith ", ")

-- idk math, sorry
def volume (height : Nat) (width : Nat) (depth : Nat) : Nat :=
  height * width * depth

--

-- type alias ??
def Str : Type := String
def aStr : Str := "Tis a string."

#check (aStr)
#check (Str)


-- it seems like it's not exactly type alias
-- not sure why it would fail to synthesise instance
-- does it mean I'm actually defining a typeclass instance?
def NatNum : Type := Nat
def thirtyEight : NatNum := (38 : Nat)

-- actual type alias
-- which is marked as "reducible"
abbrev N : Type := Nat
def thirtyNine : N := 39
