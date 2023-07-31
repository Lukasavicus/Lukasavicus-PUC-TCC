SELECT
    COUNT(DISTINCT categ_econ_nome) as categ_econ,
    COUNT(DISTINCT elemento_desp_nome) as elemento_desp,
    COUNT(DISTINCT empenhos_desp_dt_empenho) as empenhos_desp_dt_empenho,
    COUNT(DISTINCT empenhos_desp_unidade_executora) as empenhos_desp_unidade_executora,
    COUNT(DISTINCT empenhos_desp_uni_prog_gasto) as empenhos_desp_uni_prog_gasto,
    COUNT(DISTINCT empenhos_desp_tipo_empenho) as empenhos_desp_tipo_empenho,
    COUNT(DISTINCT grupo_nome) as grupo,
    COUNT(DISTINCT procedencia_nome) as procedencia,
    COUNT(DISTINCT favorecido_nome_anonimizado) as favorecido_nome_anonimizado,
    COUNT(DISTINCT unidade_orc_administracao) as unidade_orc_administracao,
    COUNT(DISTINCT unidade_orc_grupo_administracao) as unidade_orc_grupo_administracao,
    COUNT(DISTINCT programa_nome) as programa,
    COUNT(DISTINCT funcao_desp_nome) as funcao_desp,
    COUNT(DISTINCT item_desp_nome) as item_desp,
    COUNT(DISTINCT unidade_orc_sigla) as unidade_orc_sigla,
    COUNT(DISTINCT fonte_nome) as fonte,
    COUNT(DISTINCT unidade_orc_nome) as unidade_orc,
    COUNT(DISTINCT modalidade_aplic_nome) as modalidade_aplic
    from "vw_dw"
    