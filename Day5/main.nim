import zLib
import strutils
import math
import algorithm

let lines = getFileLines("data.txt")

let seeds = lines[0].split(": ")[1].split()

var slices: seq[HSlice[int, int]]

var last = ""

for i in 0..seeds.high:
    if i mod 2 == 0:
        last = seeds[i]
    else:
        slices.add(parseInt(last)..(parseInt(last) + parseInt(seeds[i]) - 1))

var indexMap: seq[int]
var layersMap: seq[seq[(int, int, int)]]

proc explore(ind: int): seq[seq[string]] =
    var copyInd = ind
    var line = lines[copyInd]
    
    while not (line.isEmptyOrWhitespace):
        result.add(line.split())


        copyInd += 1
        if copyInd > lines.high:
            break
        line = lines[copyInd]
    
proc intified(s: seq[string]): seq[int] =
    for z in s:
        result.add(parseInt(z))

for ind, line in lines:

    case line.split()[0]:
    of "seed-to-soil":
        indexMap.add(ind)

    of "soil-to-fertilizer":
        indexMap.add(ind)

    of "fertilizer-to-water":
        indexMap.add(ind)

    of "water-to-light":
        indexMap.add(ind)
    
    of "light-to-temperature":
        indexMap.add(ind)

    of "temperature-to-humidity":
        indexMap.add(ind)

    of "humidity-to-location":
        indexMap.add(ind)

for ind, layer in indexMap:
    let gotLayers = explore(layer + 1)
    var q: seq[(int, int,int)]

    for l in gotLayers:
        q.add((parseInt(l[0]), parseInt(l[1]), parseInt(l[2])))

    layersMap.add(q)


proc processSeed(seed: int): int =
    result = seed

    for layer in layersMap:
        for subLayer in layer:
            if result in (subLayer[1] ..< subLayer[1] + subLayer[2]):
                result = subLayer[0] + result - subLayer[1]
                break

    return result

var lastLayer = layersMap[^1]

proc quickZsort(a: (int,int,int), b: (int,int,int)): int =
    if a[0] > b[0]:
        return 1
    else:
        return -1

proc altSort(a: (int,int,int), b: (int,int,int)): int =
    if a[1] > b[1]:
        return 1
    else:
        return -1

lastLayer.sort(quickZsort)

let minLocation = lastLayer[0][0]
let maxLocation = lastLayer[^1][0] + lastLayer[^1][2]


proc jumpUpLevel(levelIamCurrentlyAt: int, sisyphus: int): int =
    var nextLayers = layersMap[levelIamCurrentlyAt - 1]

    nextLayers.sort(quickZsort)

    var correctLayer = nextLayers[0]

    var boundarySort = layersMap[levelIamCurrentlyAt - 1]
    boundarySort.sort(altSort)

    let localMin = boundarySort[0][1]
    let localMax = boundarySort[^1][1] + boundarySort[^1][2]

    if not (sisyphus in localMin..localMax):
        return sisyphus

    for L in nextLayers:
        if sisyphus < L[0]:
            break
        correctLayer = L

    let r = sisyphus - correctLayer[0]
    return r + correctLayer[1]


for qsisyphus in minLocation..maxLocation:

    echo "start: " & $qsisyphus
    var sisyphus = qsisyphus

    var endIndex = 6

    while endIndex > 1:
        endIndex -= 1
        sisyphus = jumpUpLevel(endIndex, sisyphus)

    echo "end: " & $sisyphus
    echo ""