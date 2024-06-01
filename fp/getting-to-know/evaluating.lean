#eval 1 + 2

#eval 1 + 2 * 5

#eval String.append "Hello, " "Lean!"

#eval String.append "great " (String.append "oak " "tree")

#eval String.append "it is " (if 1 > 2 then "yes" else "no")

-- exercises

-- 61
#eval 42 + 19

-- "ABC"
#eval String.append "A" (String.append "B" "C")

-- "ABC"
-- append (append a b) c == append a (append b c)
#eval String.append (String.append "A" "B") "C"

-- 5
#eval if 3 == 3 then 5 else 7

-- "not equal"
#eval if 3 == 4 then "equal" else "not equal"
