--2
select count(*) from quartos q
	join tipos_quartos tq on q.tipo = tq.codigo
	full join reservas r on q.numero = r.quarto
	where q.frigobar ilike 'S' and
			tq.descricao ilike 'quartoDuplo'
			and r.quarto is null;

-- 3
select c.nome, c.origem from hospedes h left join clientes c on h.cpf = c.cpf
	where SUBSTRING(h.placaveiculo, 4, 1) like '1' and right(h.placaveiculo, 1) like '3';
	
-- 4
 select
	count(*)
from
	hospedes h
where
	length(h.placaveiculo) != 7;

-- 5
select cr.descricao, count(con.id) from consumos con join cardapios cr on cr.codigo = con.itemcardapio group by cr.descricao;

-- 6
select * from 
	(select min(preco) as preco, descricao from cardapios group by descricao, preco order by preco limit 1) as mais_barato  
	union all
select * from 
	(select max(preco) as preco, descricao from cardapios group by descricao limit 1) as mais_caro;

-- 7
select h.cpf, c.nome, h.placaveiculo, q.numero, tq.descricao, h.datasai 
	from hospedes h 
		join clientes c on h.cpf = c.cpf
		join quartos q on h.quarto = q.numero
		join tipos_quartos tq on q.tipo = tq.codigo;
	
-- 8
--select q.numero from hospedes h 
--	join consumos con on con.hospede = h.cpf
--	join quartos q on q.numero = h.quarto
--	join cardapios car on car.codigo = con.itemcardapio
--	where con.data = '2019-10-12'
--        group by q.numero, car.descricao
--        having car.descricao in ('almoco', 'janta');
--       
       
SELECT qua.numero quarto, hos.cpf hospede_cpf FROM hospedes hos
  JOIN quartos qua ON hos.quarto = qua.numero
  WHERE EXISTS ( SELECT 1
                   FROM consumos cons 
                   JOIN cardapios car ON cons.itemcardapio = car.codigo
                   WHERE cons.hospede = hos.cpf
                   AND cons.data = '2019/10/12'
                   AND car.descricao = 'almoco'
               )
   AND EXISTS ( SELECT 1
                   FROM consumos cons 
                   JOIN cardapios car ON cons.itemcardapio = car.codigo
                   WHERE cons.hospede = hos.cpf
                   AND cons.data = '2019/10/12'
                   AND car.descricao = 'janta'
               );

-- 9
select c.nome, count(h.cpf) as vezes_hospedado, avg(h.datasai - h.dataent) as media_hospedagem from clientes c 
	join hospedes h on c.cpf = h.cpf 
		group by c.nome
		having count(h.cpf) > 1;

-- 10
select c.codigo, c.descricao from cardapios c where not exists 
      (select * from hospedes h where not exists 
      (select * from consumos c2 where c2.hospede = h.cpf and c.codigo = c2.itemcardapio));

