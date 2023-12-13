import zLib
import math

var lines = getFileLines("data.txt")

var rowInds: seq[int]
var columnsInds: seq[int]

proc echo(s: seq[string]) =
    for x in s:
        echo x

proc `*`(c: char, t: int): string =
    for i in 0..(t - 1):
        result &= $c

proc getManhattan(a: (int, int), b: (int, int)): int =
    return abs(b[0] - a[0]) + abs(b[1] - a[1])

for i in 0..lines.high:
    var shouldContinue = true
    for x in lines[i]:
        if x != '.':
            shouldContinue = false
            break
    if not shouldContinue:
        continue
    rowInds.add(i)

for ind, x in rowInds:
    lines.insert('.' * lines[0].len, x + ind)

for i in 0..lines[0].high:
    var shouldContinue = true
    for x in lines:
        if x[i] != '.':
            shouldContinue = false
            break
    if not shouldContinue:
        continue
    columnsInds.add(i)

for ind, x in columnsInds:
    for xind, line in lines:
        var newL = lines[xind]
        newL.insert(".", ind + x)
        lines[xind] = newL

var stars: seq[(int, int)]

for yInd, yLine in lines:
    for xInd, xLine in yLine:
        if xLine == '#':
            stars.add((yInd, xInd))

var sum = 0

for star in stars:
    for otherStar in stars:
        if otherStar == star:
            continue

        sum += star.getManhattan(otherStar)

for combs in choose(stars, 2):
    sum += combs[0].getManhattan(combs[1])

echo int(sum / 3)
