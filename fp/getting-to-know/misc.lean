def length {α : Type} (xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (length ys)

def length' (xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (length' ys)

def length'' : List α → Nat
  | [] => 0
  | _ :: ys => Nat.succ (length'' ys)

-- wait wait wait, let me re-try zip what went wrong previously
def zip : List α -> List β  -> List (α × β)
  | [], _ => []
  | _, [] => []
  | x :: xs', y :: ys' => (x, y) :: zip xs' ys'

def drop : Nat → List α → List α
  | Nat.zero, xs => xs
  | _, [] => []
  | Nat.succ n, _ :: xs => drop n xs

def fromOption (default : α) : Option α → α
  | none => default
  | some x => x

def unzip : List (α × β) → List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    (x :: (unzip xys).fst, y :: (unzip xys).snd)

def unzip' : List (α × β) → List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    let unzipped : List α × List β := unzip' xys
    (x :: unzipped.fst, y :: unzipped.snd)

def unzip'' : List (α × β) → List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    let (xs, ys) : List α × List β := unzip'' xys
    (x :: xs, y :: ys)

def reverse (xs : List α) : List α :=
  let rec helper : List α → List α → List α
  | [], soFar => soFar
  | y :: ys, soFar => helper ys (y :: soFar)
  helper xs []
