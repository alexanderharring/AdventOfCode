import zLib
import tables
import strutils
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

var currentLine = mainTable["AAA"]
var its = 0

while currentLine[2] != "ZZZ":
    echo currentLine

    let moddedNewResult = its.nMod(instruction.high)
    # echo moddedNewResult, its
    let result = inspectInstruction(instruction[moddedNewResult])

    its += 1
    let nextLine = currentLine[result]
    currentLine = mainTable[nextLine]

    if its == 1000000:
        break
    
    
echo its