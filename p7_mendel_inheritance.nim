import std/strutils
import std/math

var content = readFile("rosalind_iprb.txt").strip.split
var k = content[0].parseInt.toFloat # AA
var m = content[1].parseInt.toFloat # Aa
var n = content[2].parseInt.toFloat # aa

var dominant_phenotypes = 0.0
var total_possibility = 0.0

template add_dominant(total: float, ratio: float) =
    dominant_phenotypes += total * ratio
    total_possibility   += total

add_dominant(k * (k-1), 1.00) # AA x AA = [AA, AA, AA, AA], 4/4 = 1.00
add_dominant(2 * k * m, 1.00) # AA x Aa = [AA, Aa, AA, Aa], 4/4 = 1.00, also Aa x AA = AA x Aa
add_dominant(2 * k * n, 1.00) # AA x aa = [Aa, Aa, Aa, Aa], 4/4 = 1.00, also aa x AA = AA x aa
add_dominant(m * (m-1), 0.75) # Aa x Aa = [AA, Aa, Aa, aa], 3/4 = 0.75
add_dominant(2 * m * n, 0.50) # Aa x aa = [Aa, Aa, aa, aa], 2/4 = 0.50, also aa x Aa = Aa x aa
add_dominant(n * (n-1), 0.00) # aa x aa = [aa, aa, aa, aa], 0/0 = 0.00

echo round(dominant_phenotypes / total_possibility, 5)