Name:Waseel AHmer
Reg no.: 04072313013

A1: 17
A2: 8
A3: 3
A4: 50

B1: Clock, Tile, and SwapBoard are Stateful because their data changes dynamically (timer, taps, swaps), while all other widgets are Stateless because their UI remains fixed once built.
B2:The Widget is rebuilt on every setState while the Element and RenderObject are kept, as proven by the Probe showing the Widget ID changing while the Element ID remained constant.
B3:In Step 8, the Row passes its maximum width constraints down to its children, which then calculate their specific widths (fixed or flex) and pass their final sizes back up for the Row to arrange.