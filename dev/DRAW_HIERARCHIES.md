DRAW HIERARCHIES:
- FUNCAO (n..n) SUBFUNCAO

select * from "dm_subfuncao_desp_csv" where ID_SUBFUNCAO = 3927
----
id_subfuncao, ano_exercicio, cd_subfuncao, nome
3927, 2022, 122, ADMINISTRACAO GERAL


----

select * from "dm_funcao_desp_csv" where ID_FUNCAO IN (1948, 1954, 1957)
id_funcao
ano_exercicio
cd_funcao
nome
#, id_funcao, ano_exercicio, cd_funcao, nome
1, 1948, 2022, 10, SAUDE
2, 1954, 2022, 3, ESSENCIAL A JUSTICA
3, 1957, 2022, 6, SEGURANCA PUBLICA