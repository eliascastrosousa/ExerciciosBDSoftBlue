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

______________________________________________________________________________________________________________________________________________


