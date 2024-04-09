import zLib
import strutils
import algorithm

let lines = getFileLines("data.txt")

let seeds = lines[0].split(": ")[1].split()

var indexMap: seq[int]
var layersMap: seq[seq[(int, HSlice[int, int])]]

var rangeLayers: array[8, seq[HSlice[int, int]]]

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

proc lSort(a, b: (int, HSlice[int, int])): int =
    if a[1].a > b[1].a:
        return 1
    else:
        return -1

var s: seq[int]

for ind, layer in indexMap:
    let gotLayers = explore(layer + 1)
    var q: seq[(int, HSlice[int, int])]

    for l in gotLayers:
        q.add((parseInt(l[0]), parseInt(l[1]) .. parseInt(l[1]) + parseInt(l[2]) - 1))


    q.sort(lSort)

    layersMap.add(q)


proc doesIntersect(x: HSlice[int, int], y: HSlice[int, int]): bool =
    if x.a < y.a:
        if y.a < x.b:
            return true

    else:
        if x.a < y.b:
            return true
    
    return false

proc chop(x, y: HSlice[int, int]): HSlice[int, int] =
    return clamp(y.a, x.a, x.b)..clamp(y.b, x.a, x.b)

let r1 = 3..8
let r2 = 3..8

echo r1.chop(r2)


var back = 0

for i, seed in seeds:
    if i mod 2 == 0:
        back = parseInt(seed)
    else:
        rangeLayers[0].add(back .. back + parseInt(seed) - 1)

# for z in layersMap:
#     echo z

# for layerInd in 0..7:
#     for seedRange in rangeLayers[layerInd]:
#         for thisLayer in layersMap[layerInd]:
#             if seedRange.doesIntersect(thisLayer[1]):

