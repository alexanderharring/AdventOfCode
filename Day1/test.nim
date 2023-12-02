import zLib
import strutils
import deques
import times

let lines = getFileLines("inputData.txt")

let t0 = getTime()

var t = 0

var options = @["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

proc isWord(s: string): bool =
    if options.find(s) >= 0:
        return true
    return false

proc getUsefulPerms(s: Deque): seq[string] =
    if s.len < 3:
        return @[]

    for sliceInd in 2..(s.len - 1):

        for it in 0..(s.len - sliceInd - 1):
            var mainS = ""

            for subSlice in 0..sliceInd:
                mainS &= s[subSlice + it]

            result.add(mainS)


for line in lines:  
    var firstWord = ""
    var lastWord = ""

    var startQueue = initDeque[char]()
    var endQueue = initDeque[char]()

    for a in countup(0,line.high):
        if firstWord.len > 0:
            break

        if line[a].isDigit:
            firstWord = options[parseInt($line[a]) - 1]
            break

        if startQueue.len >= 5:
           startQueue.popFirst()

        startQueue.addLast(line[a])

        for p in getUsefulPerms(startQueue):
            if p.isWord:
                firstWord = p


    for a in countdown(line.high, 0):
        if lastWord.len > 0:
            break

        if line[a].isDigit:
            lastWord = options[parseInt($line[a]) - 1]
            break

        if endQueue.len >= 5:
           endQueue.popLast()

        endQueue.addFirst(line[a])

        for p in getUsefulPerms(endQueue):
            if p.isWord:
                lastWord = p
                break

    t += options.find(firstWord) * 10 + options.find(lastWord) + 11

echo t

echo (getTime() - t0)