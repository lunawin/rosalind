import std/strutils

var content = "rosalind_tree.txt".readFile.strip.splitLines
var N = content[0].parseInt

var groups: seq[seq[int]] = @[]

for i in 1..N:
    groups.add(@[i])

proc find_group(n: int): int =
    for i in 0..<groups.len:
        if n in groups[i]:
            return i
    return -1 # should not happen

proc connect(n1, n2: int) =
    var gi1 = find_group(n1)
    var gi2 = find_group(n2)

    if gi1 == gi2:
        return # already connected
    var group: seq[int] = @[]
    group.add(groups[gi1])
    group.add(groups[gi2])
    groups.del max(gi1, gi2)
    groups[min(gi1, gi2)] = group

for line in content[1 .. ^1]:
    var pair = line.strip.split(" ")
    connect(pair[0].parseInt, pair[1].parseInt)

echo groups.len - 1

############################
# in a tree of no cycle, it means N-1 edges must exist
echo (N-1) - (content.len - 1)