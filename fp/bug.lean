def onePlusOneIsTwo : Prop := 1 + 1 = 2
theorem OnePlusOneIsTwo : onePlusOneIsTwo := rfl

def stringAppend : Prop := "Str".append "ing" = "String"
theorem StringAppend : stringAppend := rfl

theorem addAndAppend : onePlusOneIsTwo ∧ stringAppend := by simp

theorem addAndAppend2 : 1 + 1 = 2 ∧ "Str".append "ing" = "String" :=
  And.intro rfl rfl

theorem addAndAppend3 : 1 + 1 = 2 ∧ "Str".append "ing" = "String" := by simp

#eval Lean.versionString
