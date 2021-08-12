select nome, CPF, origem from clientes;

select descricao, preco from cardapios 
  where preco > 30.0;

select nome, CPF, fone from clientes 
  where origem like 'Florianopolis' or 
        origem like 'Joinvile' or 
        origem like 'Blumenau';

select q.* from reservas r join quartos q on r.quarto = q.numero 
  where r.dataEnt between '2019-12-07' and '2019-12-13';

select h.cpf, h.motivo, q.* from hospedes h join reservas r on h.cpf = r.cliente 
                                            join quartos q on q.numero = r.quarto 
                                            where h.nroacomp > 5;

select h.nroacomp, r.dataEnt, r.dataSai from hospedes h join reservas r on h.cpf = r.cliente 
  where h.nroacomp < 0 or
        r.dataSai < r.dataEnt;
