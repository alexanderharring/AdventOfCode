import zLib
import tables
import strutils
import math
import sequtils

var lines = getFileLines("data.txt")

let instruction = lines[0]

lines.delete(0)
lines.delete(0)

proc extractLine(s: string): (string, seq[string]) =
    let key = s.split(" = ")[0]
    let split2 = s.split("= (")[1]
    let split3 = split2.split(", ")

    let v1 = split3[0]

    let v2 = split3[1][0..^2]

    return (key, [v1, v2, key].toSeq)

proc nMod(x, y: int): int =
    if x > y:
        var copyX = x
        while copyX > y:
            copyX -= (y + 1)
        return copyX
    else:
        return x

proc inspectInstruction(c: char): int =
    if c == 'L':
        return 0
    else:
        return 1

var mainTable = initTable[string, seq[string]]()

for x in lines:
    let parsed = extractLine(x)
    mainTable[parsed[0]] = parsed[1]

var currentPaths: seq[string]

proc getTag(s: string): char =
    return s[^1]
for k in mainTable.keys:
    let lastChar = k[^1]
    if lastChar == 'A':
        currentPaths.add(k)

var pathDurations: seq[int]

for path in currentPaths:
    var holderPath = path
    var newIts = 0
    while holderPath.getTag != 'Z':
        let moddedNewResult = newIts.nMod(instruction.high)
        let result = inspectInstruction(instruction[moddedNewResult])

        holderPath = mainTable[holderPath][result]

        newIts += 1

    pathDurations.add(newIts)

var t = 1

for x in pathDurations:
    t = lcm(t, x)

echo t