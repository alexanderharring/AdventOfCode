import zLib
import strutils
import math

let lines = getFileLines("data.txt")

let time = parseInt(lines[0].split(":")[1].replace(" ", ""))
let distance = parseInt(lines[1].split(":")[1].replace(" ", ""))

proc solveQuadratic(a, b, c: int): HSlice[float64, float64] =
    let disc = b * b - 4 * a * c

    if disc < 0:
        return 0.0..0.0

    let sqD = sqrt(float64(disc))

    let solA = (-(float64(b)) + sqD) / (2 * float64(a))
    let solB = (-(float64(b)) - sqD) / (2 * float64(a))

    return solA..solB

var sum = 1


let result = solveQuadratic(-1,time, -1 * distance)

let newSlice = ceil(result.a + 0.0001)..ceil(result.b - 0.001)

sum *= int(newSlice.b - newSlice.a) 

echo sum