CREATE OR REPLACE  VIEW vw_agg_categ_econ AS
(
    SELECT
        ano_particao, id_categ_econ,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_categ_econ
        ORDER BY ano_particao, id_categ_econ
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_grupo AS
(
    SELECT
        ano_particao, id_grupo,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_grupo
        ORDER BY ano_particao, id_grupo
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_procedencia AS
(
    SELECT
        ano_particao, id_procedencia,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_procedencia
        ORDER BY ano_particao, id_procedencia
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_modalidade_aplic AS
(
    SELECT
        ano_particao, id_modalidade_aplic,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_modalidade_aplic
        ORDER BY ano_particao, id_modalidade_aplic
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_funcao AS
(
    SELECT
        ano_particao, id_funcao,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_funcao
        ORDER BY ano_particao, id_funcao
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_elemento AS
(
    SELECT
        ano_particao, id_elemento,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_elemento
        ORDER BY ano_particao, id_elemento
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_tipo_documento AS
(
    SELECT
        ano_particao, id_tipo_documento,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_tipo_documento
        ORDER BY ano_particao, id_tipo_documento
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_subfuncao AS
(
    SELECT
        ano_particao, id_subfuncao,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_subfuncao
        ORDER BY ano_particao, id_subfuncao
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_fonte AS
(
    SELECT
        ano_particao, id_fonte,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_fonte
        ORDER BY ano_particao, id_fonte
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE  VIEW vw_agg_unidade_orc AS
(
    SELECT
        ano_particao, id_unidade_orc,
        count(*) as counting,
        sum(vr_empenhado) as s_vr_empenhado,
        sum(vr_liquidado) as s_vr_liquidado,
        sum(vr_pago) as s_vr_pago
        FROM ft_despesa GROUP BY ano_particao, id_unidade_orc
        ORDER BY ano_particao, id_unidade_orc
)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------