import std/strutils
import p08_translation

var content = "rosalind_splc.txt".readFile.strip

var samples: seq[string] = @[]

block get_samples:
    var cur_sample = ""
    for line in content.splitLines:
        var line = line.strip
        if line.startsWith('>'):
            samples.add(cur_sample)
            cur_sample = ""
            continue
        cur_sample &= line
    samples.add(cur_sample)
    samples.delete 0

var main_dna = samples[0]
for intron in samples[1..^1]:
    var indx = main_dna.find(intron)
    main_dna = main_dna[0 ..< indx] & main_dna[(indx+intron.len) .. ^1]
var rna = main_dna.replace('T', 'U')
echo translate(rna)