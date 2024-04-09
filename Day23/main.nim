import zLib

let lines = getFileLines("data.txt")

let startP = (1, 0)
let endP = (lines[0].high - 1, lines.high)

var visited: seq[(int, int)]
var path: seq[(int, int)]

var current = startP

proc `+`(a: (int, int), b: (int, int)): (int, int) =
    return (a[0] + b[0], a[1] + b[1])

proc isValid(a: (int, int)): bool =
    if a[0] < 0:
        return false

    if a[0] > lines[0].high:
        return false

    if a[1] < 0:
        return false

    if a[1] > lines.high:
        return false

    if lines[a[1]][a[0]] == '#':
        return false

    if a in visited:
        return false

    if a in path:
        return false

    return true

proc findGood(a: (int, int)): seq[(int, int)] =
    for 

proc traverse() 