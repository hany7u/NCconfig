select b.cgeneralbid,so_delivery_b.nnum,b.nnum,dm_delivbill_b.vbdef17 from ic_saleout_b b --销售出库单子表
left join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid --销售出库单表头
left join org_orgs orgs on b.cfanaceorgoid = orgs.pk_org
left join so_delivery_b so_delivery_b on b.csourcebillbid = so_delivery_b.cdeliverybid--发货单
left join dm_delivbill_b dm_delivbill_b on so_delivery_b.cdeliverybid = dm_delivbill_b.csrcbid
where h.dbilldate >='2017-01-01 00:00:00' and orgs.name = '禹城保立康生物饲料有限公司本部'