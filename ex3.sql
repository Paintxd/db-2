-- 1
select datasai - dataent as dias_hospedado, (select nome from clientes c where c.cpf = h.cpf)
	from hospedes h;

-- 2
select datasai - dataent as dias_hospedado, (select nome from clientes c where c.cpf = h.cpf)
	from hospedes h;

-- 3
 select * from 
 	(select count(*) pedidos, (select descricao from cardapios car where car.codigo = con.itemcardapio)
		from consumos con
		group by con.itemcardapio
		order by pedidos limit 1
	) as c
	union all
 select * from 
 	(select count(*) pedidos, (select descricao from cardapios car where car.codigo = con.itemcardapio)
		from consumos con
		group by con.itemcardapio
		order by pedidos desc limit 1
	) as c1;

-- 4
select (select (select preco from cardapios car where car.codigo = con.itemcardapio)
		from consumos con
		where con."data" = '2017-10-12'
		order by preco desc limit 1) 
	as mais_barato,
		(select (select preco from cardapios car where car.codigo = con.itemcardapio)
		from consumos con
		where con."data" = '2017-10-12'
		order by preco limit 1) 
	as mais_caro;

-- 5
select (select nome from clientes c where c.cpf = h.cpf),
	h.cpf, h.placaveiculo, h.datasai, h.quarto,
	(select descricao as descricao_quarto from tipos_quartos tq where tq.codigo = h.quarto)
	from hospedes h;

-- 6
select (select quarto from hospedes h where h.cpf = con.hospede)
	from consumos con
	where con."data" = '2017-10-12' and
	exists (select 1 
				from cardapios car 
				where car.codigo = con.itemcardapio and 
				car.descricao ilike 'janta'
			) and
	exists (select 1
				from cardapios car 
				where car.codigo = con.itemcardapio and 
				car.descricao ilike 'almoco'
			);

-- 7
select car.descricao from cardapios car
	where not exists (select 1 from consumos con where con.itemcardapio = car.codigo);

-- 8
select c.cpf, c.nome, c.fone from clientes c
	where exists (select 1 from hospedes h 
					where h.cpf = c.cpf and 
					h.dataent <= '2017-10-12' and
					h.datasai >= '2017-10-12'
				 );
		
-- 9
select car.codigo, car.descricao from cardapios car
	where car.codigo in (
		select con.itemcardapio from consumos con where exists (
			select 1 from hospedes h where 
				con.hospede = h.cpf
		)
	);

-- 10
select car.* from cardapios car
	where not exists (select 1 from consumos con where con.itemcardapio = car.codigo);
