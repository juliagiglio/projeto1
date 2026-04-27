; Projeto 1 - ENTREGA FINAL
; Henrique Gaspar Monteiro nUSP 15459073
; Julia de Oliveira Giglio nUSP 15465167


ORG 0000h
    LJMP INICIO

;interrupção timer1
ORG 001Bh               
    LJMP ISR_T1         ;Salta para a rotina de interrupção do timer1

ORG 0030h
INICIO:
    MOV SP, #07h            ;inicia o stack pointer
    
    ;configuração timer1
    ; TMOD = 60h -> Timer 1, Modo 2 (8-bit Auto-reload), Contador Externo (P3.5)
    MOV TMOD, #60h      
    MOV TH1, #0F6h          ;define a contagem de 10 pulsos
    MOV TL1, #0F6h          
    
    ; --- HABILITAÇÃO DE INTERRUPÇÕES ---
    SETB ET1                ;habilita interrupção do timer1
    SETB EA                 ;habilita interrupções globais
    SETB TR1                ;liga o contador

    ; inicia variáveis e portas
    CLR F0                  ;0 - Horário, 1 - anti-horário
    MOV 20h, #00h           
    SETB P2.0               ;botão
    ACALL ATUALIZA_DISPLAY  

MAIN_LOOP:
    ACALL VERIFICAR         ;verifica botão e mudança de direção
    ACALL ATUALIZA_DISPLAY  ;atualiza display
    SJMP MAIN_LOOP

;rotina de interrupção timer1
ISR_T1:
    ;timer conta de F6h até FFh e gera overflow
    CLR TR1                 ;para o contador
    MOV 20h, #00h           ;zera variável de processo
    MOV TL1, #0F6h          ;recarrega valor inicial
    SETB TR1                ;religa contador
    RETI

; direção
VERIFICAR:
    MOV C, P2.0             
    JB F0, ESTADO_UM        
    JNC RETORNO_SUB         
    ACALL MUDANCA_DIR       
    RET

ESTADO_UM:
    JC RETORNO_SUB          
    ACALL MUDANCA_DIR       
    RET

RETORNO_SUB:
    RET

MUDANCA_DIR:
    CPL F0                  ;inverte direção 
    ACALL RESET_TIMER       ;reseta contagem
    JB F0, S_ANT_HR         

S_HR:
    SETB P3.0               ;sentido horário
    CLR P3.1                
    RET

S_ANT_HR:
    SETB P3.1               ;sentido anti-horário
    CLR P3.0                
    RET

;subrotina de reset
RESET_TIMER:
    CLR TR1                 ;para contador
    MOV TL1, #0F6h          ;recarrega
    MOV 20h, #00h           ;zera variável
    SETB TR1                ;religa
    RET

;subrotina para exibição
ATUALIZA_DISPLAY:
    MOV A, TL1              ;le valor atual do contador
    CLR C
    SUBB A, #0F6h           ;calcula valor (0 a 9)
    MOV 20h, A              ;atualiza variável

    MOV DPTR, #TABELA_7SEG
    MOVC A, @A+DPTR         ;
    
    ;indicação do sentido com ponto
    JNB F0, PONTO_DES       ;F0 = 0, ponto desligado
    ANL A, #7Fh             ;liga ponto
    SJMP ENVIA

PONTO_DES:
    ORL A, #80h             ;desliga ponto

ENVIA:
    MOV P1, A               
    RET

;tabela 7 segmentos
TABELA_7SEG:
    DB 0C0h, 0F9h, 0A4h, 0B0h, 099h
    DB 092h, 082h, 0F8h, 080h, 090h

END 
