# Playoff_bracket_builder

| requirements | version |
| ruby | 2.7.0p0 |


## run by using 

```$ ruby NHL_Playoff_Bracket.rb```

## available commands

slots start from top left and go top to bottom, then by round

entering a team name that is not the same as a following command will insert it into the 
current index and increment to the next slot automatically

h -> displays this menu

m -> move to an index in the first round 1-16 (overflow will circle around)

r -> replace team at the current index

i -> insert team at an index 

mm -> move to a matchup (overflow will circle around)

1 -> select top team as the winner in the currently selected match

2 -> select bottom team as the winner in the currently selected match 

i1 -> select top team as the winner in the indexed match

i2 -> select bottom team as the winner in the indexed match

p -> prints the current bracket

nr -> advance to next round 

pf -> prints to file

s -> saves the current bracket

exit -> saves the current bracket and closes the program 

reset -> resets the braket so everything is empty
