import zLib
import sets
import strutils

let lines = getFileLines("data.txt")

type
    card = object
        hand: string
        bet: int

var data: seq[card]

for x in lines:
    let s = x.split()

    data.add(card(hand: s[0], bet: parseInt(s[1])))

var veryNeccessaryImNotLazy = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']

proc getInterpretedValue(a: char): int =
    return veryNeccessaryImNotLazy.find(a)


proc `>`(a, b: string): int =
    for i in 0..4:
        if a[i] == b[i]:
            continue

        if a[i].getInterpretedValue > b[i].getInterpretedValue:
            return 1
        else:
            return -1

proc sortCard(a, b: card): int =
    let setA = a.hand.toHashSet
    let setB = b.hand.toHashSet

    if setA.len + setB.len == 2:
        return a.hand > b.hand

    if setA.len + setB.len == 3:
        if setA.len < setB.len:
            return 1
        return -1


