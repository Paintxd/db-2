-- 1
create database locacaonautica;

create table TiposVeiculos (
    codTipo integer,
    descricao varchar(150) not null,
    constraint TiposVeiculosPk primary key (codTipo)
);

create table Habilitacoes (
    codH integer,
    tipo varchar(50) not null,
    idade_min integer not null,
    descricao varchar(150) not null,
    constraint HabilitacoesPk primary key (codH)
);

create table Veiculos (
    matricula integer,
    nome varchar(50) not null,
    modelo varchar(50) not null,
    comprimento integer not null,
    potMotor integer not null,
    vlDiaria integer not null,
    codTipo integer not null,
    constraint VeiculosPk primary key (matricula),
    foreign key (codTipo) references TiposVeiculos (codTipo)
);

create table Funcionarios (
    codF integer,
    nome varchar(50) not null,
    telefone numeric not null,
    endereco varchar(150) not null,
    idade integer not null,
    salario integer not null,
    constraint FuncionariosPk primary key (codF)
);

create table VeiculosHabilitacoes (
    codTipo integer,
    codH integer,
    foreign key (codTipo) references TiposVeiculos (codTipo),
    foreign key (codH) references Habilitacoes (codH),
    constraint VeiculosHabilitacoesPk primary key (codTipo, codH)
);

create table Clientes (
    cpf numeric,
    nome varchar(50) not null,
    endereco varchar(150) not null,
    estado_civil varchar(50),
    num_filhos integer,
    data_nasc date not null,
    telefone numeric not null,
    codH integer not null,
    constraint ClientesPk primary key (cpf),
    foreign key (codH) references Habilitacoes (codH)
);

create table Locacoes (
    codLoc serial,
    valor integer,
    inicio date check (inicio < fim),
    fim date check (fim > inicio),
    obs varchar(150),
    matricula integer,
    codF integer,
    cpf numeric,
    constraint LocacoesPk primary key (codLoc),
    foreign key (matricula) references Veiculos (matricula),
    foreign key (codF) references Funcionarios (codF),
    foreign key (cpf) references Clientes (cpf)
);

insert into TiposVeiculos (codtipo, descricao) values
(1,'Jet-ski'),
(2,'Lancha'),(3,'Veleiro'),(4,'Barco'),(5,'Escuna'),
(6,'Rebocador'),(7,'Iate'),(8,'Navio de carga'),
(9,'Navio de cruzeiro'),(10,'Quebra gelo'),(11,'Transatlantico');


insert into Habilitacoes (codh, tipo, idade_min, descricao) VALUES
        (1, 'Motonauta', 18, 'noob'),
				(2, 'Veleiro',18, 'iniciated'),
				(3, 'Mestre-amador',18,'veterano'),
				(4, 'Capitao-amador',18,'poseidon - deus dos mares');


insert into Veiculos
(matricula, nome, modelo, comprimento, potMotor, vlDiaria, codTipo) VALUES
(101, 'Ligeirinho', 'Vx 700 S Yamaha', 	3.22, 	80, 	300.00, 	1),
(102, 'Jet Bacana', 'Jet Seadoo Gti 130', 	3.36, 	160, 	550.00, 	1),
(201, 'Iemanja 1', 	'Focker 255', 		9, 	400, 	2500, 		2),
(202, 'Felicity', 	'OFF SHORE 56', 	12, 	520, 	3800, 		2),
(203, 'Canary', 	'Cimitarra 340', 	14, 	500,	2600 , 		2),
(301, 'Velador', 	'Velamar 38', 		12.52, 	40, 	1000.00,	3),
(302, 'Veleiro Luxo', 'Beneteau OC 41', 	13.53, 	40, 	8000.00, 	3),
(401, 'Aluminum', 	'Levefort', 		5.3, 	40, 	150.00,		4),
(402, 'Flu-barco', 	'Fluvimar', 		5, 	30, 	100.00,		4),
(501, 'Mae dagua', 	'Vitoria V', 		23, 	400, 	8000.00,	5),
(601, 'Tanker', 	'GT170', 		6, 	800, 	1100, 		6),
(701, 'Boy', 	'Azimut60', 		18, 	600, 	5600, 		7),
(702, 'Wayne', 	'Ferreti960', 		28, 	960, 	7600, 		7),
(901, 'RoyalPrincess', 'RoyalPrincess', 	330, 	2000, 	30000, 		9),
(1001, 'IceBreacker', 'StephanJantzen', 	210, 	3000, 	15000, 		10),
(1101, 'CrossTie', 	'Olympic', 		220, 	2800, 	60000, 		11);


insert into Funcionarios (codf, nome, telefone, endereco, idade, salario) VALUES
(1,'Lucas', 	99998888, 	'Rua Vilarejo', 	24, 780),
				(2,'Joao',  	01212341234,	'Rua das Ortencias',	20, 800.00),
				(3,'Pedro',	01212341235,	'Rua do Barao', 	20, 800.00),
				(4,'Nilmar',	01212341236,	'Rua do Sapo', 		20, 810.00),
				(5,'Jean',	01212341237,	'Rua das Ruas',		21, 800.00),
				(6,'Lucas',	01212341238,	'Rua das Acacias',	25, 890.00),
				(7,'Plinio',	01212341239,	'Rua das Alamedas',	40,1000.00),
				(8,'Renan',	12312341240,	'Rua Verde',		35, 950.00),
				(9,'Henrique',	01231234124,	'Rua Amarela',		22, 850.00),
				(10,'Caio',	01231231242,	'Rua Azul',		22, 800.00),
				(11,'Jairo',	01231234123,	'Rua das Hortencias',	25, 950.00),
				(12,'Leonardo',	012347917452,	'Rua Alemanha',		26, 890.00),
				(13,'Rogerio',	01238573422,	'Rua Argentina',	26, 980.00),
				(14,'Marcio',	01211111111,	'Rua das Orquideas',	23, 800.00);


insert into VeiculosHabilitacoes (codtipo, codh) VALUES
 (1,1),(1,2),(2,2),(3,2),(4,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(8,4),(9,4),(10,4),(11,4);


insert into Clientes (cpf, nome, endereco, estado_civil, num_filhos, data_nasc, telefone, codh) VALUES
(10000000001,'Marcio',	'Rua da Lagoa',	 'Casado',	1,'12-12-1988',01231234567,1),
(10000000002,'Marcelo',	'Rua Costeira',	 'Casado',	0,'18-06-1978',01231234568,1),
(10000000003,'Carlos',	'Rua Amarela',	 'Solteiro',	0,'28-08-1993',01231234569,1),
(10000000004,'Pedro',	'Rua Verde',	 'Casado',	0,'16-05-1976',01231234571,1),
(10000000005,'Lucas',	'Rua das Alamedas','Casado',	0,'14-06-1980',01231234572,2),
(10000000006,'Thomas',	'Rua das Ruas',	 'Viuvo',	5,'18-06-1965',01231234573,1),
(10000000007,'Jose', 	'Avenida Quinta', 'Solteiro',	0,'30-05-1987',01231234574,2),
(10000000008,'Maome',	'Rua Louis', 	 'Casado',	3,'15-09-1975',01231234575,3),
(10000000009,'Antonio',	'Rua das Alamedas', 'Solterio',	0,'13-08-1974',01231234576,4),
(10000000010,'Luis',	'Rua Ingrime', 	 'Casado', 	1,'19-06-1984',01231234581,3),
(10000000011,'Gabriel',	'Rua Alemanha',  'Solteiro', 	0,'30-09-1965',01231234582,2),
(10000000012,'Luisa',	'Rua Argentina', 'Casado',	0,'12-05-1985',01231234583,1),
(10000000013,'Fabio',	'Rua Carvalho',	 'Solteiro',	0,'16-07-1988',01231234584,3),
(10000000014,'Fabiano',	'Avenida Boulevard','Solteiro',	0,'16-07-1988',01231234585,4),
(10000000015,'Joao',	'Rua Escocia',	 'Casado',	3,'14-02-1978',01231234586,2);

insert into locacoes ( valor, inicio, fim, obs, matricula, codf, cpf) VALUES
(	600.00,		'01-08-2020',	'03-08-2020',	'nada',	101,			1,			10000000001),
(	550.00,		'01-08-2020',	'02-08-2020',	'nada',	102,			4,			10000000010),
(	12500.00,	'02-08-2020',	'07-08-2020',	 null,	201,			3,			10000000015),
(	300.00,		'05-08-2020',	'06-08-2020',	 null,	101,			7,			10000000003),
(	1100.00,	'05-08-2020',	'07-08-2020',	 null,	102,			3,			10000000007),
(	16000.00,	'08-08-2020',	'10-08-2020',	 null,	302,			1,			10000000009),
(	150000.00,	'17-08-2020',	'22-08-2020',	 null,	901,			6,			10000000014),
(	2700.00,	'17-08-2020',	'22-08-2020',	 null,	102,			1,			10000000008),
(1500.00,	'18-08-2020',	'25-08-2020',	 null,	101,			7,			10000000005);


-- 2
-- 2.1
select c.cpf, c.nome, h.tipo from clientes c 
	join habilitacoes h on c.codh = h.codh;

-- 2.2
select count (*) as veiculos_disponiveis, h.tipo as tipo_habilitacao
	from veiculoshabilitacoes vh
	join habilitacoes h on h.codh = vh.codh
	join veiculos v on v.codtipo = vh.codtipo 
	group by h.tipo;

-- 2.3
select h.tipo as tipo_habilitacao, v.modelo, v.vldiaria as valor_original, (v.vldiaria - (0.02 * v.vldiaria)) as valor_desconto
	from veiculoshabilitacoes vh
	join habilitacoes h on h.codh = vh.codh
	join veiculos v on v.codtipo  = vh.codtipo 
	where h.tipo = 'Veleiro';

-- 2.4
select t.descricao, count(v.codtipo)
	from tiposveiculos t
	join veiculos v on v.codtipo = t.codtipo
	group by t.descricao;
	
-- 3
create or replace function locaVeiculo(data_locacao_p date, obs_p varchar, matricula_p integer, codf_p integer, cpf_p numeric)
returns integer as $$
declare
	pk integer; fim_locacao date; tipo_habilitacao integer;
begin
	select l.fim into fim_locacao from locacoes l where l.matricula = matricula_p;
	
	if (fim_locacao is null) then
		raise 'Veiculo matricula % ja locado', matricula_p;
	end if;
	
	select vh.codtipo into tipo_habilitacao from clientes c
				join veiculoshabilitacoes vh on vh.codh = c.codh
				join veiculos v on v.codtipo = vh.codtipo
					where c.cpf = cpf_p and v.matricula = matricula_p;
	
	if (tipo_habilitacao is null) then
		raise 'Cliente cpf % nao pode locar veiculo matricula %', cpf_p, matricula_p;
	end if;
	
	insert into locacoes (inicio, obs, matricula, codf, cpf) values 
		(data_locacao_p, obs_p, matricula_p, codf_p, cpf_p) returning codloc into pk;

	return pk;
end;
$$ language plpgsql;

select locaVeiculo(now()::date, 'dando um rolezinho top'::varchar, 101, 1, 10000000008::numeric);

-- 4
-- 4.1
create table logs (
	identificador serial,
	tabela varchar(50),
	operacao varchar(10),
	dadosNovos text,
	dadosAntigos text,
    constraint LogsPk primary key (ID)
);

-- 4.2
create or replace function save_log() 
returns trigger
as $$
declare 
	dados_antigos text; dados_novos text;
begin 
	if (TG_OP = 'UPDATE') then
	dados_antigos := row(old.*);
	dados_novos := row(new.*);

	insert into logs (tabela, operacao, dadosNovos, dadosAntigos) values(TG_TABLE_NAME, TG_OP, dados_novos, dados_antigos);
	
	return new;
	elsif (TG_OP = 'DELETE') then
	dados_antigos := row(old.*);

	insert into logs (tabela, operacao, dadosNovos, dadosAntigos) values (TG_TABLE_NAME, TG_OP, default, dados_antigos);
	
	return old;
	end if;
end;
$$ language plpgsql;

-- 4.2 a | b
create trigger log_clientes
after update or delete on clientes
for each row execute procedure save_log();

create trigger log_locacoes
after update or delete on locacoes
for each row execute procedure save_log();

delete from locacoes where codloc = 10;
