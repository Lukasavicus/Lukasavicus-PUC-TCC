SELECT sum(c) FROM (
    select count(*) as c from "ft_despesa_2002_csv" UNION ALL
    select count(*) as c from "ft_despesa_2003_csv" UNION ALL
    select count(*) as c from "ft_despesa_2004_csv" UNION ALL
    select count(*) as c from "ft_despesa_2005_csv" UNION ALL
    select count(*) as c from "ft_despesa_2006_csv" UNION ALL
    select count(*) as c from "ft_despesa_2007_csv" UNION ALL
    select count(*) as c from "ft_despesa_2008_csv" UNION ALL
    select count(*) as c from "ft_despesa_2009_csv" UNION ALL
    select count(*) as c from "ft_despesa_2010_csv" UNION ALL
    select count(*) as c from "ft_despesa_2011_csv" UNION ALL
    select count(*) as c from "ft_despesa_2012_csv" UNION ALL
    select count(*) as c from "ft_despesa_2013_csv" UNION ALL
    select count(*) as c from "ft_despesa_2014_csv" UNION ALL
    select count(*) as c from "ft_despesa_2015_csv" UNION ALL
    select count(*) as c from "ft_despesa_2016_csv" UNION ALL
    select count(*) as c from "ft_despesa_2017_csv" UNION ALL
    select count(*) as c from "ft_despesa_2018_csv" UNION ALL
    select count(*) as c from "ft_despesa_2019_csv" UNION ALL
    select count(*) as c from "ft_despesa_2020_csv" UNION ALL
    select count(*) as c from "ft_despesa_2021_csv" UNION ALL
    select count(*) as c from "ft_despesa_2022_csv" 
)