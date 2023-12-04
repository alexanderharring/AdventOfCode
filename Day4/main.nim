import zLib
import strutils
import sets
import math

let lines = getFileLines("data.txt")

var data: seq[(HashSet[int], HashSet[int])]

var sum = 0

var scoreSheet: seq[int]

for i in 0..<lines.len:
    scoreSheet.add(1)

for line in lines:
    let halfs = line.split(": ")[1].split(" | ")

    var leftHalf = halfs[0]
    var rightHalf = halfs[1]
    
    leftHalf = leftHalf.replace("  ", " ").strip()
    rightHalf = rightHalf.replace("  ", " ").strip()

    let lsplit = leftHalf.split(" ")
    let rsplit = rightHalf.split(" ")

    var lHash = initHashSet[int]()
    var rHash = initHashSet[int]()

    for x in lsplit:
        lHash.incl(parseInt(x))

    for x in rsplit:
        rHash.incl(parseInt(x))

    data.add((lHash, rHash))

for x in 0..<scoreSheet.len:
    let (winnings, numbers) = data[x]
    let result = (winnings * numbers).len
    let copies = scoreSheet[x]

    for its in 0..<copies:
        for additionals in 0..<result:
            scoreSheet[x + additionals + 1] += 1


echo scoreSheet.sum