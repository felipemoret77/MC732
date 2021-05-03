 

.data

meio_float: .float 0.5

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

msg0: .asciiz "\nBem Vindo ao Portal de Notas! Estaremos agora cadastrando dados para os 5 alunos da melhor turma de MC732! \n"

msg1: .asciiz "\nEntre com o numero de RA do aluno "

msg2: .asciiz "\nEntre com o nome do aluno "

msg3: .asciiz "\nEntre com um valor para a nota da P1 do aluno "

msg4: .asciiz "\nEntre com um valor para a nota da P2 do aluno "

msg5: .asciiz "\nEntre com um valor para a nota da P3 do aluno "

msg6: .asciiz "\nA média do aluno "

msg7: .asciiz ": "

msg8: .asciiz " é: "

msg9: .asciiz "\n"

msg10: .asciiz "\nInfelizmente esse aluno ficou de exame :( ! Entre com a nota do exame: "

msg11: .asciiz "\nA nova média desse aluno é: "

msg12: .asciiz "\nEsse aluno passou sem exame ! :)"

msg13: .asciiz "\nO que você deseja fazer ?\n"

msg14: .asciiz "\nEntre com 1 para visualizar as notas e médias da turma"

msg15: .asciiz "\nEntre com 2 para alterar a nota de algum aluno"

msg16: .asciiz "\nEntre com 3 para finalizar o programa"

msg17: .asciiz "\nRA      NOME                NOTA P1     NOTA P2     NOTA P3     MEDIA FINAL NOTA EXAME"

msg18: .asciiz "  "

msg19: .asciiz " "

msg20: .asciiz "                            "

msg21: .asciiz "\n Fim do Programa"

.text
.globl main

main:

li $s0, 5 # Defini o número de alunos como sendo 5

li $v0, 4
la $a0, msg0
syscall # Printa mensagem de boas-vindas

li $t1, 1 #Inicia o número de RAs cadastrados
li $t2, 1 #Inicia o número de nomes cadastrados
li $t4, 1 #Inicia o número de notas cadastradas

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
beq $t0, 1, opcoes_de_continuacao
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
jal arredonda_nota_multiplo_meio
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
jal arredonda_nota_multiplo_meio 
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
jal arredonda_nota_multiplo_meio  
s.s $f0, 0($t3)
addi $t3, 4
l.s $f4, denominador_media_sem_exame # Carregando o denominador da media sem exame
div.s $f1, $f1, $f4 # Fazendo divisão da soma das notas ponderadas por 10
l.s $f4, nota_maxima
c.lt.s $f4, $f1 # Verificando se a media sem exame é maior do que a nota máxima permitida
bc1t trunca_para_nota_maxima # Se a media inicial for maior do que a nota máxima permitida, faremos o processo de truncamento para 10
jal arredonda_media_multiplo_meio
s.s $f1, 0($t3)
j continuar_depois_de_truncar_nota_maxima
trunca_para_nota_maxima:
mov.s $f1, $f4 # Move 10 para a media final
jal arredonda_media_multiplo_meio
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
jal arredonda_media_multiplo_meio
s.s $f1, 0($t3) # Armazenando nova média do aluno com exame
l.s $f12, 0($t3)
addi $t3, 4
jal arredonda_nota_multiplo_meio
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


# Codigo responsavel por exebir menu de escolha de funcionalidades apos cadastros: visualizacao de notas, alteracao de notas, encerramento do programa
opcoes_de_continuacao:
li $v0, 4
la $a0, msg13
syscall
li $v0, 4
la $a0, msg14
syscall
li $v0, 4
la $a0, msg15
syscall
li $v0, 4
la $a0, msg16
syscall
li $v0, 4
la $a0, msg9
syscall
li $v0, 5
syscall  # Lê qual opção de continuação o usuário escolheu
add $t0, $v0, $zero # Armazena em $t0 opção escolhida pelo usuário
beq $t0, 3, fim_do_programa # Branch para o fim do programa
beq $t0, 1, visualizacao_de_notas # Branch para a visualizacao de notas
beq $t0, 2, alteracao_de_notas # Branch para a alteracao de notas
visualizacao_de_notas:
jal visualizar_notas
j opcoes_de_continuacao
alteracao_de_notas:
jal alterar_notas
j opcoes_de_continuacao


# Funcao responsavel pela impressão das notas da turma
visualizar_notas:
li $v0, 4
la $a0, msg17
syscall # Printa cabeçalho
li $t1, 0 # Incializando números de linhas já impressas
addi $t6, $s0, -1 #t6 = 4 é o numero da ultima linha a ser impressa, começando a contagem do zero: linha 0, 1, 2, 3, 4.
loop_printa_dados_aluno:
li $v0, 4
la $a0, msg9
syscall
slt $t0, $t6, $t1
beq $t0, 1, fim_impressao
sll $t7, $t1, 2 # $t7 = 4*$t1 nesse momento tem o endereço relativo ao começo da memoria (em bytes) onde o RA esta armazenado
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_ints # Printado RA do aluno com funcao auxiliar
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha
li $v0, 4
la $a0, msg18
syscall # Printando espaço para imprimir o nome do aluno
addi $t2, $t1, 5 # Posição relativa do nome em relação ao RA
sll $t7, $t2, 2 # $t7 = 4*$t2 nesse momento tem o endereço relativo ao começo da memoria (em bytes) onde o nome esta armazenado
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_strings # Printado nome do aluno com funcao auxiliar
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha
li $v0, 4
la $a0, msg20
syscall # Printando espaço para imprimir o nota na P1 do aluno

beq $t1, 0, aluno1
beq $t1, 1, aluno2
beq $t1, 2, aluno3
beq $t1, 3, aluno4
beq $t1, 4, aluno5


aluno1:
li $t3, 10
j printando_notas

aluno2:
li $t3, 14
j printando_notas

aluno3:
li $t3, 18
j printando_notas

aluno4:
li $t3, 22 
j printando_notas

aluno5:
li $t3, 26

printando_notas:
# PRINTANDO NOTAS DA P1
add $t2, $t1, $t3
sll $t7, $t2, 2 #$t7 = 4*$t2 nesse momento tem o endereço relativo ao começo da memoria (em bytes) onde a nota da P1 do aluno esta armazenada
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_floats # Printando nota da P1 do aluno
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha
#li $v0, 4
#la $a0, msg19
#syscall # Printando espaço para imprimir o nota na P2 do aluno

#PRINTANDO NOTAS DA P2
addi $t7, $t7, 4
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_floats # Printando nota da P2 do aluno
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha
#li $v0, 4
#la $a0, msg19
#syscall # Printando espaço para imprimir o nota na P3 do aluno

#PRINTANDO NOTAS DA P3
addi $t7, $t7, 4
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_floats # Printando nota da P3 do aluno
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha
#li $v0, 4
#la $a0, msg19
#syscall # Printando espaço para imprimir a media do aluno

#PRINTANDO MEDIA DO ALUNO
addi $t7, $t7, 4
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_floats # Printando media final do aluno
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha
#li $v0, 4
#la $a0, msg19
#syscall # Printando espaço para imprimir a nota do exame do aluno

#PRINTANDO NOTA DO EXAME
addi $t7, $t7, 4
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_floats # Printando nota do exame do aluno
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha


addi $t1, $t1, 1 # Incrementa contagem de alunos que os dados ja foram escritos


j loop_printa_dados_aluno
fim_impressao:
jr $ra


#Funcao que arredonda o conteudo de $f1 (medias) para o multiplo de 0.5 mais proximo
arredonda_media_multiplo_meio:
l.s $f4, zero_float
l.s $f5, meio_float
loop_media_arredonda:
c.le.s $f4, $f1
bc1t soma_meio_media
sub.s $f5, $f4, $f5
sub.s $f6, $f1, $f5
abs.s $f6, $f6 # $f6 recebe  |$f1 - $f5|, onde $f5 é a aproximacao por baixo de $f1 (media) em multiplos de 0.5
sub.s $f7, $f1, $f4 
abs.s $f7, $f7 # $f7 recebe |$f1 - $f4|, onde $f4 é a aproximacao por cima de $f1 (media) em multiplos de 0.5
c.le.s $f6, $f7
bc1t arredonda_media_por_baixo
mov.s $f1, $f4
jr $ra
arredonda_media_por_baixo:
mov.s $f1, $f5
jr $ra
soma_meio_media:
add.s $f4, $f4, $f5
j loop_media_arredonda


#Funcao que arredonda o conteudo de $f0 (notas) para o multiplo de 0.5 mais proximo
arredonda_nota_multiplo_meio:
l.s $f4, zero_float
l.s $f5, meio_float
loop_nota_arredonda:
c.le.s $f4, $f0
bc1t soma_meio_nota
sub.s $f5, $f4, $f5
sub.s $f6, $f0, $f5
abs.s $f6, $f6 # $f6 recebe  |$f0 - $f5|, onde $f5 é a aproximacao por baixo de $f0 (nota) em multiplos de 0.5
sub.s $f7, $f0, $f4 
abs.s $f7, $f7 # $f7 recebe |$f0 - $f4|, onde $f4 é a aproximacao por cima de $f0 (nota) em multiplos de 0.5
c.le.s $f6, $f7
bc1t arredonda_nota_por_baixo
mov.s $f0, $f4
jr $ra
arredonda_nota_por_baixo:
mov.s $f0, $f5
jr $ra
soma_meio_nota:
add.s $f4, $f4, $f5
j loop_nota_arredonda



#Funcao para printar strings armazenadas na memoria no endereço dado por $t0 = $gp + offset
printa_strings:
add $t0, $gp, $t7
lw $t8, 0($t0) # Carregamos em $t8 a string a ser impressa
move $a0, $t8
li $v0, 4
syscall
jr $ra

# Funcao para printar ints armazenados na memoria no endereço dado por $t0 = $gp + $t7 (offset em $t7)
printa_ints:
add $t0, $gp, $t7
lw $t8, 0($t0) # Carregamos em $t8 o int a ser impresso
li $v0, 1
add $a0, $zero, $t8
syscall
jr $ra

# Funcao para printar floats armazenados na memoria no endereço dado por $t0 = $gp + $t7 (offset em $t7)
printa_floats:
add $t0, $gp, $t7
lwc1 $f12, 0($t0)
li $v0, 2
syscall
l.s $f4, nota_maxima
c.eq.s $f12, $f4
bc1t printa_um_espaco
li $v0, 4
la $a0, msg18
syscall # Printando dois espaços para o próximo float se o numero anterior for menor do que 10.0
jr $ra
printa_um_espaco:
li $v0, 4
la $a0, msg19
syscall # Printando um único espaço para o próximi float se o numero anterior for 10.0
jr $ra

fim_do_programa:
li $v0, 4
la $a0, msg21
syscall
li $v0, 10
syscall

