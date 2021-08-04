select count(*) from quartos q
	join tipos_quartos tq on q.tipo = tq.codigo
	full join reservas r on q.numero = r.quarto
	where q.frigobar ilike 'S' and
			tq.descricao ilike 'quartoDuplo'
			and r.quarto is null;
			
select c.nome, c.origem from hospedes h left join clientes c on h.cpf = c.cpf
	where SUBSTRING(h.placaveiculo, 4, 1) like '1' and right(h.placaveiculo, 1) like '3';
	
select count(*) from hospedes h where length(h.placaveiculo) > 7 or length(h.placaveiculo) < 7;

select cr.descricao, count(*) from consumos con left join cardapios cr on cr.codigo = con.itemcardapio group by cr.descricao;

select cr.descricao from cardapios cr 
	where baratinho = (select min(preco) from cardapios) or 
		carinho = (select max(preco) from cardapios);