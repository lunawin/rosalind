import std/strutils

var content = "rosalind_iev.txt".readFile.strip.split
var expected_value = 0.0

template calculate_val(couple_indx: int, chance_of_dominance: float, chance_of_recession: float) =
    var pairs = content[couple_indx].parseInt.toFloat
    # k = 0 (0 dominant, 2 recessive)
    expected_value += 0 * pairs * chance_of_recession * chance_of_recession
    # k = 1 (1 dominant, 1 recessive)
    expected_value += 1 * pairs * chance_of_dominance * chance_of_recession
    expected_value += 1 * pairs * chance_of_recession * chance_of_dominance
    # k = 2 (2 dominant, 0 recessive)
    expected_value += 2 * pairs * chance_of_dominance * chance_of_dominance

calculate_val(0, 1.00, 0.00) # AA x AA = [AA, AA, AA, AA]
calculate_val(1, 1.00, 0.00) # AA x Aa = [AA, Aa, AA, Aa]
calculate_val(2, 1.00, 0.00) # AA x aa = [Aa, Aa, Aa, Aa]
calculate_val(3, 0.75, 0.25) # Aa x Aa = [AA, Aa, Aa, aa]
calculate_val(4, 0.50, 0.50) # Aa x aa = [Aa, Aa, aa, aa]
calculate_val(5, 0.00, 1.00) # aa x aa = [aa, aa, aa, aa]

echo expected_value