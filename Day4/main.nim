import zLib
import strutils
import sets
import math

let lines = getFileLines("data.txt")

var sum = 0

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

    let result = (lHash * rHash).len

    if result != 0:
        sum += 2^(result - 1)

echo sum