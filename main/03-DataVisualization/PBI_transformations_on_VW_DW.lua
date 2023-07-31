let
    Source = AmazonAthena.Databases("PBIDSN2", null),
    AwsDataCatalog_Database = Source{[Name="AwsDataCatalog",Kind="Database"]}[Data],
    #"dep-puc_Schema" = AwsDataCatalog_Database{[Name="dep-puc",Kind="Schema"]}[Data],
    vw_dw_Table = #"dep-puc_Schema"{[Name="vw_dw",Kind="Table"]}[Data],

    #"[Added Conditional Column] vr_pago_2021" = Table.AddColumn(vw_dw_Table, "vr_pago_2021", each if [ano] = 2021 then [vr_pago] else 0),
    #"[Added Conditional Column] vr_pago_2022" = Table.AddColumn(#"[Added Conditional Column] vr_pago_2021", "vr_pago_2022", each if [ano] = 2022 then [vr_pago] else 0),

    #"[Added Conditional Column] vr_empenhado_2021" = Table.AddColumn(#"[Added Conditional Column] vr_pago_2022", "vr_empenhado_2021", each if [ano] = 2021 then [vr_empenhado] else 0),
    #"[Added Conditional Column] vr_empenhado_2022" = Table.AddColumn(#"[Added Conditional Column] vr_empenhado_2021", "vr_empenhado_2022", each if [ano] = 2022 then [vr_empenhado] else 0),

    #"[Added Conditional Column] vr_liquidado_2021" = Table.AddColumn(#"[Added Conditional Column] vr_empenhado_2022", "vr_liquidado_2021", each if [ano] = 2021 then [vr_liquidado] else 0),
    #"[Added Conditional Column] vr_liquidado_2022" = Table.AddColumn(#"[Added Conditional Column] vr_liquidado_2021", "vr_liquidado_2022", each if [ano] = 2022 then [vr_liquidado] else 0),

    #"Changed Type" = Table.TransformColumnTypes(#"[Added Conditional Column] vr_liquidado_2022",{
        {"vr_pago_2021", type number}, {"vr_pago_2022", type number},
        {"vr_empenhado_2021", type number}, {"vr_empenhado_2022", type number},
        {"vr_liquidado_2021", type number}, {"vr_liquidado_2022", type number}
    })
in
    #"Changed Type"