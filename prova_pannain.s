 # Prova 1 - MC732 - 1s 2021 - Prof.: Ricardo Pannain, Aluno: Felipe Bueno Moret, RA: 155297
 # Código de um sistema academico de notas em MIPS/Assembly


.data

meio_float: .float 0.5

zero_float: .float 0.0

nota_maxima: .float 10.0

denominador_media_sem_exame: .float 10.0

denominador_media_com_exame: .float 2.0

nota_exame_passou_direto: .float -1.0

peso_prova_1: .float 3.0

peso_prova_2: .float 4.0

peso_prova_3: .float 3.0

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

msg13: .asciiz "\n\nO que você deseja fazer ?\n"

msg14: .asciiz "\nEntre com 1 para visualizar as notas e médias da turma."

msg15: .asciiz "\nEntre com 2 para alterar a nota de algum aluno."

msg16: .asciiz "\nEntre com 3 para finalizar o programa."

msg17: .asciiz "\nRA      NOME                NOTA P1     NOTA P2     NOTA P3     MEDIA FINAL NOTA EXAME    ESTADO"

msg18: .asciiz "  "

msg19: .asciiz " "

msg20: .asciiz "                            "

msg21: .asciiz "\nOBS: -1 em NOTA EXAME signfica que o aluno passou direto, não tendo assim nota para esse campo.\n"

msg22: .asciiz "\nPor favor, entre com o número do aluno que você deseja alterar a nota: "

msg23: .asciiz "\nEntre com o número da prova cuja nota será alterada: 1 para P1, 2 para P2, 3 para P3 e 4 para EXAME: "

msg24: .asciiz "\nEntre com o novo valor da nota: "

msg25: .asciiz "\nO aluno ficou em exame após essa alteração! Entre com a nota do exame: "

msg26: .asciiz "\nA média da turma é: "

msg27: .asciiz " APROVADO"

msg28: .asciiz "  REPROVADO"

msg29: .asciiz "\nInformamos que nosso sistema ordena os alunos por RA em ordem CRESCENTE. Sendo assim, desse ponto em diante considere:"

msg30: .asciiz "\n Aluno "

msg31: .asciiz " RA "

msg32: .asciiz "\nFim do Programa."

.text
.globl main

main:

li $s0, 5 # Defini o número de alunos como sendo 5

li $v0, 4
la $a0, msg0
syscall # Printa mensagem de boas-vindas

li $s1, 1 # Inicia o número de RAs cadastrados
li $s2, 1 # Inicia o número de nomes cadastrados
li $s4, 1 # Inicia o número de notas cadastradas
li $s6, 1 # Inicia numeros de alunos em ordem informados apos ordenacao

add $s5, $gp, $zero # Defini posição da memória onde começaremos a armazenar dados

loop_cadastro_de_RAs:
slt $t0, $s0, $s1 # Verificando se já cadastramos 5 RAs ou não
beq $t0, 1, ordena_RAs  # Se o cadastro dos 5 RAs já foi feito, passaremos à ordenacao dos RAs em ordem crescente
li $v0, 4 
la $a0, msg1
syscall # Printando mensagem para cadastrar RA do aluno
li $v0, 1
add $a0, $zero, $s1
syscall # Pritnando número do aluno
li $v0, 4
la $a0, msg7
syscall
li $v0, 5
syscall
add $t1, $v0, $zero # Armazena em $t1 o RA do aluno
sw $t1, 0($s5) # Armazena RA do aluno na memória
addi $s5, $s5, 4  # Incrementa endereço de armazenamento para futuros RAs 
addi $s1, 1 # Incrementa número de RAs já cadastrados
j loop_cadastro_de_RAs

ordena_RAs:
add $a0, $zero, $gp # Endereco base do vetor de RAs = $gp
addi $a1, $zero, 5 # Tamanho do vetor = 5
jal sort # Ordena vetor de RAs
li $v0, 4
la $a0, msg9
syscall # Quebra linha
li $v0, 4
la $a0, msg29
syscall # Informando o usuário ordenação realizada pelo sistema
li $v0, 4
la $a0, msg9
syscall # Quebra linha
loop_informar_nova_order: # Loop para informar ao usuario ordem dada aos alunos em funcao do RA
slt $t0, $s0, $s6
beq $t0, 1, fim_de_informacao_ordem # Nesse ponto já informamos a ordem completa ao usuario em funcao do RA
li $v0, 4
la $a0, msg30
syscall # Printa aluno em determinada ordem indicada por $s5
li $v0, 1
add $a0, $zero, $s6
syscall # Pritnando número do aluno na ordem crescente
li $v0, 4
la $a0, msg7
syscall # Printa dois pontos
li $v0, 4
la $a0, msg31
syscall # Printa a string " RA "
addi $t2, $s6, -1 # $t2 guardara endereco do RA do aluno posicionada na ordem dada por $s5
sll $t2, $t2, 2
add $t2, $t2, $gp # Endereço relativo do RA do aluno posicionado na posição dada por $s5 na ordenacao CRESCENTE de RAs
lw $t3, 0($t2) # Carrega o RA em $t3
li $v0, 1
add $a0, $zero, $t3
syscall # Printando RA do aluno nessa posição
addi $s6, $s6, 1
j loop_informar_nova_order

fim_de_informacao_ordem:
li $v0, 4
la $a0, msg9
syscall # Quebra linha
j loop_cadastro_de_nomes # Apos ordenacao, passaremos ao cadastro de nomes


loop_cadastro_de_nomes:
slt $t0, $s0, $s2 # Verificando se já cadastramos 5 nomes ou não
beq $t0, 1, loop_cadastro_de_notas  # Se o cadastro dos 5 alunos já foi feito, passaremos ao registro das notas da P1
li $v0, 4 
la $a0, msg2
syscall # Printando mensagem para cadastrar nome do aluno
li $v0, 1
add $a0, $zero, $s2
syscall # Printando número do aluno
li $v0, 4
la $a0, msg7
syscall

beq $s2, 1, primeiro_nome
beq $s2, 2, segundo_nome
beq $s2, 3, terceiro_nome
beq $s2, 4, quarto_nome
beq $s2, 5, quinto_nome

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
move $t1, $a0   # Salva string em $t1
sw $t1, 0($s5) # Armazena nome do aluno na memória
addi $s5, $s5, 4  # Incrementa endereço de armazenamento para futuros nomes
addi $s2, 1 # Incrementa número de nomes já cadastrados
j loop_cadastro_de_nomes


loop_cadastro_de_notas:
slt $t0, $s0, $s4 # Verifica se já foram cadastradas as notas dos 5 alunos
beq $t0, 1, opcoes_de_continuacao
l.s $f4, zero_float # Carregando zero em float point
add.s $f1, $f4, $f4 # Inicializando somador de notas ponderadas
li $v0, 4 
la $a0, msg3
syscall # Printando mensagem para cadastrar nota da P1 do aluno
li $v0, 1
add $a0, $zero, $s4
syscall # Printando número do aluno
li $v0, 4
la $a0, msg7
syscall
li $v0, 6 #Lendo nota da P1 do aluno
syscall
jal arredonda_nota_multiplo_meio
l.s $f4, peso_prova_1
mul.s $f4, $f0, $f4
add.s $f1, $f1, $f4 
s.s $f0, 0($s5)
addi $s5, 4
li $v0, 4 
la $a0, msg4
syscall # Printando mensagem para cadastrar nota da P2 do aluno
li $v0, 1
add $a0, $zero, $s4
syscall # Printando número do aluno
li $v0, 4
la $a0, msg7
syscall
li $v0, 6 #Lendo nota da P2 do aluno
syscall
jal arredonda_nota_multiplo_meio 
l.s $f4, peso_prova_2
mul.s $f4, $f0, $f4
add.s $f1, $f1, $f4
s.s $f0, 0($s5)
addi $s5, 4
li $v0, 4 
la $a0, msg5
syscall # Printando mensagem para cadastrar nota da P3 do aluno
li $v0, 1
add $a0, $zero, $s4
syscall # Printando número do aluno 
li $v0, 4
la $a0, msg7
syscall
li $v0, 6 # Lendo nota da P3 do aluno
syscall
jal arredonda_nota_multiplo_meio  
l.s $f4, peso_prova_3
mul.s $f4, $f0, $f4
add.s $f1, $f1, $f4
s.s $f0, 0($s5)
addi $s5, 4
l.s $f4, denominador_media_sem_exame # Carregando o denominador da media sem exame
div.s $f1, $f1, $f4 # Fazendo divisão da soma das notas ponderadas por 10
l.s $f4, nota_maxima
c.lt.s $f4, $f1 # Verificando se a media sem exame é maior do que a nota máxima permitida
bc1t trunca_para_nota_maxima # Se a media inicial for maior do que a nota máxima permitida, faremos o processo de truncamento para 10
jal arredonda_media_multiplo_meio
s.s $f1, 0($s5)
j continuar_depois_de_truncar_nota_maxima
trunca_para_nota_maxima:
mov.s $f1, $f4 # Move 10 para a media final
s.s $f1, 0($s5) # Armazenando média sem exame truncada para a nota maxima
continuar_depois_de_truncar_nota_maxima:
li $v0, 4 
la $a0, msg6
syscall # Printando mensagem para exibir a média do aluno
li $v0, 1
add $a0, $zero, $s4
syscall # Printando número do aluno
li $v0, 4
la $a0, msg8
syscall
l.s $f12, 0($s5)
li $v0, 2
syscall # Printando média do aluno sem exame
li $v0, 4
la $a0, msg9 # Quebrando linha para printar mensagem de aprovação ou de exame
syscall
l.s $f4, media_aprovacao # Carregando em $f4 a media para aprovação sem exame
c.lt.s $f1, $f4
bc1t cadastro_nota_de_exame
addi $s5, 4
li $v0, 4 
la $a0, msg12
syscall # Printando mensagem para informar que o aluno passou sem exame
li $v0, 4
la $a0, msg9 # Quebrando linha para obter notas de um novo aluno
syscall
l.s $f4, nota_exame_passou_direto
s.s $f4, 0($s5) # Defini a nota do exame de um aluno que passou direto como -1
addi $s5, 4
j fim_cadastro_notas
cadastro_nota_de_exame:
li $v0, 4
la $a0, msg10
syscall
li $v0, 6 # Recebe nota do aluno no exame
syscall
jal arredonda_nota_multiplo_meio # Arredonda nota do exame para o multiplo de 0.5 mais proximo
l.s $f4, denominador_media_com_exame # Carregando em $f4 denominador de media com exame (2)
add.s $f1, $f1, $f0
div.s $f1, $f1, $f4 # Calculando nova média com exame
li $v0, 4
la $a0, msg11
syscall # Printando mensagem de nova media
li $v0, 4
jal arredonda_media_multiplo_meio # Arredondando nova media para o multiplo de 0.5 mais proximo
s.s $f1, 0($s5) # Armazenando nova média do aluno com exame
l.s $f12, 0($s5)
addi $s5, 4
s.s $f0, 0($s5) # Armazenando nota do exame
addi $s5, 4
li $v0, 2
syscall # Printando nova média do aluno com exame
li $v0, 4
la $a0, msg9 # Quebrando linha para printar notas de outros alunos
syscall
fim_cadastro_notas:
addi $s4, 1 
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
l.s $f5, zero_float # Carrega em $f5 o zero de ponto flutuante, para inicializar somador de medias da turma
add.s $f6, $f5, $f5 # Inicializa somador de medias da turma
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

beq $t1, 0, aluno1_print
beq $t1, 1, aluno2_print
beq $t1, 2, aluno3_print
beq $t1, 3, aluno4_print
beq $t1, 4, aluno5_print


aluno1_print:
li $t3, 10
j printando_notas

aluno2_print:
li $t3, 14
j printando_notas

aluno3_print:
li $t3, 18
j printando_notas

aluno4_print:
li $t3, 22 
j printando_notas

aluno5_print:
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


#PRINTANDO MEDIA DO ALUNO
addi $t7, $t7, 4
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_floats # Printando media final do aluno
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha
add.s $f6, $f6, $f12 # Soma a media do aluno no somador de medias da turma
mov.s $f8, $f12 # $f8 recebe a media do aluno


#PRINTANDO NOTA DO EXAME
addi $t7, $t7, 4
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra
sw $ra, 0($sp) # Guardando endereço de retorno de visualizar_notas
jal printa_floats # Printando nota do exame do aluno
lw $ra, 0($sp) # Recupera $ra de visualizar_notas
addi $sp, $sp, 4 # Faz o pop da pilha
l.s $f5, media_aprovacao
c.lt.s $f8, $f5
bc1t aluno_reprovado
li $v0, 4
la $a0, msg27
syscall # Printa mensagem de aluno APROVADO
j estado_final_decidido
aluno_reprovado:
li $v0, 4
la $a0, msg28
syscall # Printa mensagem de aluno REPROVADO
estado_final_decidido:

addi $t1, $t1, 1 # Incrementa contagem de alunos que os dados ja foram escritos


j loop_printa_dados_aluno
fim_impressao:
li $v0, 4
la $a0, msg21
syscall # Printa legenda da integralização com o significado de -1 em NOTA EXAME
l.s $f5, media_aprovacao # $f5 recebe 5, para fazermos a media das medias da turma
div.s $f6, $f6, $f5 # Calcula a media das medias da turma
li $v0, 4
la $a0, msg26
syscall # Printando media da turma
mov.s $f12, $f6
li $v0, 2
syscall
jr $ra

# Função para alterar alguma nota do aluno e recalcular a média com nova nota
alterar_notas:
li $v0, 4
la $a0, msg22
syscall # Printando mensagem para usuário escolher aluno a ter a nota alterada
li $v0, 5
syscall # Lendo número do aluno 
add $t1, $v0, $zero # Transferindo para $t1 número do aluno cuja nota será alterada
li $v0, 4
la $a0, msg23
syscall # Printando mensagem para usuário escolher a prova do aluno cuja nota será alterada
li $v0, 5
syscall # Lendo número da prova do aluno que terá a nota alterada
add $t2, $v0, $zero # Transferindo para $t2 número da prova do aluno cuja nota será alterada

beq $t1, 1, aluno1_notas
beq $t1, 2, aluno2_notas
beq $t1, 3, aluno3_notas
beq $t1, 4, aluno4_notas
beq $t1, 5, aluno5_notas

aluno1_notas:
li $t0, 10 # $t0 guarda o endereço relativo do começo das notas do aluno escolhido em relação à $gp
add $t3, $t0, 0 # $t3 = $t0 = endereço relativo do comneço das notas do aluno escolhio, para uso posterior em recalcula_media
j deslocamento_para_a_prova # jump para acessar posição de memória absoluta onde a nota da prova escolhida está armazenada
aluno2_notas:
li $t0, 15
add $t3, $t0, 0 # $t3 = $t0 = endereço relativo do comneço das notas do aluno escolhio, para uso posterior em recalcula_media
j deslocamento_para_a_prova
aluno3_notas:
li $t0, 20
add $t3, $t0, 0 # $t3 = $t0 = endereço relativo do comneço das notas do aluno escolhio, para uso posterior em recalcula_media
j deslocamento_para_a_prova
aluno4_notas:
li $t0, 25
add $t3, $t0, 0 # $t3 = $t0 = endereço relativo do comneço das notas do aluno escolhio, para uso posterior em recalcula_media
j deslocamento_para_a_prova
aluno5_notas:
li $t0, 30
add $t3, $t0, 0 # $t3 = $t0 = endereço relativo do comneço das notas do aluno escolhio, para uso posterior em recalcula_media

deslocamento_para_a_prova:

beq $t2, 1, prova1 # Switch de deslocamento para a P1
beq $t2, 2, prova2 # Switch de deslocamento para a P2
beq $t2, 3, prova3 # Switch de deslocamento para a P3
beq $t2, 4, exame # Switch de deslocamento para o exame

prova1:
addi $t0, $t0, 0 # $t0 guarda o endereço relativo da prova escolhida escolhida em relação à $gp
j recebe_nova_nota # jump para receber nova nota e armazenar na posição de memória guardada em $t0 (após multiplicado por 4 e somado com $gp)
prova2:
addi $t0, $t0, 1
j recebe_nova_nota
prova3:
addi $t0, $t0, 2
j recebe_nova_nota
exame:
addi $t0, $t0, 3

recebe_nova_nota:
li $v0, 4
la $a0, msg24
syscall # Printa requisição de nova nota
li $v0, 6
syscall # Recebe em $f0 nova nota
sll $t0, $t0, 2 # Multiplica $t0 por 4 para pegar endereço relativo em bytes
add $t0, $t0, $gp # Adiciona $t0 com $gp para obter endereço absoluto da posição da nota a ser alterada
addi $sp, $sp, -4 # Abre espaço na pilha para guardar endereço de retorno de alterar_notas ($ra)
sw $ra, 0($sp)
jal arredonda_nota_multiplo_meio # Arredonda nova nota para o nultiplo de 0.5 mais proximo
lw $ra, 0($sp) 
addi $sp, $sp, 4 # Faz pop da pilha
s.s $f0, 0($t0) # Armaneza nova nota recebida já arredondada
addi $sp, $sp, -4 # Abre espaço na pilha para guardar endereço de retorno de alterar_notas ($ra)
sw $ra, 0($sp)
jal recalcula_media # Recalcula a media do aluno com a nova nota
lw $ra, 0($sp) # Recupera $ra
addi $sp, $sp, 4 # Faz pop de $ra
jr $ra


#Função para recalcular a media de um aluno após alteração de alguma nota
recalcula_media:
sll $t3, $t3, 2 # Calcula endereço relativo do começo do vetor onde as notas do aluno (cuja nota foi alterada) se encontra
add $t3, $t3, $gp # Calcula endereço absoluo do começo do vetor onde as notas do aluno (cuja nota foi alterada) se encontra
l.s $f2, zero_float # Carrega em $f2 o valor 0.0 (float)
add.s $f1, $f2, $f2 # Inicializa o somador de notas $f1 = 0
l.s $f3, 0($t3) # Carrega nota da P1 do aluno escolhido em alterar_notas em $f3
l.s $f2, peso_prova_1 # Carrega em $f2 peso da primeira prova
mul.s $f3, $f3, $f2 # Carrega em $f3 nota da P1 multiplicada por seu peso
l.s $f4, 4($t3) # Carrega nota da P2 do aluno escolhido em alterar_notas em $f4
l.s $f2, peso_prova_2 # Carrega em $f2 peso da segunda prova
mul.s $f4, $f4, $f2 # Carrega em $f4 nota da P2 multiplicada por seu peso
l.s $f5, 8($t3) # Carrega nota da P3 do aluno escolhido em alterar_notas em $f5
l.s $f2, peso_prova_3 # Carrega em $f2 peso da terceira prova
mul.s $f5, $f5, $f2 # Carrega em $f5 nota da P3 multiplicada por seu peso
add.s $f1, $f1, $f3 # $f1 = $f1 + P1
add.s $f1, $f1, $f4 # $f1 = $f1 + P2
add.s $f1, $f1, $f5 # $f1 = $f1 + P3
l.s $f2, denominador_media_sem_exame # Carrega em $f2 o valor 10.0 (float), para usar como denominador da média sem exame
div.s $f1, $f1, $f2
c.lt.s $f2, $f1 # Verificando se a media sem exame é maior do que a nota máxima permitida
bc1t arredonda_para_10 # Se a nova media for maior do 10, arredonda esta media para 10.0 e retorna
l.s $f2, media_aprovacao
c.lt.s $f1, $f2
bc1f passou_sem_exame
addi $sp, $sp, -4 # Abre espaço para armazenar $ra de recalcula_media
sw $ra, 0($sp) # Armazena na pilha $ra de recalcula media
jal ficou_de_exame_apos_alteracao
lw $ra, 0($sp)
addi $sp, $sp, 4 # Faz pop de $ra de recalcula_media
jr $ra

passou_sem_exame: 
addi $sp, $sp, -4 # Abre espaço na pilha para armazenar $ra de recalcula_media
sw $ra, 0($sp) # Armazena na pilha $ra de recalcula_media
jal arredonda_media_multiplo_meio # Arredonda media para o multiplo de 0.5 mais proximo
lw $ra, 0($sp) # Recupera $ra de recalcula_media
addi $sp, $sp, 4 # Faz pop de $ra de recalcula_media
s.s $f1, 12($t3) # Armazena nova media
l.s $f2, nota_exame_passou_direto # Armazena -1 em $f2
s.s $f2, 16($t3)  # Defini a nota do exame do aluno como -1, visto que ele passou com uma media superior ou igual a 5.0, e não precisou fazer exame
jr $ra # Retorna para ponto de chamada em alterar_notas


arredonda_para_10: 
mov.s $f1, $f2 # Se a nova media for maior do que 10, ela recebe o valor maximo permitido (10) nesse ponto
s.s $f1, 12($t3) # Armazena nova media
l.s $f2, nota_exame_passou_direto # Armazena -1 em $f2
s.s $f2, 16($t3)  # Defini a nota do exame do aluno como -1, visto que ele passou com nota maxima, e não precisou fazer exame
jr $ra # Retorna para ponto de chamada em alterar_notas


ficou_de_exame_apos_alteracao:
li $v0, 4
la $a0, msg25
syscall # Printa mensagem de exame após alteração, requerindo nota do exame
li $v0, 6
syscall # Recebe em $f0 nova nota para o exame
addi $sp, $sp, -4 # Abre espaço na pilha para guardar $ra de ficou_de_exame_apos_alteracao
sw $ra, 0($sp) # Armazena $ra de ficou_de_exame_apos_alteracao na pilha
jal arredonda_nota_multiplo_meio # Arredonda nova nota do exame para o multiplo mais proximo de 0.5
lw $ra, 0($sp) # Recupera $ra de ficou_de_exame_apos_alteracao
addi $sp, $sp, 4 # Faz o pop de $ra
add.s $f1, $f1, $f0 # soma de medias para quem ficou em exame = media das provas + nota do exame
l.s $f2, denominador_media_com_exame # $f2 = 2
div.s $f1, $f1, $f2 # $f1 = $f1/2 é a nova media
sw $ra, 0($sp) # Armazena $ra de ficou_de_exame_apos_alteracao na pilha
jal arredonda_media_multiplo_meio # Arredonda media final para o multiplo mauis proximo de 0.5
lw $ra, 0($sp) # Recupera $ra de ficou_de_exame_apos_alteracao
addi $sp, $sp, 4 # Faz o pop de $ra
s.s $f1, 12($t3) # Armazena nova media
s.s $f0, 16($t3)  # Armazena nova nota para o exame e retorna para alterar_notas
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


# Função para fazer o sort dos RAs - Algoritmo: Bubble Sort
sort:
addi $sp, $sp, -20 #Ajustando a pilha para salvarmos 5 dados
sw $ra, 16($sp) #Salvando endereço de retorno na pilha
sw $s3, 12($sp) #Salvamos o registrador $s3 na pilha, pois o usaremos no algoritmo e pela convençao do MIPS devemos ter como hipotese o preservamento de dados nesse registrador
sw $s2, 8($sp) #Idem ao comando anterior para $s2
sw $s1, 4($sp) #Idem ao comando anterior para $s1
sw $s0, 0($sp) #Idem ao comando anterior para $s0
move $s2, $a0 #Salvamos o endereço base do vetor v em $s2
move $s3, $a1 #Salvamos o tamanho do vetor v em $s3
move $s0, $zero #i = 1 para comecarmos o loop mais externo

loopexterno:
slt $t0, $s0, $s3 #$t0 = 1 se i < n
beq $t0, $zero, saida1 #Se i >= n, pulamos para saida1
addi $s1, $s0, -1 # j = i - 1

loopinterno:
slti $t0, $s1, 0 #$t0 = 1 se j < 0
bne $t0, $zero, saida2 # Se j < 0, pulamos para saida2
sll $t1, $s1, 2 # t1 = 4*j
add $t2, $s2, $t1 #$t2 = v + 4*j
lw $t3, 0($t2) #$t3 = v[j]
lw $t4, 4($t2) #$t4 = v[j+1]
slt $t0, $t4, $t3 #$t0 = 0 se v[j+1] < v[j]
beq $t0, $zero, saida2 #Pulamos para saida2 se v[j+1] >= v[j]
move $a0, $s2 #Setando o primeiro parametro de swap, ou seja, endereço base de v
move $a1, $s1 #Segundo parametro de swap é j (para trocarmos)
jal swap
addi $s1, $s1, -1 # j -=1
j loopinterno #pulando para o loop do j

saida2:
addi $s0, $s0, 1 #i += 1
j loopexterno #Pulando para o loop do i

saida1:
lw $s0, 0($sp) #Coletando $s0 na pilha
lw $s1, 4($sp) #Coletando $s1 na pilha
lw $s2, 8($sp) #Coletando $s2 na pilha
lw $s3, 12($sp) #Coletando $s3 na pilha
lw $ra, 16($sp) #Coletando $ra na pilha
addi $sp, $sp, 20 #Ajustando ponteiro da pilha
jr $ra #Retornando ao ponto de chamada

swap:
sll $t1, $a1, 2 #Dado que $a1 = k, aqui fazemos $t1 = 4*k, para assim obtermos o endereço em bytes do deslocamento k
add $t1, $a0, $t1 #Endereço de v[k]

lw $t0, 0($t1) #Carregamos v[k] em $t0
lw $t2, 4($t1) #Carregamos v[k+1] em $t2
sw $t2, 0($t1) #Salvamos v[k+1] na posicao k do vetor
sw $t0, 4($t1) #Salvamos v[k] na posicao k+1 do vetor

jr $ra

fim_do_programa:
li $v0, 4
la $a0, msg32
syscall
li $v0, 10
syscall
