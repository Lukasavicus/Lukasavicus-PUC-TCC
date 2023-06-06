CREATE OR REPLACE VIEW "vw_adv_analytics_forecast" AS 
(
   SELECT
     dt_anomes
   , "sum"(vr_pago) sum_vr_pago
   , 'REALIZADO' status
   FROM
     "dep-puc"."ft_despesa"
   GROUP BY dt_anomes
UNION ALL    SELECT
     dt_anomes
   , sum_vr_pago
   , 'FORECAST' status
   FROM
     "dep-puc"."tb_prediction_mean"
) 

-- ----------------------------------------------------------------------------

CREATE OR REPLACE VIEW "vw_adv_analytics_anomaly_detection" AS (
    SELECT dw.*, ad.anomaly FROM "dep-puc"."vw_dw" as dw JOIN "dep-puc"."tb_anomaly_detection" as ad ON dw.id = ad.id
)

CREATE OR REPLACE VIEW "vw_adv_analytics_anomaly_detection_metrics" AS (
    SELECT
        anomaly,
        MIN(vr_empenhado) as min_vr_empenhado, MAX(vr_empenhado) as max_vr_empenhado, AVG(vr_empenhado) avg_vr_empenhado,
        MIN(vr_liquidado) as min_vr_liquidado, MAX(vr_liquidado) as max_vr_liquidado, AVG(vr_liquidado) avg_vr_liquidado,
        MIN(vr_pago) as min_vr_pago, MAX(vr_pago) as max_vr_pago, AVG(vr_pago) avg_vr_pago
            
        FROM "dep-puc"."vw_dw" as dw
        JOIN "dep-puc"."tb_anomaly_detection" as ad
        ON dw.id = ad.id
        GROUP BY anomaly
)

CREATE OR REPLACE VIEW "vw_adv_analytics_anomaly_detection_agents" AS (
    SELECT unidade_orc_nome, favorecido_nome_anonimizado, vr_empenhado, vr_liquidado, vr_pago, ad.anomaly
    FROM "dep-puc"."vw_dw" as dw JOIN "dep-puc"."tb_anomaly_detection" as ad ON dw.id = ad.id WHERE ad.anomaly = 'False'
)