import zLib
import strutils

let lines = getFileLines("data.txt")

let seeds = lines[0].split(": ")[1].split()

var indexMap: seq[int]

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

var s: seq[int]

for seed in seeds:

    var output = parseInt(seed)

    for index in indexMap:
        let results = explore(index + 1)
        
        for result in results:
            let parsed = intified(result)

            if output in (parsed[1] ..< parsed[1] + parsed[2]):
                let distance = output - parsed[1]
                output = parsed[0] + distance
                break

    s.add(output)

echo s.min
