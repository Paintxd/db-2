-- 1
create or replace function name_uppercase() 
returns trigger 
as $$
begin 
	new.nome := upper(new.nome);
	return new;
end;
$$ language plpgsql;

create trigger name_uppercase
before insert on clientes
for each row execute procedure name_uppercase();

insert into clientes (cpf, nome, origem, fone) values ('90000000009', 'Joao', 'Chapecó', '90000000');

-- 2
create table logs_hospede_reservas (
	ID serial,
	tabela varchar(50),
	op varchar(10),
	dadosNovos text,
	dadosAntigos text,
	constraint LogsPk primary key (ID)
);

-- 3
create or replace function save_log() 
returns trigger
as $$
declare 
	dados_antigos text; dados_novos text;
begin 
	if (TG_OP = 'UPDATE') then
	dados_antigos := row(old.*);
	dados_novos := row(new.*);

	insert into logs_hospede_reservas (tabela, op, dadosNovos, dadosAntigos) values(TG_TABLE_NAME, TG_OP, dados_novos, dados_antigos);
	
	return new;
	elsif (TG_OP = 'DELETE') then
	dados_antigos := row(old.*);

	insert into logs_hospede_reservas (tabela, op, dadosNovos, dadosAntigos) values (TG_TABLE_NAME, TG_OP, default, dados_antigos);
	
	return old;
	end if;
end;
$$ language plpgsql;

create trigger log_hospedes
after update or delete on hospedes
for each row execute procedure save_log();

create trigger log_reservas
after update or delete on reservas
for each row execute procedure save_log();

insert into hospedes values ('90000000009', 'trabalho', 'ABC123', 0, CURRENT_DATE, '2021-09-05', 1);
update hospedes set nroacomp = 1 where cpf = '90000000009';
delete from hospedes where cpf = '90000000009';

insert into reservas values ('90000000009', 1, CURRENT_DATE, '2021-09-04');
update reservas set datasai = '2021-09-05' where cliente = '90000000009';
delete from reservas where cliente = '90000000009';
