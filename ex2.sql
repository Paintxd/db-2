--1 
select count(*) from quartos q
	join tipos_quartos tq on q.tipo = tq.codigo
	full join reservas r on q.numero = r.quarto
	where q.frigobar ilike 'S' and
			tq.descricao ilike 'quartoDuplo'
			and r.quarto is null;
	
-- 2
select c.nome, c.origem from hospedes h left join clientes c on h.cpf = c.cpf
	where SUBSTRING(h.placaveiculo, 4, 1) like '1' and right(h.placaveiculo, 1) like '3';
	
-- 3
select count(*) from hospedes h where length(h.placaveiculo) > 7 or length(h.placaveiculo) < 7;

-- 4
select cr.descricao, count(*) from consumos con left join cardapios cr on cr.codigo = con.itemcardapio group by cr.descricao;

-- 5
select min(preco) as mais_barato, max(preco) as mais_caro, array_agg(distinct descricao) from cardapios;

-- 6
select * from 
	(select min(preco) as preco, descricao from cardapios group by descricao, preco order by preco limit 1) as mais_barato  
	union all
select * from 
	(select max(preco) as preco, descricao from cardapios group by descricao limit 1) as mais_caro;

-- 7
select h.cpf, c.nome, h.placaveiculo, q.numero, tq.descricao, h.datasai 
	from hospedes h 
		left join clientes c on h.cpf = c.cpf
		left join quartos q on h.quarto = q.numero
		left join tipos_quartos tq on q.tipo = tq.codigo;
	
-- 8
select q.numero from hospedes h 
	left join consumos con on con.hospede = h.cpf
	left join quartos q on q.numero = h.quarto
	left join cardapios car on car.codigo = con.itemcardapio
	where car.descricao ilike 'janta' or
		car.descricao ilike 'almoco' and 
		con.data = '2019-10-12';

select * from consumos con;
select * from cardapios car;
select * from hospedes h;
select * from clientes c;
select * from quartos q;
select * from tipos_quartos tq;