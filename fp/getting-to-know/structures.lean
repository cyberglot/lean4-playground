#check 1.2
#check -454.2123215
#check 0.0
#check 0
#check (0 : Float)

-- Repr => Haskell's Show, Rust's Display
-- it comes from python? wow
structure Point where
  x : Float
  y : Float
deriving Repr

def origin : Point := { x := 0.0, y := 0.0 }
#eval origin
#eval origin.x
#eval origin.y

def addPoints (p1 : Point) (p2 : Point) : Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }

#eval addPoints { x := 1.5, y := 32 } { x := -8, y := 0.2 }

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt (((p2.x - p1.x) ^ 2.0) + ((p2.y - p1.y) ^ 2.0))

#eval distance { x := 1.0, y := 2.0 } { x := 5.0, y := -1.0 }

structure Point3D where
  x : Float
  y : Float
  z : Float
deriving Repr

def origin3D : Point3D := { x := 0.0, y := 0.0, z := 0.0 }

#eval origin3D

#check ({ x := 0.0, y := 0.0 } : Point)
#check { x := 0.0, y := 0.0 : Point }

def zeroX (p : Point) : Point :=
  { x := 0, y := p.y }

def zeroX' (p : Point) : Point :=
  { p with x := 0 }

def fourAndThree : Point :=
  { x := 4.3, y := 3.4 }

#eval fourAndThree
#eval zeroX fourAndThree

#check Point.mk 1.5 2.8
#check (Point.mk)

structure Point' where
  point ::
  x : Float
  y : Float
deriving Repr

#eval "one string".append " and another"

def Point.modifyBoth (f : Float → Float) (p : Point) : Point :=
  { x := f p.x, y := f p.y }

#eval fourAndThree.modifyBoth Float.floor

-- exercises

structure RectangularPrism where
  prism ::
  height : Float
  width : Float
  depth : Float
deriving Repr

def volume (p : RectangularPrism) : Float :=
  p.height * p.width * p.depth

structure Segment where
  segment ::
  x : Float
  y : Float
deriving Repr

-- if tis wrong, I'm sorry
-- I don't understand math
def length (segment : Segment) : Float :=
  segment.x + segment.y

structure Hamster where
  name : String
  fluffy : Bool

structure Book where
  makeBook ::
  title : String
  author : String
  price : Float
