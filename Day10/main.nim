import zLib
import strutils
import tables
import sequtils

let lines = getFileLines("data.txt")

var grid: seq[seq[char]]

var dirTab = initTable[(char, int, int), (int, int)]() #the character, the input direction then the output displacement

dirTab[('|', 0, 1)] = (0,1)
dirTab[('|', 0, -1)] = (0,-1)
dirTab[('-', 1, 0)] = (1,0)
dirTab[('-', -1, 0)] = (-1,0)
dirTab[('L', 0, 1)] = (1,0)
dirTab[('L', -1, 0)] = (0,-1)
dirTab[('J', 1, 0)] = (0,-1)
dirTab[('J', 0, 1)] = (-1,0)
dirTab[('7', 1, 0)] = (0,1)
dirTab[('7', 0, -1)] = (-1,0)
dirTab[('F', 0, -1)] = (1,0)
dirTab[('F', -1, 0)] = (0,1)

var start = (0,0)

for aind, line in lines:
    for cind, c in line:
        if c == 'S':
            start = (cind, aind)
    grid.add(line.toSeq)

var path: seq[(int,int)]

proc `+`(a: (int, int), b: (int, int)): (int, int)=
    return (a[0] + b[0], a[1] + b[1])

proc get(pos: (int, int)): char =
    return grid[pos[1]][pos[0]]

var shouldContinue = true

var pos = start
var direction = (0, 1)

var its = 0

while shouldContinue:
    path.add(pos)

    let newOne = pos + direction

    let git = get(newOne)

    if git == 'S':
        if its > 0:
            shouldContinue = false
            break

    
    let newDirection = dirTab[(git, direction[0], direction[1])]
    pos = newOne
    direction = newDirection

    its += 1

var copy: seq[char]

for x in path:
    copy.add(get(x))

echo copy.len / 2
