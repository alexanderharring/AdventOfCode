import zLib
import strutils


let lines = getFileLines("data.txt")

var powerSum = 0

for line in lines:
    var handfuls = line.split(";")
    handfuls[0] = handfuls[0].split(": ")[1]

    for i in 0..(handfuls.high):
        handfuls[i] = handfuls[i].strip()

    var maxR = 0
    var maxG = 0
    var maxB = 0

    for runs in handfuls:
        let hands = runs.split(", ")

        for hand in hands:
            let c = hand.split(" ")


            if c[1] == "blue":
                if parseInt(c[0]) > maxB:
                    maxB = parseInt(c[0])

            elif c[1] == "green":
                if parseInt(c[0]) > maxG:
                    maxG = parseInt(c[0])

            if c[1] == "red":
                if parseInt(c[0]) > maxR:
                    maxR = parseInt(c[0])

    powerSum += maxR * maxG * maxB

echo powerSum

