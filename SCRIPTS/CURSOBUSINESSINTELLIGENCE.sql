CURSO BUSINESS INTELLIGENCE 

// CRIANDO CALENDARIO //

D_CALENDARIO = CALENDAR(DATE(2021,03,01),DATE(2021,12,31)) /* CRIANDO CALENDARIO DO ANO */

DEPOIS DISSO, TRANSFORMA-LA EM TABELA CALENDARIO, FERRAMENTAS DE TABELA > MARCAR COMO TABELA DE DATA
 
 CRIANDO DEMAIS COLUNAS
DIA = DAY(D_CALENDARIO[Data]) /* COLUNA DIA*/
MÊS = MONTH(D_CALENDARIO[Data]) /* COLUNA MÊS*/
ANO = YEAR(D_CALENDARIO[Data]) /* COLUNA ANO*/
DIA DA SEMANA = WEEKDAY(D_CALENDARIO[Data]) /* MOSTRANDO QUAL O DIA DA SEMANA DO MÊS NOVA COLUNA*/
DIA UTIL = IF(D_CALENDARIO[Dia Semana]=7,"N",IF(D_CALENDARIO[Dia Semana] = 1,"N","S")) OU
DIA UTIL = IF(D_CALENDARIO[DIA SEMANA] = 7 || D_CALENDARIO[DIA SEMANA] = 1,"N", "S")  /* MOSTRAR QUAL DIA É UTIL */
ANO/MES = FORMAT(D_CALENDARIO[Data],"MMM/YYYY")  /* MOSTRAR O MES/ANO */
DIA = DAY(D_CALENDARIO[Data])
MÊS = MONTH(D_CALENDARIO[Data])
ANO = YEAR(D_CALENDARIO[Data])
DIA DA SEMANA EXTENSO = FORMAT(D_CALENDARIO[DIA DA SEMANA],"DDDD") 
MES EXTENSO = FORMAT(D_CALENDARIO[Data],"MMMM")
MES/ANO = FORMAT(D_CALENDARIO[Data],"MM/YYYY") 
TRIMESTRE = FORMAT(D_CALENDARIO[Data],"Q"&"T") /* DIVIDE O ANO EM 4, MOSTRANDO CADA TRIMESTRE DE 1 A 4, E O & SERVE PARA JUNTAR COM O TEXTO "T".*/
TRIM/ANO = FORMAT(D_CALENDARIO[Data],"Q" & "T" & "-" & D_CALENDARIO[ANO]) /* EX: 1T-2017 */
DIA UTIL = IF(D_CALENDARIO[DIA SEMANA] = 7 || D_CALENDARIO[DIA SEMANA] = 1,"N", "S")

FEITO A TABELA E DEMAIS COLUNAS, RELACIONALAS AS DEMAIS TABELAS UTILIZANDO A COLUNA DATA COMO "CHAVE PRIMARIA"


EX DE FORMAT DATA:
"MMM" = MAR
"YYYY" = 2021
"MMM/YYYY" = MAR/2021
"MMMM/YYYY" = MARÇO/2021
"MM/YYYY" = 03/2021
"MM/YY" = 03/21

// CONTEXTO DE FILTRO E MEDIDAS //


MEDIDAS 
% REALIZADO = [TOTAL DE VENDAS]/[TOTAL DE META]

MEDIDAS COM CLAUSULA (TIPO WHERE DO SQL)
01 Total Vendas = SUMX(F_Vendas,F_Vendas[Qtde]*F_Vendas[Pr_Unit])
Total de Vendas Validas = CALCULATE(SUMX(F_Vendas,F_Vendas[Qtde]*F_Vendas[Pr_Unit]),F_Vendas[Situacao]="N") 
/* CALCULAR A QTD*VALOR UNITARIO APENAS DAS VENDAS EM SITUAÇÃO N
O FILTRO CALCULATE SERVE PARA DAR OPÇÃO DE CRIAR UM OU MAIS FILTROS */
02 Total de Vendas Validas = CALCULATE(SUMX(F_Vendas,F_Vendas[Qtde]*F_Vendas[Pr_Unit]),F_Vendas[Situacao]="N")
03 Total de vendas canceladas = CALCULATE(SUMX(F_Vendas,F_Vendas[Qtde]*F_Vendas[Pr_Unit]),F_Vendas[Situacao]="C")
04 Total Vendas Validas all = CALCULATE(SUMX(F_Vendas,F_Vendas[Qtde]*F_Vendas[Pr_Unit]),F_Vendas[Situacao]="N",ALL(F_Vendas))
/* o filtro ALL impede que sofra alterações em uma matriz ou quando clicam em graficos, o numero sempre ficara fixo.*/
05 % de Part = [02 Total de Vendas Validas]/[04 - Total Vendas Validas all]
06 Total de custo = CALCULATE(SUMX(F_Vendas,F_Vendas[Qtde]*F_Vendas[Pr_custo]),F_Vendas[Situacao]="N")
07 Lucro = [02 Total de Vendas Validas]-[06 Total de custo]
08 YOY = CALCULATE(SUMX(F_Vendas,F_Vendas[Qtde]*F_Vendas[Pr_Unit]),F_Vendas[Situacao]="N",SAMEPERIODLASTYEAR(D_CALENDARIO[Data]))
09 % YOY = IF([08 YOY]=BLANK(),BLANK(),DIVIDE([02 Total de Vendas Validas],[08 YOY],BLANK())-1)
GRAFICO COMPARANDO ANOS 
SAMEPERIODLASTYEAR() = MESMO PERIODO DO ANO PASSADO()
10 MOM = CALCULATE(SUMX(F_Vendas,QTD*F_Vendas[Pr_Unit]),F_Vendas[Situacao]="N",PREVIOUSMONTH(D_CALENDARIO[Data]))
/* -> CALCULAR QTD*PREÇO UNITARIO DA TABELA F_VENDAS, QUANDO A SITUAÇÃO FOR IGUAL A "N" E RETORNAR O MÊS ANTERIOR DA TABELA DATA 
EX: FEVEREIRO X JANEIRO, MARÇO X FEVEREIRO ASSIM POR DIANTE */
11 %  MOM = IF([10 MOM]=BLANK(),BLANK(),DIVIDE( [02 Total de Vendas Validas],[10 MOM],BLANK())-1) MOSTRAR A PORCENTAGEM
13 TOTAL META = SUM(F_METAS(VALOR_META))
15 KPI = 
    SWITCH(
        TRUE();
        [02 Total Vendas Válidas] > [14 Total Meta]; "Atingiu";
        [02 Total Vendas Válidas] < [14 Total Meta]; "Não Atingiu";
        "Empatou")

FUNÇÕES DE TRATAMENTO DE TEXTO 

CONCATENATE /* JUNTAR DUAS COLUNAS */
LEFT /* PEGAR A PARTE DA ESQUERDA DE UM TEXTO */
RIGHT /* PEGAR A PARTE DA DIREITA DE UM TEXTO */
MID /* PEGAR A PARTE DO MEIO DE UM TEXTO */
UPPER /* TRASFORMA EM LETRA MAIUSCULA */
LOWER /* TRASFORMA EM LETRA MINUSCULA */
LEN /* CONTA QUANTOS CARACTERES TEM EM UM TEXTO */
SEARCH /* RETORNA A POSIÇÃO EM QUE UM CARACTERE TEM EM UM TEXTO */
SUBSTITUTE /* TROCA UM PEDAÇO DO TEXTO POR OUTRA COISA */
TRIM /* TIRA ESPAÇOS EXTRAS */




Nome Completo = CONCATENATE(CONCATENATE(PESSOAS[PrimeiroNome]," "),PESSOAS[UltimoNome])
texto esquerda = LEFT(PESSOAS[Pais],3)
texto direita = RIGHT(PESSOAS[Pais],3)
pais maiusculo = UPPER(PESSOAS[Pais])
pais minusculo = LOWER(PESSOAS[Pais])
ABREV MAIUSCULO = LEFT(UPPER(PESSOAS[Pais]),3)
NUM CARACT NOME = LEN(PESSOAS[PrimeiroNome])
MEIO = MID(PESSOAS[Nome Completo],3,5)
SUBSTITUIR = SUBSTITUTE(PESSOAS[email],"@","#")
DOMINIO = MID(PESSOAS[email],(SEARCH("@",PESSOAS[email]))+1,LEN(PESSOAS[email])-SEARCH("@",PESSOAS[email]))
DELIMITADOR = SEARCH("@",PESSOAS[email])
DOMINIO 2 = MID(PESSOAS[email],PESSOAS[DELIMITADOR],50)
IDADE  = DATEDIFF(PESSOAS[Nascimento],TODAY(),YEAR)
IDADE 2 = YEAR(TODAY())-PESSOAS[Nascimento].[Ano]
TEXTO = ISTEXT(PESSOAS[PrimeiroNome])
É NUMERO = ISNUMBER(PESSOAS[DELIMITADOR])


Projeto de Business Intelligence (POWER BI)

1.	Necessidade
1.1	Qual a Necessidade do Cliente?
1.2	O que medir?
1.3	Identificar KPI’s
1.4	Identificar os Highlights 

2.	Fonte de Dados
2.1	Identificar Origem 
2.2	Tabelas OLTP

3.	ETL
3.1	Criar conexões (OLAP E OLTP)
3.2	Carga Staging (DIMENSÕES E FATOS)
3.3	Agendamento 

4.	Ferramenta de BI (Power BI)
4.1	Carga de Dados
4.2	Relacionamentos
4.3	Dimensão DATA
4.4	Criar Medidas
4.5	Criar o Dashboard

5.	Parametrizações
5.1	Criar funções (Ex. Diretor, Gerente e Vendedor)
5.2	Publicar
5.3	Configurar Segurança de Linha
5.4	Configurar Gateway

___________________________________________________________________________________________________

CRIANDO A CARGA STAGING C/ TALEND

CRIANDO TODOS OS JOBS DE CARGA STG (JOGANDO O OLTP PARA O OLAP)


SCD Slowly Changing Dimensions

O SCD é uma sigla que significa Slowly Changing Dimensions
(Dimensões que Mudam Lentamente, em português) e retrata 
as dimensões que sofrem atualizações em seus campos e os 
classifica pelo tipo de mudança existente em cada uma delas.

As alternativas mais comuns de SCD são o SCD 
Tipo 1, SCD Tipo 2, SCD Tipo 3 e o SCD Híbrido.

A Surrogate Key é uma chave artificial e auto incremental.

Caracteristicas Surrogate Key
➢tem as características de uma Primary Key.
➢é utilizada para referenciar a dimensão na fato
➢é auto incremental
➢é uma chave artificial
➢é criada no Data Warehouse
➢não pode se repetir

O SCD Tipo 1 é a alteração que não armazena histórico na 
dimensão, ou seja, não é feito o versionamento do registro 
modificado. 

O SCD Tipo 2 é a técnica mais utilizada para atualizações de 
dimensões. Nesse tipo de SCD é adicionado um novo 
registro com as mudanças, preservando sempre os dados 
anteriores. 

O SCD Tipo 3 permite manter as modificações 
no mesmo registro. Essa técnica funciona com a 
adição de uma nova coluna na tabela de 
dimensão

O SCD Híbrido (conhecido também como SCD 
Tipo 6), combina todas os SCD anteriores. Isso 
o torna bastante flexível para as atualizações 
das dimensões, porém com um grande custo de 
complexidade.


MEDIDAS = PROJETO BI

TOTAL FATURADO = SUMX(FATO_VENDA,FATO_VENDA[QTD]*FATO_VENDA[VAL_UNIT]) /* QUANTIDADE X VALOR UNITARIO */
TOTAL META = SUM(FATO_META[VALOR]) /* SOMA DE TODAS AS METAS INDIVIDUAIS */
% REALIZADO = DIVIDE([TOTAL FATURADO],[TOTAL META],0) /*PEGUEI O VALOR FATURADO, DIVIDI PELA META, RESULTADO ALTERNATIVO */
CUSTO = SUMX(FATO_VENDA,FATO_VENDA[QTD]*FATO_VENDA[VAL_CUSTO]) /* QUANTIDADE X VALOR DE CUSTO*/
MoM $ = CALCULATE(SUMX(FATO_VENDA,FATO_VENDA[QTD]*FATO_VENDA[VAL_UNIT]),PREVIOUSMONTH(D_CALENDAR[DATA_REF]))
YoY $ = CALCULATE(SUMX(FATO_VENDA,FATO_VENDA[QTD]*FATO_VENDA[VAL_UNIT]),SAMEPERIODLASTYEAR(D_CALENDAR[DATA_REF]))

KPIS: 
TOTAL FATURADO
TOTAL DE META
% REALIZADO 
% QUE FALTA 
CUSTO
FOLHA DE LUCRO?
% DE LUCRO
% MOM
% YOY


MEDIDAS AUXILIARES 

DASHBOARD PRINCIPAL: 
MES ATUAL
ANO ATUAL 


/* VENDEDORES MULTIPLOS 
Quando eu inseria qualquer Medida na tabela, apareciam vários vendedores,
 mesmo de empresas que nem trabalham. Testei várias e várias vezes. Refiz as tabelas.
 Recarreguei os jobs. Mas o erro estava no Power BI. No relacionamento entre
 DIM_VENDEDOR e DIM_CANAL_VENDAS pelo SK_VENDEDOR, tem dar clique duplo e colocar 
 CARDINALIDADE = Muitos para um e DIREÇÃO DO FILTRO CRUZADO = Ambas, aí funciona !!! /*

 571497.34 * SELECT SUM(QTD) FROM FATO_VENDA
