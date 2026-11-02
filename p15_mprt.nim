import std/httpclient
import std/os
import std/strutils

var client = newHttpClient()

proc access_protein(name: string): string =
    if not fileExists(name & ".fasta"):
        var url = "https://rest.uniprot.org/uniprotkb/" & name & ".fasta"
        echo "Fetching ", url
        var fasta = client.getContent(url)
        assert fasta.startsWith('>')
        (name & ".fasta").writeFile(fasta)
    
    var fasta = (name & ".fasta").readFile
    var lines = fasta.strip.splitLines
    for i in 1..<lines.len:
        result &= lines[i].strip

proc find_motif(fasta: string): seq[int] =
    var start = fasta.find('N')

    while start != -1:
        if fasta[start+1] == 'P':
            start = fasta.find('N', start+1)
            continue
        if fasta[start+2] notin ['S', 'T']:
            start = fasta.find('N', start+1)
            continue
        if fasta[start+3] == 'P':
            start = fasta.find('N', start+1)
            continue
        result.add(start+1)
        start = fasta.find('N', start+1)


# just to ensure it all loaded
for name in "rosalind_mprt.txt".readFile.strip.splitLines:
    var splt = name.split('_')
    var protein_name = splt[0]
    discard access_protein(protein_name)

for name in "rosalind_mprt.txt".readFile.strip.splitLines:
    var splt = name.split('_')
    var protein_name = splt[0]
    var protein_fasta = access_protein(protein_name)
    var motifs = find_motif(protein_fasta)
    if motifs.len == 0:
        continue
    
    echo name
    var to_echo = ""
    for item in motifs:
        to_echo &= $item & " "
    echo to_echo