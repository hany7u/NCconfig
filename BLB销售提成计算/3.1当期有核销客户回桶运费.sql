SELECT distinct cust.code, sum(to_number(b.vbdef17)) over(partition by cust.code)  hzyfje,sum(to_number(b.vbdef17)) over() total_yf
FROM dm_delivbill_b b
left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
left join bd_customer cust on b.casscustid=cust.pk_customer
WHERE h.dr = 0  AND b.dr = 0  AND m.name = '塑料桶' 
	and cust.code  in (select distinct cust.code 客户编码
from arap_verifydetail t --核销明细表
left join org_orgs orgs on t.pk_org = orgs.pk_org --财务组织
left join ar_recbill h on t.pk_bill = h.pk_recbill --应收单主表
left join ar_recitem b on t.pk_item = b.pk_recitem --应收单字表
left join bd_material m on t.material= m.pk_material --物料
left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --物料基本分类
left join bd_customer cust on t.customer = cust.pk_customer --客户
left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --客户基本分类
left join org_orgs so_org on b.so_org = so_org.pk_org --销售组织
left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --销售发票待结算明细
left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --销售发票子表
left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --销售出库单子表
left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --销售出库单表头
left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --是否售桶自定义项

where substr(t.busidate,1,10)>='${sdate}' and substr(t.busidate,1,10)<='${edate}' and t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
      and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--来源于销售系统
      and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
      and orgs.name = '保龄宝生物股份有限公司本部'
      and b.dr=0)
	and substr(h.dbilldate, 1, 10)>='${sdate}' and substr(h.dbilldate, 1, 10)<='${edate}'
