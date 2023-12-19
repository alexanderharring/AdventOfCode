import zLib
import strutils

let lines = getFileLines("data.txt")

let data = lines[0].split(",")

var sum = 0

proc qHash(s: string): int =
    result = 0
    for c in s:
        let code = ord(c)
        result += code
        result *= 17
        result = result mod 256
    return result

for z in data:
    sum += z.qHash

echo sum