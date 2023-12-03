import math

type
    point* = ref object
        isPeriod*: bool
        isAsterisk*: bool
        isSymbol*: bool
        isNumber*: bool
        isRootNumber*: bool
        refNumber*: point
        splitNumber*: int
        data*: char
        rootNeighbours*: seq[point]
        pillars*: seq[point]

proc echo*(t: seq[seq[point]]) {.discardable.} =
    for l in t:
        var a = ""
        for z in l:
            a &= z.data
        echo a

proc echo*(t: seq[point]) {.discardable.} =
    var a = ""
    for z in t:
        a &= z.data
    echo a

proc echo*(t: point) {.discardable.} =
    echo t.data

proc read*(t: point): int =
    if t.isNumber:
        result += t.splitNumber * 10^(t.pillars.len)
        for workedIndex, x in t.pillars:
            let actualIndex = t.pillars.high - workedIndex
            result += x.splitNumber * 10^(actualIndex)
