 

.data

zero_float: .float 0.0

nota_maxima: .float 10.0

denominador_media_sem_exame: .float 10.0

denominador_media_com_exame: .float 2.0

nota_exame_passou_direto: .float -1.0

peso_prova_1: .float 3.0

peso_prova_2: .float 4.0

peso_prova_3: .float 5.0

media_aprovacao: .float 5.0

nome1: .space 20

nome2: .space 20

nome3: .space 20

nome4: .space 20

nome5: .space 20

msg0: .asciiz "\n Bem Vindo ao Portal de Notas! Estaremos agora cadastrando dados para os 5 alunos da melhor turma de MC732! \n"

msg1: .asciiz "\n Entre com o numero de RA do aluno "

msg2: .asciiz "\n Entre com o nome do aluno "

msg3: .asciiz "\n Entre com um valor para a nota da P1 do aluno "

msg4: .asciiz "\n Entre com um valor para a nota da P2 do aluno "

msg5: .asciiz "\n Entre com um valor para a nota da P3 do aluno "

msg6: .asciiz "\n A média do aluno "

msg7: .asciiz ": "

msg8: .asciiz " é: "

msg9: .asciiz "\n"

msg10: .asciiz "\n Infelizmente esse aluno ficou de exame :( ! Entre com a nota do exame: "

msg11: .asciiz "\n A nova média desse aluno é: "

msg12: .asciiz "\n Esse aluno passou sem exame ! :)"

msg13: .asciiz "Fim do Programa"

.text
.globl main

main:

li $s0, 5 # Defini o número de alunos como sendo 5

li $v0, 4
la $a0, msg0
syscall # Printa mensagem de boas-vindas

li $t1, 1 #Inicia o número de RAs cadastrados
li $t2, 1 #Inicia o número de nomes cadastrados
li $t4, 1 #Inicia o número de notas
li $t5, 3 #Registrador para 

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
beq $t0, 1, loop_cadastro_de_notas  # Se o cadastro dos 5 alunos já foi feito, passaremos ao registro das notas da P1
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
la $a0, nome1  # Reserva espaço no buffer
li $a1, 20     # Reserva espaço para a string nome1
li $v0, 8      # Recebe string nome1
syscall
j guardando_nome

segundo_nome:
la $a0, nome2  
li $a1, 20   
li $v0, 8       
syscall
j guardando_nome

terceiro_nome:
la $a0, nome3  
li $a1, 20     
li $v0, 8       
syscall
j guardando_nome

quarto_nome:
la $a0, nome4 
li $a1, 20    
li $v0, 8    
syscall
j guardando_nome

quinto_nome:
la $a0, nome5 
li $a1, 20   
li $v0, 8       
syscall
j guardando_nome

guardando_nome:
move $s1, $a0   # Salva string em $s1
sw $s1, 0($t3) # Armazena nome do aluno na memória
addi $t3, $t3, 4  # Incrementa endereço de armazenamento para futuros nomes
addi $t2, 1 # Incrementa número de nomes já cadastrados
j loop_cadastro_de_nomes

loop_cadastro_de_notas:
slt $t0, $s0, $t4 # Verifica se já foram cadastradas as notas dos 5 alunos
beq $t0, 1, printa_dados_teste_floats
l.s $f4, zero_float # Carregando zero em float point
add.s $f1, $f4, $f4 # Inicializando somador de notas ponderadas
li $v0, 4 
la $a0, msg3
syscall # Printando mensagem para cadastrar nota da P1 do aluno
li $v0, 1
add $a0, $zero, $t4
syscall # Printando número do aluno
li $v0, 4
la $a0, msg7
syscall
li $v0, 6 #Lendo nota da P1 do aluno
syscall
l.s $f4, peso_prova_1
mul.s $f4, $f0, $f4
add.s $f1, $f1, $f4 
s.s $f0, 0($t3)
addi $t3, 4
li $v0, 4 
la $a0, msg4
syscall # Printando mensagem para cadastrar nota da P2 do aluno
li $v0, 1
add $a0, $zero, $t4
syscall # Printando número do aluno
li $v0, 4
la $a0, msg7
syscall
li $v0, 6 #Lendo nota da P2 do aluno
syscall
l.s $f4, peso_prova_2
mul.s $f4, $f0, $f4
add.s $f1, $f1, $f4 
s.s $f0, 0($t3)
addi $t3, 4
li $v0, 4 
la $a0, msg5
syscall # Printando mensagem para cadastrar nota da P3 do aluno
li $v0, 1
add $a0, $zero, $t4
syscall # Printando número do aluno 
li $v0, 4
la $a0, msg7
syscall
li $v0, 6 # Lendo nota da P3 do aluno
syscall
l.s $f4, peso_prova_3
mul.s $f4, $f0, $f4
add.s $f1, $f1, $f4  
s.s $f0, 0($t3)
addi $t3, 4
l.s $f4, denominador_media_sem_exame # Carregando o denominador da media sem exame
div.s $f1, $f1, $f4 # Fazendo divisão da soma das notas ponderadas por 10
l.s $f4, nota_maxima
c.lt.s $f4, $f1 # Verificando se a media sem exame é maior do que a nota máxima permitida
bc1t trunca_para_nota_maxima # Se a media inicial for maior do que a nota máxima permitida, faremos o processo de truncamento para 10
s.s $f1, 0($t3)
j continuar_depois_de_truncar_nota_maxima
trunca_para_nota_maxima:
mov.s $f1, $f4 # Move 10 para a media final
s.s $f1, 0($t3) # Armazenando média sem exame truncada para a nota maxima
continuar_depois_de_truncar_nota_maxima:
li $v0, 4 
la $a0, msg6
syscall # Printando mensagem para exibir a média do aluno
li $v0, 1
add $a0, $zero, $t4
syscall # Printando número do aluno
li $v0, 4
la $a0, msg8
syscall
l.s $f12, 0($t3)
li $v0, 2
syscall # Printando média do aluno sem exame
li $v0, 4
la $a0, msg9 # Quebrando linha para printar mensagem de aprovação ou de exame
syscall
l.s $f4, media_aprovacao # Carregando em $f4 a media para aprovação sem exame
c.lt.s $f1, $f4
bc1t cadastro_nota_de_exame
addi $t3, 4
li $v0, 4 
la $a0, msg12
syscall # Printando mensagem para informar que o aluno passou sem exame
li $v0, 4
la $a0, msg9 # Quebrando linha para obter notas de um novo aluno
syscall
l.s $f4, nota_exame_passou_direto
s.s $f4, 0($t3) # Defini a nota do exame de um aluno que passou direto como -1
addi $t3, 4
j fim_cadastro_notas
cadastro_nota_de_exame:
li $v0, 4
la $a0, msg10
syscall
li $v0, 6 # Recebe nota do aluno no exame
syscall
l.s $f4, denominador_media_com_exame # Carregando em $f4 denominador de media com exame (2)
add.s $f1, $f1, $f0
div.s $f1, $f1, $f4 # Calculando nova média com exame
li $v0, 4
la $a0, msg11
syscall
li $v0, 4
s.s $f1, 0($t3) # Armazenando nova média do aluno com exame
l.s $f12, 0($t3)
addi $t3, 4
s.s $f0, 0($t3) # Armazenando nota do exame
addi $t3, 4
li $v0, 2
syscall # Printando nova média do aluno com exame
li $v0, 4
la $a0, msg9 # Quebrando linha para printar notas de outros alunos
syscall
fim_cadastro_notas:
addi $t4, 1 
j loop_cadastro_de_notas

printa_dados_teste_strings:
addi $gp, $gp, 44
add $t0, $gp, $zero
lw $t1, 0($t0)
move $a0, $t1
li $v0, 4
syscall
j exit

printa_dados_teste_floats:
addi $gp, $gp, 44
add $t0, $gp, $zero
l.s $f12, 0($t0)
li $v0, 2
syscall
j exit

exit:
li $v0, 10
syscall

