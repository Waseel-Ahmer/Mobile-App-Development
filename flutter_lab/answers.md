Name: Waseel Ahmer
Reg no. : 04072313013

A1: 8
A2: 10
A3: 12 
A4: 27

B1:
Statless:
LabApp: It only configures the root application structure and its properties never change.
HomePage: It acts as a static layout container to arrange other widgets on the screen.
StudentCard: It only displays the final strings passed into its constructor.
GoalBanner: It calculates percentage based only on the inputs it receives and holds no dynamic state of its own.

Stateful:
Tally: It tracks, updates, and rebuilds the interface when its internal `_count` variable changes using buttons.
BuggyCounter: It maintains and changes `_clicks` variable based on user interaction to rebuild its text output.
Countdown: It maintains Timer and dynamically updates its `_left` and `_builds` variables over time.

B2: If the timer is not cancelled it keeps running in background after the Countdown widget is removed from the screen. This leads to memory leaks and code crashes.

B3:In our code it includes entire classes like const Tally(), const Countdown(), and const BuggyCounter(), as well as static texts like const Text('Reset'), and all our Key objects. When we make a widget const Flutter creates it exactly once at compile-time. When a screen redraws Flutter completely skips rebuilding the const widgets because it knows they haven't changed.