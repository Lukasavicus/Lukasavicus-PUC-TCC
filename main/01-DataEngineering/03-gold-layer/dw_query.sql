
CREATE OR REPLACE VIEW "vw_dw" AS 
(
   SELECT
     ft_despesa_last24m.id id, 
     dm_tempo_diario_csv.dia dia
   , dm_tempo_diario_csv.mes mes
   , dm_tempo_diario_csv.ano ano
   , dm_categ_econ_csv.nome categ_econ_nome
   , dm_grupo_desp_csv.nome grupo_nome
   , dm_elemento_desp_csv.nome elemento_desp_nome
   , dm_item_desp_csv.nome item_desp_nome
   , dm_fonte_csv.nome fonte_nome
   , dm_modalidade_aplic_csv.nome modalidade_aplic_nome
   , dm_funcao_desp_csv.nome funcao_desp_nome
   , dm_subfuncao_desp_csv.nome subfuncao_desp_nome
   , dm_programa_csv.nome programa_nome
   , dm_procedencia_csv.nome procedencia_nome
   , dm_unidade_orc_csv.grupo_administracao unidade_orc_grupo_administracao
   , dm_unidade_orc_csv.administracao unidade_orc_administracao
   , dm_unidade_orc_csv.nome unidade_orc_nome
   , dm_unidade_orc_csv.sigla unidade_orc_sigla
   , dm_favorecido_csv.nome_anonimizado favorecido_nome_anonimizado
   , dm_empenhos_desp.dt_empenho empenhos_desp_dt_empenho
   , dm_empenhos_desp.unidade_executora empenhos_desp_unidade_executora
   , dm_empenhos_desp.tipo_empenho empenhos_desp_tipo_empenho
   , dm_empenhos_desp.vr_empenho empenhos_desp_vr_empenho
   , dm_empenhos_desp.uni_prog_gasto empenhos_desp_uni_prog_gasto
   , dm_tipo_documento_csv.nome tipo_documento_nome
   , dm_situacao_op_desp_csv.nome situacao_op_desp_nome
   , vr_empenhado
   , vr_liquidado
   , vr_pago
   FROM
     ((((((((((((((((ft_despesa_last24m
   INNER JOIN dm_categ_econ_csv ON (ft_despesa_last24m.id_categ_econ = dm_categ_econ_csv.id_categ_econ))
   INNER JOIN dm_elemento_desp_csv ON (ft_despesa_last24m.id_elemento = dm_elemento_desp_csv.id_elemento))
   INNER JOIN dm_empenhos_desp ON (ft_despesa_last24m.id_empenho = dm_empenhos_desp.id_empenho))
   INNER JOIN dm_favorecido_csv ON (ft_despesa_last24m.id_favorecido = dm_favorecido_csv.id_favorecido))
   INNER JOIN dm_fonte_csv ON (ft_despesa_last24m.id_fonte = dm_fonte_csv.id_fonte))
   INNER JOIN dm_funcao_desp_csv ON (ft_despesa_last24m.id_funcao = dm_funcao_desp_csv.id_funcao))
   INNER JOIN dm_grupo_desp_csv ON (ft_despesa_last24m.id_grupo = dm_grupo_desp_csv.id_grupo))
   INNER JOIN dm_item_desp_csv ON (ft_despesa_last24m.id_item = dm_item_desp_csv.id_item))
   INNER JOIN dm_modalidade_aplic_csv ON (ft_despesa_last24m.id_modalidade_aplic = dm_modalidade_aplic_csv.id_modalidade_aplic))
   INNER JOIN dm_procedencia_csv ON (ft_despesa_last24m.id_procedencia = dm_procedencia_csv.id_procedencia))
   INNER JOIN dm_programa_csv ON (ft_despesa_last24m.id_programa = dm_programa_csv.id_programa))
   INNER JOIN dm_situacao_op_desp_csv ON (ft_despesa_last24m.tp_operacao = dm_situacao_op_desp_csv.id_situacao_op))
   INNER JOIN dm_subfuncao_desp_csv ON (ft_despesa_last24m.id_subfuncao = dm_subfuncao_desp_csv.id_subfuncao))
   INNER JOIN dm_tempo_diario_csv ON (ft_despesa_last24m.id_tempo = dm_tempo_diario_csv.id_tempo))
   INNER JOIN dm_tipo_documento_csv ON (ft_despesa_last24m.id_tipo_documento = dm_tipo_documento_csv.id_tipo_documento))
   INNER JOIN dm_unidade_orc_csv ON (ft_despesa_last24m.id_unidade_orc = dm_unidade_orc_csv.id_unidade_orc))

-- ----------------------------------------------------------------------------

-- CREATE OR REPLACE  VIEW vw_dw AS
-- (
--     SELECT
--         ft_despesa_last24m.id id, 
--         dm_tempo_diario_csv.dia as dia, dm_tempo_diario_csv.mes as mes, dm_tempo_diario_csv.ano as ano,                         -- id_tempo, 
--         dm_categ_econ_csv.nome as categ_econ_nome,                                                                              -- id_categ_econ, 
--         dm_grupo_desp_csv.nome as grupo_nome,                                                                                   -- id_grupo, 
--         dm_elemento_desp_csv.nome as elemento_desp_nome,                                                                        -- id_elemento, 
--         dm_item_desp_csv.nome as item_desp_nome,                                                                                -- id_item, 
--         dm_fonte_csv.nome as fonte_nome,                                                                                        -- id_fonte, 
--         dm_modalidade_aplic_csv.nome as modalidade_aplic_nome,                                                                  -- id_modalidade_aplic, 
--         dm_funcao_desp_csv.nome as funcao_desp_nome,                                                                            -- id_funcao, 
--         dm_subfuncao_desp_csv.nome as subfuncao_desp_nome,                                                                      -- id_subfuncao, 
--         dm_programa_csv.nome as programa_nome,                                                                                  -- id_programa, 
--         -- dm_acao_csv.nome as acao_nome, -- id_acao, 
--         dm_procedencia_csv.nome as procedencia_nome,                                                                            -- id_procedencia, 
        
--         dm_unidade_orc_csv.grupo_administracao as unidade_orc_grupo_administracao,
--         dm_unidade_orc_csv.administracao as unidade_orc_administracao,
--         dm_unidade_orc_csv.nome as unidade_orc_nome,
--         dm_unidade_orc_csv.sigla as unidade_orc_sigla,
--                                                                                                                                 --id_unidade_orc, 
--         dm_favorecido_csv.nome_anonimizado as favorecido_nome_anonimizado,                                                      -- id_favorecido, 
        
--         dm_empenhos_desp.dt_empenho as empenhos_desp_dt_empenho,
--         dm_empenhos_desp.unidade_executora as empenhos_desp_unidade_executora,
--         dm_empenhos_desp.tipo_empenho as empenhos_desp_tipo_empenho,
--         dm_empenhos_desp.vr_empenho as empenhos_desp_vr_empenho,
--         dm_empenhos_desp.uni_prog_gasto as empenhos_desp_uni_prog_gasto,
--                                                                                                                                 -- id_empenho, 
--         dm_tipo_documento_csv.nome as tipo_documento_nome,                                                                      -- id_tipo_documento, 
--         dm_situacao_op_desp_csv.nome as situacao_op_desp_nome,                                                                  -- tp_operacao, 
--         -- cd_documento, cd_evento,  dt_anomes,  ano_particao, 
--         vr_empenhado, 
--         vr_liquidado, 
--         vr_pago
--         FROM ft_despesa_last24m
--         JOIN dm_categ_econ_csv ON ft_despesa_last24m.id_categ_econ = dm_categ_econ_csv.id_categ_econ
--         -- JOIN dm_acao_csv ON ft_despesa_last24m.id_acao = dm_acao_csv.id_acao -- acao so contem dados de 1995~2017
--         JOIN dm_elemento_desp_csv ON ft_despesa_last24m.id_elemento = dm_elemento_desp_csv.id_elemento
--         JOIN dm_empenhos_desp ON ft_despesa_last24m.id_empenho = dm_empenhos_desp.id_empenho
--         JOIN dm_favorecido_csv ON ft_despesa_last24m.id_favorecido = dm_favorecido_csv.id_favorecido
--         JOIN dm_fonte_csv ON ft_despesa_last24m.id_fonte = dm_fonte_csv.id_fonte
--         JOIN dm_funcao_desp_csv ON ft_despesa_last24m.id_funcao = dm_funcao_desp_csv.id_funcao
--         JOIN dm_grupo_desp_csv ON ft_despesa_last24m.id_grupo = dm_grupo_desp_csv.id_grupo
--         JOIN dm_item_desp_csv ON ft_despesa_last24m.id_item = dm_item_desp_csv.id_item
--         JOIN dm_modalidade_aplic_csv ON ft_despesa_last24m.id_modalidade_aplic = dm_modalidade_aplic_csv.id_modalidade_aplic
--         JOIN dm_procedencia_csv ON ft_despesa_last24m.id_procedencia = dm_procedencia_csv.id_procedencia
--         JOIN dm_programa_csv ON ft_despesa_last24m.id_programa = dm_programa_csv.id_programa
--         JOIN dm_situacao_op_desp_csv ON ft_despesa_last24m.tp_operacao = dm_situacao_op_desp_csv.id_situacao_op
--         JOIN dm_subfuncao_desp_csv ON ft_despesa_last24m.id_subfuncao = dm_subfuncao_desp_csv.id_subfuncao
--         JOIN dm_tempo_diario_csv ON ft_despesa_last24m.id_tempo = dm_tempo_diario_csv.id_tempo
--         JOIN dm_tipo_documento_csv ON ft_despesa_last24m.id_tipo_documento = dm_tipo_documento_csv.id_tipo_documento
--         JOIN dm_unidade_orc_csv ON ft_despesa_last24m.id_unidade_orc = dm_unidade_orc_csv.id_unidade_orc
-- )
) 