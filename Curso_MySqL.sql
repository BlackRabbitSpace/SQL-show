-- Esta documentaçao acompanha o tutotial disponível no Youtubel no canal do 
-- Programin with Mosh 
-- A tradução e comentários fora feitos em Português
-- Link do video : https://www.youtube.com/watch?v=7S_tz1z_5bA&t=917s

-- Utilizar o banco de daos ao qual você deseja, também funciona um double-click 
-- sobre o banco desejado
use sql_store;

use sql_store;

-- Aqui estão várias formas de selecionar as colunas dentro das tabelas desejadas
select  * from customers where customer_id = 1 order by first_name;

select last_name, first_name, points, (points + 10) * 100 as 'com desconto' 
from customers;

select * from sql_store.customers;

SELECT name, unit_price, (unit_price * 1.1) as 'Novo Preço' from products;

-- Adiocnando a condicional WHERE para filtrar quais dados desejam selecionar

select * from Customers WHERE birth_date > '1990-01-01' OR points > 1000 and 
state = 'VA' ; 

 select * from Customers WHERE NOT (birth_date > '1990-01-01' OR points > 1000 and 
state = 'VA') ; 


 select * from Customers WHERE NOT (birth_date > '1990-01-01' OR points > 1000 ) ; 

 
 
 SELECT * FROM order_items where order_id = 6 and (unit_price * quantity) > 30 ;
 
 SELECT * from Customers WHERE state NOT IN ('VA', 'FL', 'GA');
 
 select * from products where quantity_in_stock in (49, 38, 72);
 # usar o between para substituir 
 SELECT * FROM customers WHERE points >= 1000 AND points <= 3000 ;
 SELECT * FROM customers WHERE points between 1000 AND 3000; 
 
 SELECT * FROM customers WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';
 #USAR O LIKE PARA MANIPULAR STRINGS % PARA CONTINUIDADE ANTES 
 -- OU DEPOIS DA STRING _  _ _ para quantos digitos 
 
 SELECT * FROM customers WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
 
SELECT * FROM customers WHERE phone LIKE '%9';
 --  REGEXP PARA LOCALIZAR STRINGS funcionando como um operador OR 
 -- usar ^ para começar com a string, $ para terminar, | operador OR, 
 -- [] multiplos valores . [-]  range de letras
  SELECT * FROM customers WHERE LAST_NAME REGEXP 'B[a-z]';

 SELECT * FROM customers WHERE last_name REGEXP 'field|mac|rose';

 -- se usarmos no REGEXP '^field|mac|rose' ou '^field$|mac|rose' 
 -- isso fará que alguma dessa palavras apareça no começo ou field 
 -- também apareça no final

 SELECT * FROM customers WHERE first_name REGEXP 'elka|ambur';
 
 SELECT * FROM customers WHERE last_name REGEXP 'EY$|ON$';
 
 SELECT * FROM customers WHERE LAST_NAME REGEXP 'B[R|U]';
 
 -- SELECIONAR DADOS COM VALOR NULL
 -- uma maneira de achar os itens 
 SELECT * FROM order_statuses WHERE name IS NOT NULL;
-- outra maneira 
SELECT * FROM orders WHERE shipped_date IS NULL;

-- OPERADORES DE ORDER BY 
SELECT * FROM customers ORDER BY first_name;
-- PODEMOS ORDENAR POR MULTIPLAS COLUNAS. NÃO IRÁ ALTERAR AS ORDENS DAS COLUNAS EXIBIDAS,
--  MAS SIM AS LINHAS 
-- DESC INVERTE A ORDEM 
SELECT * FROM customers ORDER BY state, last_name ;

--  selecionar paenas os itens = 2 e ordenar pelo Descendente dos intens
select *, (unit_price * quantity)  as 'valor_total' from order_items where order_id = 2 
order by product_id , unit_price desc; 
-- pode ordenar a coluna com o 'valor_total' já criado no order by 
select *, (unit_price * quantity)  as 'valor_total' from order_items where order_id = 2 
order by valor_total desc; 

-- LIMITE para quantos valores irão aparecer 
select * from customers limit 4; 
-- limite poderá ser pulado passando 1° valor , 2° valor quantos valores retornar após
select * from customers limit 2, 3; 
-- seleciona os 3 maiores valores na coluna 
select * from customers order by points desc limit 3 

-- INNER JOIN --  unir as colunas de uma tabela 
use sql_store;

select * from orders join customers on orders.customer_id = customers.customer_id;

-- selecionar as 3 colunas realizando o merge 
select order_id, first_name, last_name from orders join customers
on orders.customer_id = customers.customer_id ; 
-- quando existe uma mesma coluna em várias tabelas referir 
-- a qual tabela ( order.customer_id)

select order_id, orders.customer_id , first_name, last_name from orders join customers
on orders.customer_id = customers.customer_id ; 

-- abreviando os termos repetidos pela primeira letra
select order_id, o.customer_id, first_name, last_name 
from orders o 
join customers c on o.customer_id = c.customer_id 

-- unindo a tabelas order_items e products pelo product_id

select * from order_items oi join products p on oi.product_id  = p.product_id;

-- selecionando só as colunas desejadas da união das tabelas

select oi.order_id, oi.product_id , quantity , oi.unit_price  from order_items oi 
	join products p on oi.product_id  = p.product_id;

-- JOIN tabelas de outros banco de dados, referenciar em qual banco está a tabela

select * from order_items oi join sql_inventory.products p 
	on oi.product_id  = p.product_id 
	
-- unir colunas dentro da mesma tabela self join  
-- selecionar o outro banco de dados 
	
	
use sql_hr;

select * from employees e join employees m 
	on e.reports_to = m.employee_id
	
-- selecionar apenas as tabelas desejadas passando a referência do banco 

	select e.employee_id, e.first_name, m.first_name as 'gerente'
	from employees e join employees m ;
	
-- JOIN em várias tabelas 
-- unir mais de uma tabela ao mesmo tempo 
use sql_store;

select o.order_id, o.order_date, c.first_name 
, c.last_name , os.name  as 'status da compra'
from orders o join customers c 
	on  o.customer_id  = c.customer_id 
	join order_statuses os on o.status = os.order_status_id 


-- unir 3 ou mais tabelas para dar nome ao status 
	
use sql_invoicing;

select p.date, p.invoice_id , c.name , pm.name, p.amount as 'Volume de compras'
from payments p join clients c 
	on p.client_id = c.client_id 
	join payment_methods pm on 
		p.payment_method  = pm.payment_method_id ;
	
-- JOIN composto, possui  mais de 2 condições para unir as colunas
use sql_store;

select * from order_items oi 
	join order_item_notes oin on oi.order_id = oin.order_id 
	and oi.product_id = oin.product_id ;
	
-- JOIN implícito ( também funciona como o JOIN)
-- Não pode esquecer o WHERE clause, para não unir toda a tabela 

select * from orders o , customers c
	where o.customer_id = c.customer_id 

-- OUTER JOINS
	
	-- LEFT JOIN todos os dados são retornados mesmo se a condição é TRUE ou FALSE	
select c.customer_id , c.first_name, o.order_id
 from customers c left join orders o 
	on c.customer_id  = o.customer_id 
		order by c.customer_id 
		
-- RIGHT JOIN 	- Mesmo resultado que o INNER JOIN 
		-- se inverter tabelas customers e orders, você seleciona todos os dados novamente
select c.customer_id , c.first_name, o.order_id
 from orders o left join  customers c
	on c.customer_id  = o.customer_id 
		order by c.customer_id 
	
-- exercicio 
select p.product_id , p.name , oi.quantity  
	from products p left join order_items oi  
		on p.product_id = oi.product_id
		

-- OUTER JOIN em várias tabelas 
	-- retorna todos os valores das tabelas orders, customers e shippers
select c.customer_id , c.first_name, o.order_id, sh.name as shipper
 from customers c left join  orders o
	on c.customer_id  = o.customer_id 
	left join shippers sh on o.shipper_id  = sh.shipper_id 
		order by c.customer_id ;

-- exercicio 


select o.order_date , o.order_id , c.first_name , 
sh.name as 'Nome do Navio', os.name as 'Status' from orders o join customers c 
	on o.customer_id  = c.customer_id  
		left join shippers sh on o.shipper_id  = sh.shipper_id 
			join order_statuses os on o.status = os.order_status_id ;
	
		
		
		

-- inner join junto com o outter join para pegar todos os dados
-- mesmo não atendendo a condição
 	
use sql_hr;


select e.employee_id , e.first_name , em.first_name as 'Gerente' from employees e 
	left join employees em on e.reports_to  = em.employee_id ;

		
		
-- utilizando a função USING para simplificar a função ON nos JOINS 
use sql_store;

select o.order_id,
		c.first_name from orders o 	join customers c 
		-- join customers c on o.customer_id = c.customer_id
		using (customer_id);
		
		
-- exercicio 
use sql_invoicing;

select p.date, c.name as 'cliente' , p.amount , pm.name  from payments p  join clients c 
	using (client_id) join payment_methods pm 
	on p.payment_method  = pm.payment_method_id 
		

-- NATURAL JOIN  não especifica quais colunas, ele une as coluans de mesmo nome
-- cuidado com o Natural Join ele unirá todas
	
select * from orders o natural join customers c;

-- CROSS JOIN
-- Cruza cada dado de uma coluna com cada dado da outra coluna 

select c.first_name as 'Cliente', p.name as 'product'  
	from customers c cross join products p 

-- Exercicio 
-- função explicita
select * from shippers s cross join products p 

---- função implicita

select s.name as 'Localização', p.name as 'produto oferecido' 
	from shippers s , products p order by unit_price asc
	

	
-- Union irá unir as linhas selecionadas de duas ou mais Querrys
-- para acontecer o UNION as tabelas deverão ter o mesmo número de colunas
	
select order_id , order_date , 'Ativo' as status 
	from orders o where order_date >= '2019-01-01'
union 
select order_id , order_date , 'Arquivado' as status 
	from orders o where order_date <= '2019-01-01'
	

select first_name from customers c 
union 
select name from shippers;

--exercicio 

select c.customer_id , c.first_name , c.points, 'Bronze' as 'status'  
	from customers c where points < 2000
union 
select c.customer_id , c.first_name , c.points, 'Silver' as 'status'  
	from customers c where points between 2000 and 3000
union 
select c.customer_id , c.first_name , c.points, 'Gold' as 'status'  
	from customers c where points > 3000;

-- INSERTING inserindo uma única linha 
-- para inserir as linhas, deve se obedecer a ordem e tipo de dados de cada coluna
-- se difinimos as colunas primeiro, não preisamos colocar valores por default



insert into customers values ( default, 'Nayala', 'Mudesto', '1996-11-10', 987123456,
'Rua Magno alto da capoeira', 'Belo Horizonte', 'MG', 1500
);


insert into customers (first_name, last_name, birth_date , address, city , state)
values ('Benedito', 'Mudesto', '1964-04-06', 'Rua Quinto of Hell' ,'Passa Tempo', 'MG' ); 

-- DELETE  para excluir uma linha
-- isso pode ser útil para localizar e remover outliers, dados incorretos ou repetidos

DELETE FROM customers  WHERE customer_id  in (16, 17);
-- customer_id = 11 and customer_id = 14

insert into customers values (default, 'Guga', 'Pereira',
'1992-01-02', '55745188', 'Rua Joaquina ', 'Belo Horzionte', 'MG', 1000 )


-- INSERT várias linhas ao mesmo tempo 
-- Ao passaro  valor a ser inserido, adicionar parênteses e vírgula

insert into shippers (name) 
	values ('Shipper_1'),
			('Shipper_2'),
			('Shipper_3')

-- Exercicio 
			
insert into products (name, quantity_in_stock, unit_price)
	values ('Grand Resort', 100, 4.50),
			('Le Maison', 41, 1.51), 
			('Le mistery', 31, 30)
	
-- Inserindo linhas em múltiplas tabelas 
-- inserindo multiplaos valores em tabelas pais e filhas 
-- Existe uma chave primária conectando ambas as tabelas
			
			
-- Criando uma linha na tabela mãe 'ORDERS' 
			
insert into orders (customer_id, order_date, status) 
	values (1, '2019-01-02', 1);
-- Adicionando os dados na tabela filha 'ORDERS_ITEMS'
-- a função last_insert_id() é uma função que retorna o último ID para o preencimento
insert into order_items 
	values (last_insert_id(), 1, 1, 2.95),
			(last_insert_id(), 2, 1, 3.00);

		

-- Copiar dados de uma tabela para a outra 
-- Quando copiamos os dados pra uma nova tabela, ela perde sua propriedade (PK, AI )
-- 'select * from orders' é uma sub_querrry dentro de outra querry 
		
create table arquivo_orders as select * from orders o 

-- injeta na nova tabela apenas os dados filtrado pela data 
insert into arquivo_orders 
select * from orders where order_date < '2019-01-01'

-- Exercicio 

use sql_invoicing; 

create table  invoice_arquivos as
select i.invoice_id , i.number, c.name as 'Nome do cliente', i.invoice_total,
		i.payment_total , i.invoice_date,
		i.payment_date , i.due_date 
		  from invoices i join clients c 
	on i.client_id = c.client_id 
	where payment_date > 00 -- ou where payment is not null
	
-- Update uma única linha dentro de uma tabela 
	
update invoices set payment_total = 10, payment_date = '2019-03-01'
where invoice_id = 1 ;
-- caso as coluans possuam configs. de valores por default basta apenas iseri-los

update invoices set payment_total = default, payment_date = null 
	where invoice_id = 1  ;
	
-- realiza cáluclos para inserir novos valores nas linahs da tabela 

update invoices set payment_total = invoice_total * 0.7, 
	payment_date = due_date where invoice_id = 3;


-- UPDATE multiplas linhas, é preciso desbloquear a trava no MYSQL

update invoices set payment_total = invoice_total * 0.5, 
					payment_date = due_date 
					where client_id in (3, 4)
					
-- Exercico 
use sql_store;			
update customers set points = points + 50 where birth_date < '1990-01-01'

-- Usando Subquerrys para realizar updates
-- uma Subquerry é alguma seleção utilizada dentro de outra sequel
use sql_invoicing; 

-- irá utilizar a seleção feita pelo nome 'Vinte' para acessar o ID e fazer o update 
update invoices set payment_total = invoice_total * 0.5,
					payment_date = due_date 
	where client_id  = (select client_id from clients 
						where name = 'Vinte')

-- para selecionar multiplos valores passando um valor da coluna 'state'
-- é importante rodar a subquerry para verificar os valores a serem alterados
						
update invoices set payment_total = invoice_total * 0.5,
					payment_date = due_date 
	where client_id  in  (select client_id from clients -- esta é a subquerry -- 
						where state in ('CA', 'NY'))

-- Exercicio 
use sql_store;


update orders set comments = 'Gold Customers' where customer_id  in 
		(select customer_id  from customers 
		where points > 3000 )

-- Deletar linhas 
		
use sql_invoicing; 

delete from invoices where client_id  = (select * from clients where name = 'Myworks')

-- reataurar DATABASE 


		

-- 2:48



