# Projeto 1 - Entrega Final

## Descrição

### O que faz?
Este projeto implementa um sistema embarcado no microcontrolador 8051 capaz de contar eventos externos (pulsos de um sensor acoplado a um motor) utilizando o Timer 1 como contador. O número de eventos é exibido em um display de 7 segmentos, limitado de 0 a 9. Além disso, o sistema permite alterar o sentido de rotação do motor por meio de uma chave, garantindo que a contagem seja reiniciada a cada mudança de direção.

---

### Como é construído?
O sistema foi desenvolvido em linguagem Assembly para o 8051 e possui três blocos principais:

- **Contagem de eventos:**  
  O Timer 1 foi configurado em modo contador externo (C/T = 1), incrementando a cada pulso recebido no pino P3.5. Utiliza-se o modo 2 (auto-reload), permitindo gerar uma interrupção a cada 10 pulsos.

- **Controle por interrupção:**  
  Ao atingir 10 eventos, ocorre uma interrupção do Timer 1, que executa uma rotina responsável por reiniciar a contagem (TL1) e zerar a variável de processo, garantindo que o sistema opere de forma cíclica entre 0 e 9.

- **Interface e controle do usuário:**  
  Uma chave conectada em P2.0 permite alternar o sentido de rotação do motor. Essa mudança é tratada por uma lógica de máquina de estados, que também força o reset da contagem para manter consistência nos dados exibidos.

- **Exibição no display:**  
  O valor da contagem é convertido por uma tabela (lookup table) e enviado ao display de 7 segmentos (ânodo comum) via porta P1. O ponto decimal (P1.7) é utilizado para indicar o sentido de rotação do motor.

---

### Por que?
O projeto tem como objetivo integrar conceitos fundamentais de sistemas microprocessados, como:
- uso de temporizadores como contadores externos;
- manipulação de interrupções;
- controle de fluxo com máquina de estados;
- interface com dispositivos de entrada e saída (botões e display);
- sincronização entre hardware e software.

Além disso, simula um cenário real de controle de motor com monitoramento de rotação e indicação visual.

---

## Instruções de Uso

1. Carregar o código no simulador EdSim51.
2. Configurar o pino P3.5 como entrada de pulsos (simulando o sensor do motor).
3. Utilizar a chave conectada em P2.0 para alterar o sentido de rotação.
4. Observar o display de 7 segmentos (P1):
   - Os números indicam a quantidade de pulsos (0 a 9).
   - O ponto decimal indica o sentido de rotação:
     - Aceso → anti-horário  
     - Apagado → horário
5. A cada 10 pulsos, o sistema reinicia automaticamente a contagem.

---

## Contribuição

Henrique Gaspar Monteiro — N° USP: 15459073  
Julia de Oliveira Giglio — N° USP: 15465167
