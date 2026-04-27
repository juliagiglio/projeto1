# Projeto 1 - Entrega Final

## Descrição

### O que faz?
Este projeto implementa um sistema embarcado baseado no microcontrolador 8051 para controle de rotação de um motor DC e contagem de voltas. A contagem é realizada por meio de um sensor óptico conectado ao pino P3.5, sendo exibida em um display de 7 segmentos.

O sistema também permite alterar o sentido de rotação do motor e garante que a contagem exibida esteja sempre coerente com o sentido atual de operação.

---

### Como é construído?
O sistema foi desenvolvido em linguagem Assembly para o 8051 e é composto pelos seguintes blocos principais:

- Utilização do **Timer 1 como contador externo**, responsável por registrar os pulsos provenientes do sensor  
- Uso de **interrupção de hardware** para controle do limite de contagem, evitando polling no laço principal  
- Implementação de uma **máquina de estados** para controle da direção do motor  
- Interface com **display de 7 segmentos (ânodo comum)** para visualização da contagem  

---

### Por que?
O projeto tem como objetivo integrar conceitos fundamentais de sistemas microprocessados, tais como:

- contagem de eventos externos  
- uso de interrupções  
- controle de periféricos  
- sincronização entre hardware e software  

Além disso, simula um sistema real de monitoramento de rotação de motores com indicação visual e controle de direção.

---

## Funcionalidades

- **Controle de direção (toggle):**  
  Alterna entre sentido horário e anti-horário por meio da chave conectada ao pino P2.0  

- **Contagem de voltas (0–9):**  
  Pulsos do sensor são contabilizados pelo Timer 1 (entrada em P3.5)  

- **Reset automático:**  
  Ao atingir 10 pulsos, a contagem é reiniciada automaticamente por meio de interrupção  

- **Sincronização de sentido:**  
  A contagem é zerada sempre que ocorre mudança de direção, garantindo coerência dos dados exibidos  

- **Sinalização visual:**  
  O ponto decimal do display (P1.7) indica o sentido de rotação:  
  - Aceso → sentido anti-horário  
  - Apagado → sentido horário  

---

## Detalhes de Implementação

- **Configuração do Timer 1:**  
  - TMOD = 60h  
  - Operando como contador externo (C/T = 1)  
  - Modo 2 (8-bit auto-reload)  

- **Valor de recarga:**  
  - TH1 = F6h  
  - Gera interrupção a cada 10 pulsos  

- **Interrupção do Timer 1 (endereço 001Bh):**  
  Responsável por reiniciar a contagem automaticamente  

- **Exibição no display:**  
  Realizada por meio de tabela de conversão (Look-up Table) acessada com a instrução MOVC  

---

## Instruções de Uso

1. Carregar o código no simulador EdSim51  
2. Montar o código (ASSM)  
3. Configurar o motor no painel do simulador  
4. Executar o programa (RUN)  
5. Observar:  
   - Contagem no display (0 a 9)  
   - Indicação de sentido pelo ponto decimal  
6. Utilizar o switch (P2.0) para:  
   - Alternar o sentido de rotação  
   - Reiniciar a contagem automaticamente  

---

## Referências

Para a construção do código:
- Material de aula disponibilizado na plataforma Moodle  
- Checkpoints anteriores à entrega final  
- Documentação do microcontrolador 8051  

Para o desenvolvimento do README:
- https://www.youtube.com/watch?v=k4Rsy8GbKE0  

---

## Contribuição

Henrique Gaspar Monteiro — N° USP: 15459073  
Julia de Oliveira Giglio — N° USP: 15465167
