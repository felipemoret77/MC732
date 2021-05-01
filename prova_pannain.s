

.data

nome1: .space 20

nome2: .space 20

nome3: .space 20

nome4: .space 20

nome5: .space 20

msg0: .asciiz "\n Bem Vindo ao Portal de Notas! Estaremos agora cadastrando dados para os 5 alunos da melhor turma de MC732! \n"

msg1: .asciiz "\n Entre com o numero de RA do aluno "

msg2: .asciiz "\n Entre com o nome do aluno "

msg3: .asciiz "\nEntre com um
valor para a nota da P1 do aluno "

msg4: .asciiz "\nEntre com um
valor para a nota da P2 do aluno "

msg5: .asciiz "\nEntre com um
valor para a nota da P3 do aluno "

msg6: .asciiz "\n A média do aluno "

msg7: .asciiz ": "

msg8: .asciiz " é:"

msg9: .asciiz "Fim do Programa"

.text
.globl main

main:

li $s0, 5 # Defini o número de alunos como sendo 5

li $v0, 4
la $a0, msg0
syscall # Printa mensagem de boas-vindas

li $t1, 1 #Inicia o número de RAs cadastrados
li $t2, 1 #Inicia o número de nomes cadastrados

add $t3, $gp, $zero # Defini posiçã o da memória onde começaremos a armazenar dados

loop_cadastro_de_RAs:
slt $t0, $s0, $t1 # Verificando se já cadastramos 5 RAs ou não
beq $t0, 1, loop_cadastro_de_nomes  # Se o cadastro dos 5 RAs já foi feito, passaremos ao registro dos nomes
li $v0, 4 
la $a0, msg1
syscall # Printando mensagem para cadastrar RA do aluno
li $v0, 1
add $a0, $zero, $t1
syscall # Pritnando número do aluno
li $v0, 4
la $a0, msg7
syscall
li $v0, 5
syscall
add $s1, $v0, $zero # Armazena em $s1 o RA do aluno
sw $s1, 0($t3) # Armazena RA do aluno na memória
addi $t3, $t3, 4  # Incrementa endereço de armazenamento para futuros RAs 
addi $t1, 1 # Incrementa número de RAs já cadastrados
j loop_cadastro_de_RAs


loop_cadastro_de_nomes:
slt $t0, $s0, $t2 # Verificando se já cadastramos 5 nomes ou não
beq $t0, 1, printa_dados_teste # Se o cadastro dos 5 alunos já foi feito, passaremos ao registro das notas da P1
li $v0, 4 
la $a0, msg2
syscall # Printando mensagem para cadastrar nome do aluno
li $v0, 1
add $a0, $zero, $t2
syscall # Printando número do aluno
li $v0, 4
la $a0, msg7
syscall

beq $t2, 1, primeiro_nome
beq $t2, 2, segundo_nome
beq $t2, 3, terceiro_nome
beq $t2, 4, quarto_nome
beq $t2, 5, quinto_nome

primeiro_nome:
la $a0, nome1  # load byte space into address
li $a1, 20     # allot the byte space for string
li $v0, 8       # take in input
syscall
j guardando_nome

segundo_nome:
la $a0, nome2  # load byte space into address
li $a1, 20     # allot the byte space for string
li $v0, 8       # take in input
syscall
j guardando_nome

terceiro_nome:
la $a0, nome3  # load byte space into address
li $a1, 20     # allot the byte space for string
li $v0, 8       # take in input
syscall
j guardando_nome

quarto_nome:
la $a0, nome4  # load byte space into address
li $a1, 20     # allot the byte space for string
li $v0, 8       # take in input
syscall
j guardando_nome

quinto_nome:
la $a0, nome5  # load byte space into address
li $a1, 20     # allot the byte space for string
li $v0, 8       # take in input
syscall
j guardando_nome

guardando_nome:
move $s1, $a0   # save string to $s1
sw $s1, 0($t3) # Armazena nome do aluno na memória
addi $t3, $t3, 4  # Incrementa endereço de armazenamento para futuros nomes
addi $t2, 1 # Incrementa número de nomes já cadastrados
j loop_cadastro_de_nomes


printa_dados_teste:
addi $gp, $gp, 24
add $t0, $gp, $zero
lw $t1, 0($t0)
move $a0, $t1
li $v0, 4
syscall
j exit


exit:
li $v0, 10
syscall










#calculo_de_medias: