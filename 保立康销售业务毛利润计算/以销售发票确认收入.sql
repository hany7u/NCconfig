select ic_saleout_b.cgeneralbid,so_saleorder.vbillcode,h.vbillcode,emp.name,orgs_stock.name,stordoc.name,m.code,m.name,m.materialspec,b.nmny 销售收入 from so_saleinvoice_b b
left join so_saleinvoice h on b.csaleinvoiceid = h.csaleinvoiceid
left join org_orgs orgs_fi on h.pk_org = orgs_fi.pk_org
left join bd_psndoc emp on b.cemployeeid = emp.pk_psndoc
left join bd_material m on b.cmaterialid = m.pk_material
left join org_orgs orgs_stock on b.csendstockorgid = orgs_stock.pk_org
left join bd_stordoc stordoc on b.csendstordocid = stordoc.pk_stordoc
left join so_saleorder_b so_saleorder_b on b.cfirstbid = so_saleorder_b.csaleorderbid
left join so_saleorder so_saleorder on so_saleorder_b.csaleorderid = so_saleorder.csaleorderid
left join ic_saleout_b ic_saleout_b on b.csrcbid = ic_saleout_b.cgeneralbid --销售出库单子表
left join ic_saleout_h ic_saleout_h on ic_saleout_b.cgeneralhid = ic_saleout_h.cgeneralhid --销售出库单表头
left join so_delivery_b so_delivery_b on ic_saleout_b.csourcebillbid = so_delivery_b.cdeliverybid
where orgs_fi.name = '禹城保立康生物饲料有限公司本部' and h.dr = 0 and b.dr = 0 and substr(h.dbilldate,1,10) >= '2017-07-01'