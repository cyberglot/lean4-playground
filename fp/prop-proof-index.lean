def woodlandCritters : List String :=
  ["hedgehog", "deer", "snail"]

def hedgehog := woodlandCritters[0]
def deer := woodlandCritters[1]
def snail := woodlandCritters[2]

-- def oops := woodlandCritters[3]


theorem andImpliesOr : A ∧ B → A ∨ B :=
  fun andEvidence =>
    match andEvidence with
    | And.intro a _ => Or.inl a

theorem onePlusOneAndLessThan : 1 + 1 = 2 ∨ 3 < 5 := by simp
theorem notTwoEqualFive : ¬(1 + 1 = 5) := by simp
theorem trueIsTrue : True := True.intro
theorem trueOrFalse : True ∨ False := by simp
theorem falseImpliesTrue : False → True := by simp

def third (xs : List α) (ok : xs.length > 2) : α := xs[2]

def thirdOption (xs : List α) : Option α := xs[2]?

#eval thirdOption woodlandCritters
#eval thirdOption ["only", "two"]

-- exercises
-- I'm not sure I understand what's this about
def wat : (2 + 3 = 5) ∧ (15 - 8 = 7) ∧ ("Hello, ".append "world" = "Hello, world") :=
  And.intro rfl (And.intro rfl rfl)

def wat2 : (2 + 3 = 5) ∧ (15 - 8 = 7) ∧ ("Hello, ".append "world" = "Hello, world") := by simp

def fifth (xs : List α) (ok : xs.length > 5) : α := xs[5]

--
