ADDI $t0, $zero, 5
ADDI $t1, $zero, 3
NOP
NOP
NOP
NOP
ADD  $t2, $t0, $t1
NOP
NOP
NOP
SW   $t2, 0($zero)
J    11