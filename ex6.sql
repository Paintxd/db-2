-- 2
create index idx_hospedes_placa on hospedes using hash (placaveiculo);

select cpf from hospedes h where placaveiculo = 'ABC1234';