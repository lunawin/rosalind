import std/strutils

var number_leaves = "rosalind_inod.txt".readFile.strip.parseInt
var number_inodes = 0

#[
L L
 R

L L L
 I    -> L L
          I L
           R

L L L L
 I   I
   R

L L L L L
 I   I    -> L L L L
              I   I  L
                I      ->  L L L L
                            I   I
                              I    L
                                R

Essentially Layer // 2 new inodes, and Layer % 2 inode moves up, repeat until there's only 2 element left to merge


Or
By handshaking lemma: sum deg(v) = 2E
in a tree of N nodes, there are N-1 edges
and in N nodes, leaves have degree 1, while internal nodes have degree 3 and then there's root element which has degree 2
(this is rooted tree, but hush)

1.L + 3.I + 2.1 = 2((L+I+1) - 1)
L + 3I + 2 = 2L + 2I
I + 2 = L
I = L - 2
]#

while number_leaves > 2:
    var new_inodes = number_leaves div 2
    number_inodes += new_inodes
    number_leaves -=  new_inodes

echo number_inodes