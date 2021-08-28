-- 1
create or replace function calculaFatorial(n int)
returns integer as $$
declare 
	soma integer; temp integer;
begin
	soma := 1;
	for temp in 1..n loop
		soma := soma * temp;
	end loop;
	return soma;
end;
$$ language plpgsql;

select calculaFatorial(6);

-- 2 QUARTO
-- a
create or replace function insereQuarto(frigobar_p char, tipo_p int)
returns integer as $$
declare
	pk integer;
begin
	insert into quartos (frigobar, tipo) values (frigobar_p, tipo_p) returning numero into pk;

	return pk;
end;
$$ language plpgsql;

select insereQuarto('S', 2);

-- b
create or replace function updateQuarto(id int, values_update varchar)
returns void as $$
begin 
	execute 'update quartos set ' || values_update || ' where numero = ' || id;	
end;
$$ language plpgsql;

select updateQuarto(1, 'frigobar = ' || quote_literal('N'));

-- c
create or replace function deleteQuarto(id int)
returns boolean as $$
declare 
	rowsDeleted integer;
begin 
	delete from quartos where numero = $1;
	get diagnostics rowsDeleted = ROW_COUNT;

	return rowsDeleted > 0;
end;
$$ language plpgsql;

select deleteQuarto(10);

-- 2 CLIENTES
-- a
create or replace function insereCliente(cpf_p varchar, nome_p varchar, origem_p varchar, fone_p varchar)
returns varchar as $$
declare
	pk varchar;
begin
	insert into clientes (cpf, nome, origem, fone) values ($1, $2, $3, $4) returning cpf into pk;

	return pk;
end;
$$ language plpgsql;

select insereCliente('80000000008', 'Carlim', 'Chapecó', '80000000');

-- b
create or replace function updateCliente(id varchar, values_update varchar)
returns void as $$
begin 
	execute 'update clientes set ' || values_update || ' where cpf = ' || id;	
end;
$$ language plpgsql;

select updateCliente(quote_literal('80000000008'), 'nome = ' || quote_literal('Carlos'));

-- c
create or replace function deleteCliente(id varchar)
returns boolean as $$
declare 
	rowsDeleted integer;
begin 
	delete from clientes where cpf = $1;
	get diagnostics rowsDeleted = ROW_COUNT;

	return rowsDeleted > 0;
end;
$$ language plpgsql;

select deleteCliente(quote_literal('80000000008'));

-- 3
create or replace function passaRegua(cpf_p varchar)
returns numeric as $$
declare 
	valorTotal numeric;
begin
	update hospedes set datasai = CURRENT_DATE where cpf = $1;

	select (h.datasai - h.dataent) * (select tq.preco 
											from tipos_quartos tq 
											where tq.codigo = (select q.tipo 
																		from quartos q 
																		where q.numero = h.quarto)
										) as valor_pagar
		from hospedes h
		where h.cpf = $1 into valorTotal;
	
	return valorTotal;
end;
$$ language plpgsql;

select passaRegua('40000000004');

-- 4
create or replace function passaReguaTotal(cpf_p varchar)
returns numeric as $$
declare 
	valorHospedagem numeric; valorConsumo numeric; tuple RECORD;
begin
	valorConsumo := 0.00;
	update hospedes set datasai = CURRENT_DATE where cpf = $1;

	select (h.datasai - h.dataent) * (select tq.preco 
											from tipos_quartos tq 
											where tq.codigo = (select q.tipo 
																		from quartos q 
																		where q.numero = h.quarto)
										) as valor_pagar
		from hospedes h
		where h.cpf = $1 into valorHospedagem;
	
	for tuple in select itemcardapio, qtde from consumos c where c.hospede = $1 loop
		valorConsumo := valorConsumo + (tuple.qtde * (select preco from cardapios car 
																	where car.codigo = tuple.itemcardapio));
	end loop;
	
	return valorHospedagem + valorConsumo;
end;
$$ language plpgsql;

select passaReguaTotal('40000000004');

-- 5
create table tabela_teste (
	ID serial,
	texto varchar(100),
	constraint TestePk primary key (ID)
);

create or replace function insertStringGerada(qtde_p int)
returns void as $$
begin
	while qtde_p > 0 loop 
		insert into tabela_teste (texto) values (MD5(random()::text));
		qtde_p := qtde_p - 1;
	end loop;
end;
$$ language plpgsql;

select insertStringGerada(2);
select * from tabela_teste;

-- 6
create or replace function consumirProduto(nomeItem_p varchar, qtde_p int, cpf_p varchar)
returns void as $$
declare 
	idCardapio int;
begin
	select codigo from cardapios car where car.descricao = $1 into idCardapio;

	if idCardapio is null then
		insert into cardapios (descricao, preco) values ($1, 10) returning codigo into idCardapio; 
	end if;
	
	insert into consumos (hospede, itemcardapio, data, qtde) values ($3, idCardapio, CURRENT_DATE, $2);
end;
$$ language plpgsql;

select consumirProduto('cafe', 2, '40000000004');

-- 7
create or replace function retornaItensCardapio()
returns text[] as $$
declare 
	descricoes text[]; tuple RECORD;
begin
	descricoes := ARRAY[]::TEXT[];
	
	for tuple in select descricao from cardapios loop
		descricoes := array_append(descricoes, tuple.descricao::TEXT);
	end loop;

	return descricoes;
end;
$$ language plpgsql;

select retornaItensCardapio();
