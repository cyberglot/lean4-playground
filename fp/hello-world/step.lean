def twice (action : IO Unit) : IO Unit :=
  do action
     action

def nTimes (action : IO Unit) : Nat → IO Unit
  | 0 => pure ()
  | n + 1 => do
      action
      nTimes action n

def countdown : Nat → List (IO Unit)
  | 0 => [IO.println "Blast off!"]
  | n + 1 => IO.println s!"{n + 1}" :: countdown n


def runActions : List (IO Unit) → IO Unit
  | [] => pure ()
  | act :: actions => do
        act
        runActions actions

def main : IO Unit := do
  let englishGreeting := IO.println "Hello!"
  IO.println "Bonjour!"
  englishGreeting
  -- It should print "Bonjour! Hello!",
  -- since englishGreeting is only run in the last line
