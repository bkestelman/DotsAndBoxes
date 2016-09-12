The purpose of this project is to solve the Dots and Boxes problem:

Consider a square box with side lengths 1, and with N dots inside. Consider cases with few dots first (0, 1, 2, 3)

You can form rectangles, or boxes, inside the square following these rules:
1. A rectangle may not contain a dot
2. A rectangle always expands to its maximum size (that is, until all its edges encounter either the sides of the box, or one or more dots)

It's clear that these rectangles can have different areas, and that moving the dots around changes their areas. 

The problem is to find the positions of dots such that the area of the largest rectangle is as small as possible. 

This is an interesting problem because it can be analyzed from many mathematical perspectives, including geometry, combinatorics (with a fun recursive process when going from N dots to N+1 dots), dynamical systems, as well as from a physical perspective (where the dots and boxes exert forces on each other), and an algorithmic perspective (testing a finite number of geometrically different configurations of dots and optimizing the best one). Furthermore, proving that a solution is correct promises to be a worthy challenge. 

The problem's basic form is that of an optimization problem, but there is great difficulty in describing the dots and rectangles mathematically, in order to obtain a formula which can be optimized. I turns out this approach is very simple in the 0 and 1 dot cases (for which you can eyeball the solution), and a little trickier but still successful for the 2 dot case.
The insight needed in the 2 dot case is one of symmetry - i.e. that moving the dots from the center along the diagonal to opposite corners shrinks the largest boxes evenly. At the same time, smaller boxes will grow. The optimal position of the dots is when these smaller boxes have grown to the same size as the shrinking large boxes, since at this point any movement of the dots will increase the size of the largest box. 
This optimization can be performed algebraically, calculating the areas of boxes from the dots' coordinates. The result for the positions of the dots amusingly happens to contain the golden ratio. 

However, for 3 dots or more, this approach becomes unfeasable. Too many assumptions (or clever insights) have to be made about the directions the dots should move in, and worse, there are too many rectangles to consider. New approaches are necessary. 

Analysis of Configurations:

Forces:
