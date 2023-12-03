import zLib
import strutils
import overloads

let gridOne = getFileLines("data.txt")

var grid: seq[seq[string]]

var typedGrid: seq[seq[point]]

for line in gridOne:
    var soFarLine: seq[point]

    var numberPointer = false
    var lastRootNumber: point = point()

    for section in line:
        if section.isDigit:
            if not numberPointer:
                var thisNumber = point(isPeriod: false, isSymbol: false, isAsterisk: false, isRootNumber: true, splitNumber: parseInt($section), data: section, isNumber: true)

                numberPointer = true
                lastRootNumber = thisNumber
                soFarLine.add(thisNumber)

            else:
                var newPoint = point(isPeriod: false, isSymbol: false, isAsterisk: false, isRootNumber: false, splitNumber: parseInt($section), refNumber: lastRootNumber, data: section, isNumber: true)

                lastRootNumber.pillars.add(newPoint)
                soFarLine.add(newPoint)

        else:
            numberPointer = false

            if section == '.':
                soFarLine.add(point(isPeriod: true, isAsterisk: false, isSymbol: false, isRootNumber: false, data: section, isNumber: false))

            elif section == '*':
                soFarLine.add(point(isPeriod: false, isAsterisk: true, isSymbol: false, isRootNumber: false, data: section, isNumber: false))

            else:
                soFarLine.add(point(isPeriod: false, isAsterisk: false, isSymbol: true, isRootNumber: false, data: section,  isNumber: false))

    typedGrid.add(soFarLine)



var sum = 0

proc isInBounds(xR: int, xC: int): bool =
    if xR < 0:
        return false
    if xC < 0:
        return false
    if xR > typedGrid.high:
        return false
    if xC > typedGrid[0].high:
        return false

    return true

proc getSurroundings(rowInd: int, columnInd: int): seq[(int, int)] =
    for xR in -1..1:
        for xC in -1..1:
            if not (xR == 0 and xC == 0):
                if isInBounds(rowInd + xR, columnInd + xC):
                    result.add((rowInd + xR, columnInd + xC))

for rowInd, row in typedGrid:
    for columnInd, column in typedGrid:
        let pointInQuestion = typedGrid[rowInd][columnInd]
        
        if pointInQuestion.isNumber:
            
            if pointInQuestion.isRootNumber:
               
                for neighbor in getSurroundings(rowInd, columnInd):
                    let actualPerson = typedGrid[neighbor[0]][neighbor[1]]
                    if actualPerson.isAsterisk:
                        
                        if not (pointInQuestion in actualPerson.rootNeighbours):
                            actualPerson.rootNeighbours.add(pointInQuestion)


                for ind, numberConnections in pointInQuestion.pillars:
                    for neighbor in getSurroundings(rowInd, columnInd + ind + 1):
                        let actualPerson = typedGrid[neighbor[0]][neighbor[1]]
                        if actualPerson.isAsterisk:
                            
                            if not (pointInQuestion in actualPerson.rootNeighbours):
                                actualPerson.rootNeighbours.add(pointInQuestion)

for rowInd, row in typedGrid:
    for columnInd, column in typedGrid:
        let pointInQuestion = typedGrid[rowInd][columnInd]

        if pointInQuestion.isAsterisk:
            if pointInQuestion.rootNeighbours.len == 2:
                sum += pointInQuestion.rootNeighbours[0].read * pointInQuestion.rootNeighbours[1].read

echo sum