CREATE TABLE ft_despesa AS (
    SELECT * FROM "ft_despesa_2002_csv" UNION ALL
    SELECT * FROM "ft_despesa_2003_csv" UNION ALL
    SELECT * FROM "ft_despesa_2004_csv" UNION ALL
    SELECT * FROM "ft_despesa_2005_csv" UNION ALL
    SELECT * FROM "ft_despesa_2006_csv" UNION ALL
    SELECT * FROM "ft_despesa_2007_csv" UNION ALL
    SELECT * FROM "ft_despesa_2008_csv" UNION ALL
    SELECT * FROM "ft_despesa_2009_csv" UNION ALL
    SELECT * FROM "ft_despesa_2010_csv" UNION ALL
    SELECT * FROM "ft_despesa_2011_csv" UNION ALL
    SELECT * FROM "ft_despesa_2012_csv" UNION ALL
    SELECT * FROM "ft_despesa_2013_csv" UNION ALL
    SELECT * FROM "ft_despesa_2014_csv" UNION ALL
    SELECT * FROM "ft_despesa_2015_csv" UNION ALL
    SELECT * FROM "ft_despesa_2016_csv" UNION ALL
    SELECT * FROM "ft_despesa_2017_csv" UNION ALL
    SELECT * FROM "ft_despesa_2018_csv" UNION ALL
    SELECT * FROM "ft_despesa_2019_csv" UNION ALL
    SELECT * FROM "ft_despesa_2020_csv" UNION ALL
    SELECT * FROM "ft_despesa_2021_csv" UNION ALL
    SELECT * FROM "ft_despesa_2022_csv" UNION ALL
    SELECT * FROM "ft_despesa_2023_csv" 
)
-- ----------------------------------------------------------------------------

CREATE TABLE ft_despesa_last24m AS (
    WITH T AS (
        SELECT * FROM "ft_despesa_2021_csv" UNION ALL
        SELECT * FROM "ft_despesa_2022_csv" 
    )
    SELECT
        CONCAT(
          CAST(id_tempo as varchar), '-', 
          CAST(id_categ_econ as varchar), '-', 
          CAST(id_grupo as varchar), '-', 
          CAST(id_elemento as varchar), '-', 
          CAST(id_item as varchar), '-', 
          CAST(id_fonte as varchar), '-', 
          CAST(id_modalidade_aplic as varchar), '-', 
          CAST(id_funcao as varchar), '-', 
          CAST(id_subfuncao as varchar), '-', 
          CAST(id_programa as varchar), '-', 
          CAST(id_acao as varchar), '-', 
          CAST(id_procedencia as varchar), '-', 
          CAST(id_unidade_orc as varchar), '-', 
          CAST(id_favorecido as varchar), '-', 
          CAST(id_empenho as varchar), '-', 
          CAST(id_tipo_documento as varchar), '-', 
          CAST(tp_operacao as varchar), '-', 
          CAST(cd_documento as varchar), '-', 
          CAST(cd_evento as varchar), '-', 
          CAST(dt_anomes as varchar), '-', 
          CAST(ano_particao as varchar)
        ) as ID,
        *
        from
        T
)

-- ----------------------------------------------------------------------------
-- CREATE TABLE ft_despesa_last24m AS (
--     SELECT * FROM "ft_despesa_2021_csv" UNION ALL
--     SELECT * FROM "ft_despesa_2022_csv" 
-- )