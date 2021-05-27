/* CURSO SQL SOFTBLUE */ 

CREATE DATABASE curso_sql;

USE curso_sql;

CREATE TABLE funcionarios 
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    salario double not null default '0',
    departamento varchar(45) not null,
    PRIMARY KEY (id)
);

create table CURSOS (
	id int unsigned not null auto_increment,
	ins int not null,
	titulo varchar(45) not null,
	PRIMARY KEY (id),
	CONSTRAINT fk_instrutores_cursos FOREIGN KEY (instrutores_id) REFERENCES cursos (ins)
);

CREATE TABLE veiculos
(
	id int unsigned not null auto_increment,
    funcionario_id int unsigned default null,
    veiculo varchar(45) not null default '',
    placa varchar(10) not null default '',
    PRIMARY KEY (id),
    CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY (funcionario_id) REFERENCES funcionarios (id)
);

CREATE TABLE salarios
(
	faixa varchar(45) not null,
    inicio double not null,
    fim double not null,
    PRIMARY KEY (faixa)
);

ALTER TABLE funcionarios CHANGE COLUMN nome nome_func varchar(45) not null;
ALTER TABLE funcionarios CHANGE COLUMN nome_func nome varchar(45) not null;

DROP TABLE salarios;

CREATE INDEX departamentos ON funcionarios (departamento);
CREATE INDEX nomes ON funcionarios (nome(6));

/* MANIPULANDO DADOS */

USE curso_sql;

INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (1, 'Fernando', 1400, 'TI');
INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (2, 'Guilherme', 2500, 'Jurídico');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Fábio', 1700, 'TI');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('José', 1800, 'Marketing');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Isabela', 2200, 'Jurídico');

SELECT * FROM funcionarios;
SELECT * FROM funcionarios WHERE salario > 2000;
SELECT * FROM funcionarios WHERE nome = 'José';
SELECT * FROM funcionarios WHERE id = 3;

UPDATE funcionarios SET salario = salario * 1.1 WHERE id = 1;

SET SQL_SAFE_UPDATES = 0;
/* SET SQL_SAFE_UPDATES = 1; */
UPDATE funcionarios SET salario = salario * 1.1;

UPDATE funcionarios SET salario = ROUND(salario * 1.0, 2);
UPDATE veiculos set funcionario_id = 5 where id = 2;
DELETE FROM funcionarios WHERE id = 4;

INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Carro', 'SB-0001');
INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Carro', 'SB-0002');

UPDATE veiculos SET funcionario_id = 5 WHERE id = 2;

SELECT * FROM veiculos;

INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Jr', 1000, 2000);
INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Pleno', 2000, 4000);

SELECT * FROM salarios;

SELECT nome AS 'Funcionário', salario FROM funcionarios f WHERE f.salario > 2000;

SELECT * FROM funcionarios WHERE nome = 'Guilherme'
UNION
SELECT * FROM funcionarios WHERE id = 5;

SELECT * FROM funcionarios WHERE nome = 'Guilherme'
UNION ALL
SELECT * FROM funcionarios WHERE nome = 'Guilherme';

/* RELACIONAMENTOS E VISÕES */

USE curso_sql;

SELECT * FROM funcionarios;
SELECT * FROM veiculos;

SELECT * FROM funcionarios INNER JOIN veiculos ON veiculos.funcionario_id = funcionarios.id;

SELECT * FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id = f.id;
SELECT * FROM funcionarios f LEFT JOIN veiculos v ON v.funcionario_id = f.id;
SELECT * FROM funcionarios f RIGHT JOIN veiculos v ON v.funcionario_id = f.id;

SELECT * FROM funcionarios f LEFT JOIN veiculos v ON v.funcionario_id = f.id
UNION
SELECT * FROM funcionarios f RIGHT JOIN veiculos v ON v.funcionario_id = f.id;

INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (null, "Moto", "SB-0003");

CREATE TABLE cpfs
(
	id int unsigned not null,
    cpf varchar(14) not null,
    PRIMARY KEY (id),
    CONSTRAINT fk_cpf FOREIGN KEY (id) REFERENCES funcionarios (id)
);

INSERT INTO cpfs (id, cpf) VALUES (1, '111.111.111-11');
INSERT INTO cpfs (id, cpf) VALUES (2, '222.222.222-22');
INSERT INTO cpfs (id, cpf) VALUES (3, '333.333.333-33');
INSERT INTO cpfs (id, cpf) VALUES (5, '555.555.555-55');

SELECT * FROM cpfs;

SELECT * FROM funcionarios INNER JOIN cpfs ON funcionarios.id = cpfs.id;
SELECT * FROM funcionarios INNER JOIN cpfs USING(id);

CREATE TABLE clientes
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    quem_indicou int unsigned,
    PRIMARY KEY (id),
    CONSTRAINT fk_quem_indicou FOREIGN KEY (quem_indicou) REFERENCES clientes (id)
);

INSERT INTO clientes (id, nome, quem_indicou) VALUES (1, 'André', NULL);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (2, 'Samuel', 1);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (3, 'Carlos', 2);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (4, 'Rafael', 1);

SELECT * FROM clientes;

SELECT a.nome AS CLIENTE, b.nome AS "QUEM INDICOU" 
FROM clientes a join clientes b ON a.quem_indicou = b.id;

SELECT * FROM funcionarios 
INNER JOIN veiculos ON veiculos.funcionario_id = funcionarios.id 
INNER JOIN cpfs ON cpfs.id = funcionarios.id;

CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario >= 1700;

SELECT * FROM funcionarios_a;
UPDATE funcionarios SET salario = 1500 WHERE id = 3;

DROP VIEW funcionarios_a;
CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario >= 2000;

create table instrutores (
	id int not null auto_increment,
	nome varchar(45) not null,
	PRIMARY KEY (id)
);


create table livraria (
id_cliente int not null auto_increment,
nome varchar(50) not null,
telefone int(11) not null,
PRIMARY KEY (id_cliente)
);

insert into livraria (nome, telefone) VALUES ('Elias Castro', 984531122 );
insert into livraria (nome, telefone) VALUES ('Bruna Vieira', 977332634 );
insert into livraria (nome, telefone) VALUES ('Joanes Bestla', 984757575);

create table livros (
	id_livro int not null auto_increment,
	nome varchar(50) not null,
	id_clientef int not null,
	PRIMARY KEY (id_livro),
	CONSTRAINT fk_livros_livraria FOREIGN KEY (id_clientef) REFERENCES livraria (id_cliente)
);

insert into livros (nome, id_clientef) VALUES ('Python Mundo 1', 1 );
insert into livros (nome, id_clientef) VALUES ('Dominando Java', 2 );
insert into livros (nome, id_clientef) VALUES ('Jojo Rabbit', 3 );

select * from livraria inner join livros;

select l.id_cliente, l.nome, l.telefone, ll.id_livro, ll.nome as nome_do_livro
from livraria l
inner join livros ll
where l.id_cliente = ll.id_clientef ;

select f.id, f.nome, f.departamento, v.veiculo, v.placa from funcionarios f 
inner join
veiculos v
on v.funcionario_id = f.id
WHERE f.id=3;

select f.nome, f.departamento, c.cpf, v.veiculo, v.placa from funcionarios f
inner join
veiculos v on v.funcionario_id = f.id
inner join
cpfs c on v.funcionario_id = c.id;




select * from funcionarios f left join veiculos v on v.funcionario_id = f.id
union
select * from funcionarios f right join veiculos v on v.funcionario_id = f.id;

 alter table veiculos change column placa placa varchar(15) not null;


create VIEW jogador_caro as
select f.nome, c.cpf, f.departamento, f.salario from funcionarios f
inner join
cpfs c on c.id = f.id
where f.salario >2000;

create view pessoas_ti as
	select * from funcionarios where departamento = 'ti';

select * from pessoas_ti;

/* Funções especiais e Subqueries */

USE curso_sql;

SELECT * FROM funcionarios;

SELECT COUNT(*) FROM funcionarios;
SELECT COUNT(*) FROM funcionarios WHERE salario > 1600;
SELECT COUNT(*) FROM funcionarios WHERE salario > 1600 AND departamento = 'Jurídico';

SELECT * FROM funcionarios WHERE salario > 1600 AND departamento = 'Jurídico';

SELECT SUM(salario) FROM funcionarios;
SELECT SUM(salario) FROM funcionarios WHERE departamento = 'TI';

SELECT AVG(salario) FROM funcionarios;
SELECT AVG(salario) FROM funcionarios WHERE departamento = 'TI';

SELECT MAX(salario) FROM funcionarios;
SELECT MAX(salario) FROM funcionarios WHERE departamento = 'TI';

SELECT MIN(salario) FROM funcionarios;
SELECT MIN(salario) FROM funcionarios WHERE departamento = 'TI';

SELECT departamento FROM funcionarios;
SELECT DISTINCT(departamento) FROM funcionarios;
SELECT DISTINCT(nome) FROM funcionarios;

SELECT * FROM funcionarios;
SELECT * FROM funcionarios ORDER BY nome;
SELECT * FROM funcionarios ORDER BY nome DESC;

SELECT * FROM funcionarios ORDER BY salario;
SELECT * FROM funcionarios ORDER BY departamento;
SELECT * FROM funcionarios ORDER BY departamento DESC, salario DESC;

SELECT * FROM funcionarios;
SELECT * FROM funcionarios LIMIT 2 OFFSET 1;
SELECT * FROM funcionarios LIMIT 1, 2;

SELECT AVG(salario) FROM funcionarios;
SELECT AVG(salario) FROM funcionarios WHERE departamento = 'TI';
SELECT AVG(salario) FROM funcionarios WHERE departamento = 'Jurídico';

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento;
SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 2000;

SELECT departamento, COUNT(*) FROM funcionarios GROUP BY departamento;

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento;
SELECT nome FROM funcionarios WHERE departamento = 'Jurídico';

SELECT nome FROM funcionarios 
WHERE departamento IN 
	(
		SELECT departamento FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 2000
    );

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 2000;



create table cursos (
id int unsigned not null auto_increment,
ins int unsigned,
titulo varchar(45) not null,
PRIMARY KEY (id),
CONSTRAINT ins_id FOREIGN KEY (ins) REFERENCES instrutores (id)

);

insert into cursos (ins,titulo) VALUES (1,'java');
insert into cursos (titulo) VALUES ('php');
insert into cursos (ins,titulo) VALUES (1,'mysql');
insert into cursos (ins,titulo) VALUES (3,'sql');
insert into cursos (ins,titulo) VALUES (2,'c++');


select* from instrutores;


create table pilotos (
id int unsigned not null auto_increment,
nome varchar(45) not null,
equipe varchar(5) not null,
pontos varchar(5) not null,
PRIMARY KEY (id)
 );

insert into pilotos (nome, equipe, pontos) VALUES('Fernando','A',2);
insert into pilotos (nome, equipe, pontos) VALUES('Paulo','B',5);
insert into pilotos (nome, equipe, pontos) VALUES('Richa','A',3);
insert into pilotos (nome, equipe, pontos) VALUES('Gomes','C',6);
insert into pilotos (nome, equipe, pontos) VALUES('Fred','B',7);


SELECT * FROM PILOTOS WHERE EQUIPE IN
  (SELECT EQUIPE FROM PILOTOS GROUP BY EQUIPE HAVING SUM(PONTOS) > 5);



CREATE TABLE ACESSORIOS (
  ID int unsigned NOT NULL,
  VALOR double NOT NULL default '0',
  FORNECEDOR varchar(45) NOT NULL,
  PRIMARY KEY (ID)
);


1
CREATE TABLE EMBLEMAS (
  ID int NOT NULL,
  FORNECEDOR varchar(45) NULL,
  EMBLEMA varchar(10) NOT NULL,
  VALOR double NOT NULL default NULL,
  PRIMARY KEY (ID)
);



CREATE TABLE EMBLEMAS (
  ID int NOT NULL,
  FORNECEDOR varchar(45) NULL,
  EMBLEMA varchar(10) NOT NULL,
  VALOR double NOT NULL default '0',
  PRIMARY KEY (ID)
);




/* CREATE USER 'andre'@'200.200.190.190' IDENTIFIED BY 'milani123456'; */
/* CREATE USER 'andre'@'%' IDENTIFIED BY 'milani123456'; */

CREATE USER 'andre'@'localhost' IDENTIFIED BY 'milani123456';
GRANT ALL ON curso_sql.* TO 'andre'@'localhost';

CREATE USER 'andre'@'%' IDENTIFIED BY 'andreviagem';
GRANT SELECT ON curso_sql.* TO 'andre'@'%';
/* GRANT INSERT ON curso_sql.* TO 'andre'@'%'; */
GRANT INSERT ON curso_sql.funcionarios TO 'andre'@'%';

REVOKE INSERT ON curso_sql.funcionarios FROM 'andre'@'%';
REVOKE SELECT ON curso_sql.* FROM 'andre'@'%';

GRANT SELECT ON curso_sql.funcionarios TO 'andre'@'%';
GRANT SELECT ON curso_sql.veiculos TO 'andre'@'%';

REVOKE SELECT ON curso_sql.funcionarios FROM 'andre'@'%';
REVOKE SELECT ON curso_sql.veiculos FROM 'andre'@'%';

REVOKE ALL ON curso_sql.* FROM 'andre'@'localhost';

DROP USER 'andre'@'%';
DROP USER 'andre'@'localhost';

SELECT User FROM mysql.user;
SHOW GRANTS FOR 'andre'@'%';












