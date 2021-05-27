#Exercicio de fixação STORED PROCEDURE E TRIGGER

''' o stored procedure serve para vc criar um procedimento que ira executar sempre que vc chamar 
 por ele. pode ser uma um select, um update, qualquer manipulação de dados. '''
 # Ex: criar um delete de linhas esppecificas e quando vc chamar o procedure ele ira executar esse delete.

 # Vamos criar uma tabela de produtos e sempre que vc quiser limpar dados, irá chamar o procedure e ele ira fazer essa limpeza.

use treino

create table pedidos 
(
id int unsigned not null auto_increment,
descricao varchar(100) not null,
valor double not null default '0',
pago varchar(3) not null default 'não',
data_pedido date,
primary key (id)
)
; 


insert into pedidos (descricao, valor, data_pedido) values ('Batedeira', 500,  '2021-02-20');
insert into pedidos (descricao, valor, data_pedido) values ('Geladeira', 2000, '2021-02-21');
insert into pedidos (descricao, valor, data_pedido) values ('DVD Player', 300, '2021-02-16');
INSERT INTO pedidos (descricao, valor, data_pedido) VALUES ('Fogão', 1300,'2021-02-15');

# depois de criado a tabela e feito inserções. vamos criar a procedure e chamar ela
# a procedure irá eliminar registros de pedidos que nao foram pagos e ja estão há mais de 7 dias na tabela.

DELIMITER $$
USE `treino`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `limpa_pedidos`()
BEGIN
DELETE FROM PEDIDOS WHERE pago='nao' and data_pedido <'2021-02-18'; 
END$$

DELIMITER ;
;

#vamos dar um select para verificar como está a tabela: 

select * from pedidos;

+----+------------+-------+------+-------------+
| id | descricao  | valor | pago | data_pedido |
+----+------------+-------+------+-------------+
|  1 | Batedeira  |   500 | não  | 2021-02-20  |
|  2 | Geladeira  |  2000 | não  | 2021-02-21  |
|  7 | DVD Player |   300 | não  | 2021-02-16  |
|  8 | Fogão      |  1300 | não  | 2021-02-15  |
+----+------------+-------+------+-------------+

# criado o procedure, chamado de 'limpa_pedidos' vamos chamar ele e ele irá limpar os pedidos com mais de 7 dias e nao pagos. no exemplo, 
# ele irá então excluir os pedidos do 'DVD Player' e 'Fogão'. 

call limpa_pedidos;

MSG QUE APARECEU -> Query OK, 2 rows affected (0.14 sec)

# vamos dar mais um select e agora analisar o que aconteceu: 

select * from pedidos;

+----+-----------+-------+------+-------------+
| id | descricao | valor | pago | data_pedido |
+----+-----------+-------+------+-------------+
|  1 | Batedeira |   500 | não  | 2021-02-20  |
|  2 | Geladeira |  2000 | não  | 2021-02-21  |
+----+-----------+-------+------+-------------+

# como dito, os registros de dvd player e fogão foram eliminados por ja terem mais de 7 dias e nao terem sido pagos.

'''TRABALHANDO COM TRIGGER'''
''' a trigger é um gatilho que vc cria para que quando uma tabela determinada seja manipulada, seja feito um gatilho de um comando determinado 
 e assim seja feita uma operação automatica, como o procedure que criamos. '''

#vamos agora criar uma tabela de estoque para podermos trabalhar com uma trigger.

create table estoque 
	(
	id int unsigned not null auto_increment,
	descricao varchar(50) not null,
	quantidade int not null,
	primary key (id)
	);

# criado a tabela estoque, vamos criar um trigger para a seguinte situação:
# sempre que alguem inserir dados na tabela estoque, inserindo um novo produto e sua quantidade, automaticamente o banco de dados
# irá disparar o comando para a procedure de limpa_pedidos seja disparada, assim, limpando os dados antigos e que nao foram ppagos.
# eliminando a necessidade do dba de fazer manualmente.

# criando a trigger:

create trigger gatilho_limpa_pedidos
	before insert 
	on estoque 
	for each row 
	call limpa_pedidos();

# depois de feito, assim que vc inserir um dado na tabela estoque, o procedimento de limpar pedidos será feito automaticamente na tabela
# pedidos.

select * from pedidos;

+----+------------+-------+------+-------------+
| id | descricao  | valor | pago | data_pedido |
+----+------------+-------+------+-------------+
|  1 | Batedeira  |   500 | não  | 2021-02-20  |
|  2 | Geladeira  |  2000 | não  | 2021-02-21  |
|  7 | DVD Player |   300 | não  | 2021-02-16  |
|  8 | Fogão      |  1300 | não  | 2021-02-15  |
+----+------------+-------+------+-------------+

insert into estoque (descricao, quantidade) values ('liquidificador', 10);

# chamamos de novo o select da tabela pedidos: 

+----+-----------+-------+------+-------------+
| id | descricao | valor | pago | data_pedido |
+----+-----------+-------+------+-------------+
|  1 | Batedeira |   500 | não  | 2021-02-20  |
|  2 | Geladeira |  2000 | não  | 2021-02-21  |
+----+-----------+-------+------+-------------+

# os 2 registros que estavam dentro da clausula where, foram eliminados.

insert into estoque (descricao, quantidade) values ('liquidificador', 10);

select * from estoque;
+----+----------------+------------+
| id | descricao      | quantidade |
+----+----------------+------------+
|  1 | liquidificador |         10 |
+----+----------------+------------+

delimiter $

create procedure top10()
	BEGIN
	select * from vendas_supermercado
	order by rating desc
	limit 10;
	END
	$


#QUEM VENDEU MAIS EM MARCO #
SELECT NOME, MARCO FROM VENDEDORES 
ORDER BY MARCO DESC
LIMIT 1;

	NOME	MARCO
	ANDERSON	578665.88
    
	# UTILIZANDO SUBQUERIES #
	SELECT NOME, MAX(MARCO) FROM VENDEDORES WHERE (SELECT MAX(MARCO) FROM VENDEDORES);




# QUEM VENDEU MENOS EM MARCO#
SELECT NOME, MARCO FROM VENDEDORES 
ORDER BY MARCO ASC
LIMIT 1;

	NOME	MARCO
	MARIA	4467.90

	# UTILIZANDO SUBQUERIES #
SELECT NOME, MIN(MARCO) FROM VENDEDORES
WHERE MARCO = (SELECT MIN(MARCO) FROM VENDEDORES);

    

SELECT * FROM VENDEDORES;


# QUEM VENDEU MAIS QUE A MEDIA EM FEVEREIRO #
SELECT NOME, FEVEREIRO FROM VENDEDORES 
WHERE FEVEREIRO > (SELECT AVG(FEVEREIRO) FROM VENDEDORES);

4	CLARA	F	5779.78	446886.88	8965.90

