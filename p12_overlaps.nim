import std/strutils
import std/strformat

var content = readFile("rosalind_grph.txt")
var samples: seq[string] = @[]
var names: seq[string] = @[]

var current_sample = ""
var current_name = ""
for line in content.strip.splitLines:
    if line.startsWith('>'):
        if current_name.len != 0:
            samples.add current_sample
            names.add(current_name)
        current_sample = ""
        current_name = line[1 .. ^1]
    else:
        current_sample &= line

samples.add(current_sample)
names.add(current_name)

var connections: seq[tuple[a: int, b: int]] = @[]
for s in 0..<samples.len:
    for k in 0..<samples.len:
        if (s == k): continue
        if samples[k].startsWith(samples[s][^3 .. ^1]):
            connections.add((a: s, b: k))

for connection in connections:
    echo fmt"{names[connection.a]} {names[connection.b]}"
echo fmt"There are {connections.len} connections"