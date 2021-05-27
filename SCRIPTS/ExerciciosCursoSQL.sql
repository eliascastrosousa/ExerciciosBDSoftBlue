/* exercicios */

CREATE TABLE TIPO (
CODIGO int unsigned not null auto_increment,
TIPO varchar(45) not null,
primary key (CODIGO)
);
 insert into tipo ( tipo ) values ('Banco de Dados');
 insert into tipo ( tipo ) values ('Programação');
 insert into tipo ( tipo ) values ('Web');
 insert into tipo ( tipo ) values ('Contabil');

 +--------+----------------+
| CODIGO | TIPO           |
+--------+----------------+
|      1 | Banco de Dados |
|      2 | Programação    |
|      3 | Web            |
|      4 | Contabil       |
+--------+----------------+
+----------------------------------+
| CODIGO (PK) | TIPO               |
|-------------+--------------------|
|           1 | Banco de dados     |
|           2 | Programação        |
|           3 | Web                |
|           4 | Contabil           |
+----------------------------------+


CREATE TABLE INSTRUTOR (
	CODIGO int unsigned not null auto_increment,
	nome varchar(45) not null,
	telefone varchar(45),
	primary key (CODIGO)
);

insert into INSTRUTOR (nome, telefone ) values ('Gustavo Guanabara', 11911111111);
insert into INSTRUTOR (nome, telefone ) values ('Carlos Tosin', 11922222222);
insert into INSTRUTOR (nome, telefone ) values ('André Milani', 11933333333);
insert into INSTRUTOR (nome, telefone) values ('Felipe Augusto', 11944444444);

select * from INSTRUTOR;

+-------------+-------------------+-------------+----------------+
| CODIGO      | nome              | telefone    | area           |
+-------------+-------------------+-------------+----------------+
|           1 | Gustavo Guanabara | 11911111111 | programação    |
|           2 | Carlos Tosin      | 11922222222 | web            |
|           3 | André Milani      | 11933333333 | banco de dados |
|           4 | Felipe Augusto    | 11944444444 | contabil       |
+-------------+-------------------+-------------+----------------+

______________________________________________________________________________________________________________________________________________

CREATE TABLE ALUNOS (
	CODIGO int unsigned not null auto_increment,
	nome varchar(45) not null,
	endereco varchar(45),
	email varchar(45),
	primary key (CODIGO)
);

insert into ALUNOS (nome,  endereco, email) values ('Elias Castro','R. anunciato thomeu','eliascastrosousa@gmail.com' );
insert into ALUNOS (nome,  endereco, email) values ('Karina Luongo', 'R. Luiz Soares','Luongoska@gmail.com' );
insert into ALUNOS (nome,  endereco, email) values ('Gabriel Henrique','av. Beijamim Harris Hannicut','gabrielhenrique@gmail.com' );
insert into ALUNOS (nome,  endereco, email) values ('Guilherme Castro Sousa','R. anunciato thomeu','Guilhermecastro@gmail.com' );

select * from ALUNOS;

+---------+------------------------+----------------+------------------------------+----------------------------+
| idaluno | nome                   | cpf            | endereco                     | email                      |
+---------+------------------------+----------------+------------------------------+----------------------------+
|       1 | Elias Castro           | 111.111.111-11 | R. anunciato thomeu          | eliascastrosousa@gmail.com |
|       2 | Karina Luongo          | 222.222.222-22 | R. Luiz Soares               | Luongoska@gmail.com        |
|       3 | Gabriel Henrique       | 333.333.333-33 | av. Beijamim Harris Hannicut | gabrielhenrique@gmail.com  |
|       4 | Guilherme Castro Sousa | 444.444.444-44 | R. anunciato thomeu          | Guilhermecastro@gmail.com  |
+---------+------------------------+----------------+------------------------------+----------------------------+

______________________________________________________________________________________________________________________________________________


create table CURSO (
	CODIGO int unsigned not null auto_increment,
	curso varchar(45) not null,
	tipo int unsigned not null,
	ins int unsigned not null,
	preço float(10,2) not null,
	primary key (codigo),
	CONSTRAINT fk_tipo_codigo  FOREIGN KEY (tipo) REFERENCES tipo (CODIGO),
	CONSTRAINT fk_ins_codigo  FOREIGN KEY (ins) REFERENCES INSTRUTOR (CODIGO)
);

+----------------------------------+
| CODIGO (PK) | TIPO               |
|-------------+--------------------|
|           1 | Banco de dados     |
|           2 | Programação        |
|           3 | Web                |
|           4 | Contabil           |
+----------------------------------+

insert into CURSO (curso, tipo, preço, ins ) values ('mysql',1, 29, 3);
insert into CURSO (curso, tipo, preço, ins ) values ('python', 2, 39, 1);
insert into CURSO (curso, tipo, preço, ins ) values ('javascript',3,27, 2);
insert into CURSO (curso, tipo, preço, ins ) values ('sql server',1, 29, 3);
insert into CURSO (curso, tipo, preço, ins ) values ('contabilidade',4, 59, 4);

+---------+---------------+----------------+--------+-----+
| idcurso | curso         | tipo           | preço  | ins |
+---------+---------------+----------------+--------+-----+
|       1 | mysql         | banco de dados |  29.00 |   3 |
|       2 | python        | programação    |  39.00 |   1 |
|       3 | javascript    | web            |  27.00 |   2 |
|       4 | sql server    | banco de dados |  29.00 |   3 |
|       5 | contabilidade | contabil       |  59.00 |   4 |
+---------+---------------+----------------+--------+-----+
______________________________________________________________________________________________________________________________________________

CREATE TABLE PEDIDO (
	CODIGO int unsigned not null auto_increment,
	ALUNO int unsigned not null,
	DATA DATE,
	HORA TIME,
	primary key (CODIGO),
	CONSTRAINT FK_ALUNO_CODIGO FOREIGN KEY (ALUNO) REFERENCES ALUNOS (CODIGO)
);

insert INTO PEDIDO (ALUNO) values (1);

Tabela PEDIDO
+----------------------------------------------------+
| CODIGO (PK) | ALUNO (FK)   | DATA       | HORA     | 
|-------------+--------------+------------+----------|
|           1 |            2 | 15/04/2010 | 11:23:32 |
|           2 |            2 | 15/04/2010 | 14:36:21 |
|           3 |            3 | 16/04/2010 | 11:17:45 |
+----------------------------------------------------+




CREATE TABLE PEDIDO_DETALHE (
	PEDIDO int unsigned not null,
	CURSO  int unsigned not null,
	VALOR  float(10,2) not null,
	CONSTRAINT FK_PEDIDO_CODIGO FOREIGN KEY (PEDIDO) REFERENCES PEDIDO (CODIGO),
	CONSTRAINT FK_CURSO_CODIGO FOREIGN KEY (CURSO) REFERENCES CURSO (CODIGO)

);

 insert into PEDIDO_DETALHE (PEDIDO , CURSO , VALOR ) values (1, 2, 39);


+----------------------------------+
| PEDIDO (FK) | CURSO (FK) | VALOR |
|-------------+------------+-------+
|           1 |          1 |   270 |
|           1 |          2 |   330 |
|           2 |          1 |   270 |
|           2 |          2 |   330 |
|           2 |          3 |   170 |
|           3 |          4 |   270 |
+----------------------------------+

/*completar colocando os ids dos alunos*/
insert into MATRICULAS (idaluno, nome, idcurso, curso ) values (1, 'elias', 1, 'mysql');
insert into MATRICULAS (idaluno, nome, idcurso, curso ) values (2, 'Karina', 5, 'contabilidade');
insert into MATRICULAS (idaluno, nome, idcurso, curso ) values (1, 'elias', 2, 'python');

+-------------+---------+--------+---------+---------------+---------+---------------------+
| idmatricula | idaluno | nome   | idcurso | curso         | periodo | data_matricula      |
+-------------+---------+--------+---------+---------------+---------+---------------------+
|           1 |       1 | elias  |       1 | mysql         | NULL    | 2021-02-12 11:57:10 |
|           2 |       1 | elias  |       2 | python        | NULL    | 2021-02-12 11:59:32 |
|           3 |       2 | Karina |       5 | contabilidade | NULL    | 2021-02-12 11:59:33 |
|           4 |       1 | elias  |       2 | python        | NULL    | 2021-02-12 11:59:33 |
+-------------+---------+--------+---------+---------------+---------+---------------------+


/* Exercício 2 */
 
Altere as seguintes estruturas no banco de dados:


/*Inclua a coluna DATA_NASCIMENTO na tabela ALUNO do tipo string, de tamanho 10
caracteres;*/
ALTER TABLE ALUNO
ADD DATA_NASCIMENTO VARCHAR(10);

/*Altere a coluna DATA_NASCIMENTO para NASCIMENTO e seu tipo de dado para DATE;*/
ALTER TABLE ALUNOS
CHANGE DATA_NASC NASCIMENTO DATE;

/*Crie um novo índice na tabela ALUNO, para o campo ALUNO;*/
CREATE INDEX ALUNO ON ALUNOS (NOME);

/*Inclua o campo EMAIL na tabela INSTRUTOR, com tamanho de 100 caracteres;*/
ALTER TABLE INSTRUTOR
ADD EMAIL VARCHAR(100);

/*Crie um novo índice na tabela CURSO, para o campo INSTRUTOR;*/
CREATE INDEX CURSOS ON CURSO (CURSO);

/*Remova o campo EMAIL da tabela INSTRUTOR;*/
ALTER TABLE INSTRUTOR
DROP COLUMN EMAIL

Exercício 1

+--------+----------------+
| CODIGO | TIPO           |
+--------+----------------+
|      1 | Banco de Dados |
|      2 | Programação    |
|      3 | Web            |
|      4 | Contabil       |
+--------+----------------+

Tabela TIPO:
1, Banco de dados
2, Programação
5, Modelagem de dados

INSERT INTO TIPO (TIPO) VALUES ('MODELAGEM DE DADOS');

+--------+-------------------+-------------+
| CODIGO | nome              | telefone    |
+--------+-------------------+-------------+
|      1 | Gustavo Guanabara | 11911111111 |
|      2 | Carlos Tosin      | 11922222222 |
|      3 | André Milani      | 11933333333 |
|      4 | Felipe Augusto    | 11944444444 |
+--------+-------------------+-------------+

Tabela INSTRUTOR:
5, André Milani, 1111-1111
6, Carlos Tosin, 1212-1212

INSERT INTO INSTRUTOR (NOME, TELEFONE) VALUES ('André Milani', '1111-1111' );
INSERT INTO INSTRUTOR (NOME, TELEFONE) VALUES ('Carlos Tosin', '1212-1212' );

SELECT * FROM CURSO;

Tabela CURSO:
1, Java Fundamentos, 2, 6, 270
2, Java Avançado, 2, 6, 330
3, SQL Completo, 1, 5, 170
4, Php Básico, 2, 5, 270

INSERT INTO CURSO (CURSO, TIPO, INS, PREÇO) VALUES ('Java Fundamentos', 2, 6, 270);
INSERT INTO CURSO (CURSO, TIPO, INS, PREÇO) VALUES ('Java Avançado', 2, 6, 330);
INSERT INTO CURSO (CURSO, TIPO, INS, PREÇO) VALUES ('SQL Completo', 1, 5, 170);
INSERT INTO CURSO (CURSO, TIPO, INS, PREÇO) VALUES ('Php Básico', 2, 5, 270);

+--------+------------------+------+-----+--------+
| CODIGO | curso            | tipo | ins | preço  |
+--------+------------------+------+-----+--------+
|      1 | mysql            |    1 |   3 |  29.00 |
|      2 | python           |    2 |   1 |  39.00 |
|      3 | javascript       |    3 |   2 |  27.00 |
|      4 | sql server       |    1 |   3 |  29.00 |
|      5 | contabilidade    |    4 |   4 |  59.00 |
|      6 | Java Fundamentos |    2 |   6 | 270.00 |
|      7 | Java Avançado    |    2 |   6 | 330.00 |
|      8 | SQL Completo     |    1 |   5 | 170.00 |
|      9 | Php Básico       |    2 |   5 | 270.00 |
+--------+------------------+------+-----+--------+

Tabela ALUNO:
1, José, Rua XV de Novembro 72, jose@softblue.com.br
2, Wagner, Av. Paulista, wagner@softblue.com.br
3, Emílio, Rua Lajes 103, ap: 701, emilio@softblue.com.br
4, Cris, Rua Tauney 22, cris@softblue.com.br
5, Regina, Rua Salles 305, regina@softblue.com.br
6, Fernando, Av. Central 30, fernando@softblue.com.br

INSERT INTO ALUNOS (NOME, endereco, EMAIL) VALUES ('José', 'Rua XV de Novembro 72', 'jose@softblue.com.br');
INSERT INTO ALUNOS (NOME, endereco, EMAIL) VALUES ('Wagner', 'Av. Paulista', 'wagner@softblue.com.br');
INSERT INTO ALUNOS (NOME, endereco, EMAIL) VALUES ('Emílio', 'Rua Lajes 103, ap: 701', 'emilio@softblue.com.br');
INSERT INTO ALUNOS (NOME, endereco, EMAIL) VALUES ('Cris', 'Rua Tauney 22', 'cris@softblue.com.br');
INSERT INTO ALUNOS (NOME, endereco, EMAIL) VALUES ('Regina',' Rua Salles 305', 'regina@softblue.com.br');
INSERT INTO ALUNOS (NOME, endereco, EMAIL) VALUES ('Fernando','Av. Central 30', 'fernando@softblue.com.br');

SELECT * FROM ALUNOS;

+--------+------------------------+------------------------------+----------------------------+------------+
| CODIGO | nome                   | endereco                     | email                      | NASCIMENTO |
+--------+------------------------+------------------------------+----------------------------+------------+
|      1 | Elias Castro           | R. anunciato thomeu          | eliascastrosousa@gmail.com | NULL       |
|      2 | Karina Luongo          | R. Luiz Soares               | Luongoska@gmail.com        | NULL       |
|      3 | Gabriel Henrique       | av. Beijamim Harris Hannicut | gabrielhenrique@gmail.com  | NULL       |
|      4 | Guilherme Castro Sousa | R. anunciato thomeu          | Guilhermecastro@gmail.com  | NULL       |
|      5 | José                   | Rua XV de Novembro 72        | jose@softblue.com.br       | NULL       |
|      6 | Wagner                 | Av. Paulista                 | wagner@softblue.com.br     | NULL       |
|      7 | Emílio                 | Rua Lajes 103, ap: 701       | emilio@softblue.com.br     | NULL       |
|      8 | Cris                   | Rua Tauney 22                | cris@softblue.com.br       | NULL       |
|      9 | Regina                 |  Rua Salles 305              | regina@softblue.com.br     | NULL       |
|     10 | Fernando               | Av. Central 30               | fernando@softblue.com.br   | NULL       |
+--------+------------------------+------------------------------+----------------------------+------------+

INSERT INTO PEDIDO ( ALUNO , DATA , HORA) VALUES (6, '15/04/2010', '11:23:32');

INSERT INTO PEDIDO ( ALUNO , DATA , HORA) VALUES (6, '15/04/2010', '14:36:21');

INSERT INTO PEDIDO ( ALUNO , DATA , HORA) VALUES (7, '16/04/2010', '11:17:45');

INSERT INTO PEDIDO ( ALUNO , DATA , HORA) VALUES (8, '17/04/2010', '14:27:22');

INSERT INTO PEDIDO ( ALUNO , DATA , HORA) VALUES (9, '18/04/2010', '11:18:19');

INSERT INTO PEDIDO ( ALUNO , DATA , HORA) VALUES (10, '19/04/2010', '13:47:35');

INSERT INTO PEDIDO ( ALUNO , DATA , HORA) VALUES (10, '20/04/2010', '18:13:44');

+--------+-------+------------+----------+
| CODIGO | ALUNO | DATA       | HORA     |
+--------+-------+------------+----------+
|      1 |     1 | NULL       | NULL     |
|      2 |     6 | 15/04/2010 | 11:23:32 |
|      3 |     6 | 15/04/2010 | 14:36:21 |
|      4 |     7 | 16/04/2010 | 11:17:45 |
|      5 |     8 | 17/04/2010 | 14:27:22 |
|      6 |     9 | 18/04/2010 | 11:18:19 |
|      7 |    10 | 19/04/2010 | 13:47:35 |
|      8 |    10 | 20/04/2010 | 18:13:44 |
+--------+-------+------------+----------+

ALTER TABLE PEDIDO
MODIFY HORA VARCHAR(12);


+--------+-------+-------+
| PEDIDO | CURSO | VALOR |
+--------+-------+-------+
|      1 |     2 | 39.00 |
+--------+-------+-------+


INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(1, 1, 270);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(1, 2, 330);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(2, 1, 270);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(2, 2, 330);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(2, 3, 170);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(3, 4, 270);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(4, 2, 330);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(4, 4, 270);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(5, 3, 170);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(6, 3, 170);

INSERT INTO PEDIDO_DETALHE(PEDIDO, CURSO, VALOR) VALUES(7, 4, 270);

SELECT * FROM PEDIDO_DETALHE;

Exercício 2
Utilizando o banco de dados criado nos módulos anteriores, realize as seguintes instruções:

Exibir todas as informações de todos os alunos;
SELECT * FROM ALUNOS;

Exibir somente o título de cada curso da Softblue;
SELECT CURSO FROM CURSO;

Exibir somente o título e valor de cada curso da Softblue cujo preço seja maior que 200;
SELECT CURSO, PREÇO FROM CURSO WHERE PREÇO >200;

Exibir somente o título e valor de cada curso da Softblue cujo preço seja maior que 200 e menor que 300;
SELECT CURSO, PREÇO FROM CURSO WHERE PREÇO BETWEEN 200 AND 300; 

Outra solução para o exercício seria esta;


Exibir as informações da tabela PEDIDOS para os pedidos realizados entre 15/04/2010 e 18/04/2010;
SELECT * FROM PEDIDO WHERE DATA BETWEEN '15/04/2010' AND '18/04/2010';

Outra solução para o exercício seria esta;


Exibir as informações da tabela PEDIDOS para os pedidos realizados na data de 15/04/2010;
SELECT * FROM PEDIDO WHERE DATA = '15/04/2010';

Utilizando o banco de dados criado nos módulos anteriores, realize as seguintes instruções:
Altere o endereço do aluno JOSÉ para 'Av. Brasil 778';
update alunos set endereco = 'Av. Brasil, 778' where codigo = 5 ;

Altere o e-mail do aluno CRIS para 'cristiano@softblue.com.br';
update alunos set email = 'cristiano@softblue.com.br' where codigo = 8;

Aumente em 10% o valor dos cursos abaixo de 300;
SET SQL_SAFE_UPDATES = 0;
update curso set preço = preço*1.1 where preço <300;


Altere o nome do curso de Php Básico para Php Fundamentos;
update curso set curso = 'Php fundamentos' where codigo = 9;

Utilizando o banco de dados criado nos módulos anteriores, realize as seguintes uniões de tabelas:

Exiba uma lista com os títulos dos cursos da Softblue e o tipo de curso ao lado;
select c.codigo, c.curso, t.tipo from curso c 
inner join tipo t
 on  c.tipo = t.codigo;

Exiba uma lista com os títulos dos cursos da Softblue, tipo do curso, nome do instrutor responsável pelo
mesmo e telefone;
select c.curso, t.tipo, i.nome, i.telefone from curso C
inner join tipo t 
on  c.tipo = t.codigo
inner join instrutor i
on c.ins = i.codigo; 

Exiba uma lista com o código e data e hora dos pedidos e os códigos dos cursos de cada pedido;
select  p.codigo, p.data, p.hora, pd.curso from pedido p
inner join pedido_detalhe pd 
on p.codigo = pd.pedido;

Exiba uma lista com o código e data e hora dos pedidos e os títulos dos cursos de cada pedido;
select  p.codigo, p.data, p.hora, pd.curso, c.curso from pedido p
inner join pedido_detalhe pd 
on p.codigo = pd.pedido
inner join curso c
on c.codigo = pd.curso;

Exiba uma lista com o código e data e hora dos pedidos, nome do aluno e os títulos dos cursos de cada
pedido;
select  p.codigo, p.data, p.hora, pd.curso, c.curso, a.nome from pedido p
inner join pedido_detalhe pd 
on p.codigo = pd.pedido
inner join curso c
on c.codigo = pd.curso
inner join alunos a
on a.codigo = p.aluno;


Utilizando o banco de dados criado nos módulos anteriores, realize as seguintes instruções:
Crie uma visão que traga o título e preço somente dos cursos de programação da Softblue;
create view view1 as 
select curso, preço from curso
where tipo = 2 ;

select * from view1;

Crie uma visão que traga os títulos dos cursos, tipo do curso e nome do instrutor;
create view view2 as 
	select c.curso, t.tipo, i.nome from curso c
	inner join tipo t
	on c.tipo = t.codigo
	inner join instrutor i
	on i.codigo = c.ins;

	 select * from view2;

Crie uma visão que exiba os pedidos realizados, informando o nome do aluno, data e código do pedido;

create view view3 as
	select a.nome, p.data, p.codigo from alunos a
	inner join pedido p
	on a.codigo = p.aluno;

Selecione os nomes de todos os alunos que já fizeram alguma matrícula na Softblue, sem repetição;
select distinct(nome) from alunos;

Exiba o nome do aluno mais antigo da Softblue;
select nome from alunos 
order by codigo(desc)
limit 1;

Exiba o nome do aluno mais recente da Softblue;
select nome from alunos 
order by codigo desc
limit 1;

Exiba o nome do terceiro aluno mais antigo da Softblue;
select nome from alunos 
ORDER BY codigo
limit 1 
offset 2;

Exiba a quantidade de cursos que já foram vendidos pela Softblue;
SELECT COUNT(*) FROM PEDIDO_DETALHE;

Exiba o valor total já arrecadado pelos cursos vendidos pela Softblue;
SELECT sum(VALOR) FROM PEDIDO_DETALHE;

Exiba o valor médio cobrado por curso para o pedido cujo CODIGO é 2;
SELECT AVG(VALOR) FROM PEDIDO_DETALHE WHERE PEDIDO = 2 ;


Exiba o valor do curso mais caro da Softblue;
SELECT  MAX(PREÇO) FROM CURSO;

Exiba o valor do curso mais barato da Softblue;
SELECT  MIN(PREÇO) FROM CURSO;

Exiba o valor total de cada pedido realizado na Softblue;
select distinct sum(valor) from pedido_detalhe;


Exiba os nomes dos instrutores da Softblue e a quantidade de cursos que cada um tem sob sua
responsabilidade;
(select i.nome, c.curso from instrutor i
inner join curso c
on i.codigo = c.ins)

Exiba o número do pedido, nome do aluno e valor para todos os pedidos realizados na Softblue cujo valor
total sejam maiores que 500;


Exiba o número do pedido, nome do aluno e quantos cursos foram comprados no pedido para todos os
pedidos realizados na Softblue que compraram dois ou mais cursos;


Exiba o nome e endereço de todos os alunos que morem em Avenidas (Av.);


Exiba os nomes dos cursos de Java da Softblue;

select nome from funcionarios where departamento
 in (select departamento from funcionarios group by departamento having avg(salario) > 1500);