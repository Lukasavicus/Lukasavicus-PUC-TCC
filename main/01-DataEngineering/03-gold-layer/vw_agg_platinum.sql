CREATE OR REPLACE  VIEW vw_agg_fact AS
(
    SELECT
        ano_particao,
        SUM(vr_empenhado) as vr_empenhado,
        SUM(vr_liquidado) as vr_liquidado,
        SUM(vr_pago) as vr_pago,
        COUNT(*) as counting
    FROM ft_despesa GROUP BY ano_particao
)