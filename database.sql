create database hotelzinho;

create table clientes (
  CPF char(11),
  nome varchar(160),
  origem varchar(120),
  fone char(11),
  constraint ClientePk primary key (CPF)
);

create table tipos_quartos (
  codigo serial,
  descricao varchar(20) check (
    descricao in (
      'quartoSimples',
      'quartoDuplo',
      'quartoTriplo',
      'aptoSimples',
      'aptoDuplo',
      'aptoTriplo'
    )
  ),
  preco numeric(5, 2) check (preco > 0),
  constraint TipoQuartoPk primary key (codigo)
);

create table quartos (
  numero serial,
  frigobar char(1) check (frigobar in ('S', 'N')),
  tipo integer,
  constraint QuartoPk primary key (numero),
  constraint TipoQuarto foreign key (tipo) references tipos_quartos
);

create table hospedes (
  CPF char(11),
  motivo varchar(20),
  placaVeiculo varchar(10),
  nroAcomp numeric(2),
  dataEnt date,
  dataSai date,
  quarto integer,
  constraint HospedePk primary key (CPF),
  constraint CPFHospede foreign key (CPF) references clientes,
  constraint QuartoHospede foreign key (quarto) references quartos
);

create table reservas (
  cliente varchar(11),
  quarto integer,
  dataEnt date,
  dataSai date,
  constraint CPFCliente foreign key (cliente) references clientes,
  constraint ReservaPk primary key (quarto, dataEnt)
);

create table cardapios (
  codigo serial,
  descricao varchar(120),
  preco numeric(5, 2) check (preco > 0),
  constraint CardapioPk primary key (codigo)
);

create table consumos (
  ID serial,
  hospede varchar(11),
  itemCardapio integer,
  data date,
  qtde integer check (qtde > 0),
  constraint ConsumoPk primary key (ID),
  constraint CPFHospedeConsumo foreign key (hospede) references clientes,
  constraint CodigoCardapio foreign key (itemCardapio) references cardapios
);

insert into clientes (CPF, nome, origem, fone) values
('10000000001', 'Dexter', 'Florianopolis', '10000000'),
('20000000002', 'Harry Potter', 'Blumenau', '20000000'),
('30000000003', 'Hannibal', 'Joinville', '30000000'),
('40000000004', 'Jon Snow', 'Winterfell', '40000000'),
('50000000005', 'Lucifer', 'Hell', '50000000'),
('60000000006', 'Harvey Specter', 'New York', '60000000'),
('70000000007', 'James T Kirk', 'Enterprise', '70000000');

insert into tipos_quartos (codigo, descricao, preco) values
(1,'quartoSimples', 100),
(2,'quartoDuplo', 200),
(3,'quartoTriplo', 300),
(4,'aptoSimples', 400),
(5,'aptoDuplo', 500),
(6,'aptoDuplo', 600);

insert into quartos (numero, frigobar, tipo) values
(1, 'S', 1),
(2, 'N', 3),
(3, 'S', 5),
(4, 'N', 6),
(5, 'N', 5),
(6, 'S', 2);

insert into hospedes (cpf, motivo, placaVeiculo, nroAcomp, dataEnt, dataSai, quarto) values
('10000000001', 'trabalho', 'ABC1234', 0, '2019-10-01', '2019-10-03', 1),
('20000000002', 'estudo', 'DEF1234', 2, '2019-10-03', '2019-10-13', 2),
('30000000003', 'visita familiar', 'GHI123', 1, '2019-11-09', '2019-11-14', 3),
('40000000004', 'visita familiar', 'JKL123', 4, '2019-10-13', '2019-10-15',4),
('50000000005', 'turismo', 'MNO123', 1, '2019-01-01', '2019-06-01',5);

insert into reservas (cliente, quarto, dataEnt, dataSai) values
('60000000006', 4, '2019-06-05', '2019-06-07'),
('70000000007', 5, '2019-12-18', '2019-12-23'),
('20000000002', 3, '2019-11-01', '2019-11-05'),
('40000000004', 2, '2019-05-23', '2019-05-24'),
('30000000003', 1, '2019-12-10', '2019-12-14');

insert into cardapios (codigo, descricao, preco) values
(1, 'cafe', 10),
(2, 'almoco', 20),
(3, 'janta', 30),
(4, 'salgado', 40),
(5, 'refrigerante', 50),
(6, 'sanduiche', 60),
(7, 'sanduiche', 70);

insert into consumos (id, hospede, itemCardapio, data, qtde) values
(1, '10000000001', 1, '2019-10-02',1),
(2, '10000000001', 3, '2019-10-02',1),
(3, '20000000002', 2, '2019-10-12',2),
(4, '30000000003', 4, '2019-11-10',5),
(5, '40000000004', 1, '2019-10-14',3),
(6, '50000000005', 5, '2019-05-15',4),
(7, '20000000002', 3, '2019-10-15',1);

select * from consumos con;
select * from cardapios car;
select * from clientes c;
select * from hospedes h;
select * from reservas r;
select * from quartos q;
select * from tipos_quartos tq;
