CREATE OR REPLACE  VIEW vw_agg_grouped_favorecidos AS
(
    SELECT
        favorecido_nome_anonimizado as nome_favorecido,
        array_agg(empenhos_desp_uni_prog_gasto) as grupo,
        cardinality(array_agg(empenhos_desp_uni_prog_gasto)) as cardinalidade
        FROM
            (SELECT distinct empenhos_desp_uni_prog_gasto, favorecido_nome_anonimizado FROM "dep-puc"."vw_dw")
        group by favorecido_nome_anonimizado
)