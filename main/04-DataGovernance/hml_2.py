import os
def _count_generator(reader):
    b = reader(1024 * 1024)
    while b:
        yield b
        b = reader(1024 * 1024)

files = os.listdir('.')

for f in files:
    with open(f, 'rb') as fp:
        c_generator = _count_generator(fp.raw.read)
        # count each \n
        count = sum(buffer.count(b'\n') for buffer in c_generator)
        print(f, 'Total lines:', count - 1)


# SELECT count(*) as c, 'dm_categ_econ_csv' as table_name FROM "dep-puc"."dm_categ_econ_csv"
# UNION ALL
# SELECT count(*) as c, 'dm_empenho_desp_2019_csv' as table_name FROM "dep-puc"."dm_empenho_desp_2019_csv"
# UNION ALL
# SELECT count(*) as c, 'dm_fonte_csv' as table_name FROM "dep-puc"."dm_fonte_csv"
# UNION ALL
# SELECT count(*) as c, 'dm_procedencia_csv' as table_name FROM "dep-puc"."dm_procedencia_csv"
# UNION ALL
# SELECT count(*) as c, 'dm_tempo_diario_csv' as table_name FROM "dep-puc"."dm_tempo_diario_csv"
# UNION ALL
# SELECT count(*) as c, 'dm_unidade_orc_csv' as table_name FROM "dep-puc"."dm_unidade_orc_csv"
# UNION ALL
# SELECT count(*) as c, 'ft_despesa_200_' as table_name FROM "dep-puc"."ft_despesa_2009_csv"
