select t.pk_verifydetail 核销明细表主键,saleout_b.cgeneralbid 出库单主键, orgs.name 公司, substr(t.busidate,1,10) 处理日期 ,h.billno 应收单号,t.billno2 收款单号,bd_balatype.name 结算方式,t.scomment 摘要,t.busiflag 处理标志,t.redflag 红冲标志,sfst.name 是否售桶,       
       costorg.name 成本域,case costorg.name when '保龄宝生物股份有限公司本部' then '自产' when '国际业务部成本域' then 'OEM' when '三库同建成本域' then 'OEM' end  是否OEM,so_org.name 销售组织,cust_class.name 客户基本分类,cust.code 客户编码,cust.name 客户名称,
       pd.prodcode 物料编码,pd.prodname 物料名称,pd.spec 规格型号,pd.prodclass_y 产品类型,pd.prodname_y 产品名称,
       case  when b.money_de <> b.notax_de then 0 when b.money_de = b.notax_de then  pd.exp_tax end 不予免征税率,
       saleorder_b.packing_cost 包装成本,saleorder_b.pallet_cost 托盘成本,
       b.local_money_de 借方本币金额,
       case  when invoice_b.cunitid = '0001Z0100000000000XI' or invoice_b.cunitid = '1001B3100000000D26QT' then b.quantity_de / 1000 
       when invoice_b.cunitid = '0001Z0100000000000XK'  then  b.quantity_de   else      0
       end        借方数量,
       t.local_money_de 借方处理本币金额, 
       case  when invoice_b.cunitid = '0001Z0100000000000XI' or invoice_b.cunitid = '1001B3100000000D26QT' then t.quantity_de / 1000 
       when invoice_b.cunitid = '0001Z0100000000000XK'  then  t.quantity_de   else      0
       end 借方处理数量,
       case  when saleorder_b.cunitid = '0001Z0100000000000XI' or saleorder_b.cunitid = '1001B3100000000D26QT' then decode(saleorder_b.vbdef17,'~',0,saleorder_b.vbdef17) * 1000 
       when saleorder_b.cunitid = '0001Z0100000000000XK'  then  decode(saleorder_b.vbdef17,'~',0,saleorder_b.vbdef17)   else      0
       end  主本币含税采购单价,
       b.rate 汇率,
       saleorder_b.vbdef18 海运费原币金额,
       saleorder_b.vbdef19 港杂空运本币吨运费,
       decode(h.src_syscode,0,'应收系统',3,'销售系统',16,'内部交易',19,'库存系统',h.src_syscode) 单据来源系统
from arap_verifydetail t --核销明细表
left join org_orgs orgs on t.pk_org = orgs.pk_org --财务组织
left join ar_recbill h on t.pk_bill = h.pk_recbill --应收单主表
left join ar_recitem b on t.pk_item = b.pk_recitem --应收单子表
left join ar_gatheritem ar_gatheritem on t.pk_item2 = ar_gatheritem.pk_gatheritem --收款单行
left join bd_balatype bd_balatype on ar_gatheritem.pk_balatype = bd_balatype.pk_balatype --结算方式
left join bd_material m on t.material= m.pk_material --物料
left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --物料基本分类
left join bd_customer cust on t.customer = cust.pk_customer --客户
left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --客户基本分类
left join org_orgs so_org on b.so_org = so_org.pk_org --销售组织
left join fr_product_details pd on m.code = pd.prodcode --产品成本信息明细
left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --销售发票待结算明细
left join so_squareinv_b so_squareinv_b on djs.csalesquarebid = so_squareinv_b.csalesquarebid --销售发票待结算单子实体
left join org_orgs costorg on so_squareinv_b.ccostorgid = costorg.pk_org --成本域
left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --销售发票子表
left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --销售出库单子表
left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --销售出库单表头
left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --是否售桶自定义项
left join so_delivery_b so_delivery_b on saleout_b.csourcebillbid = so_delivery_b.cdeliverybid --发货单子表
left join so_saleorder_b saleorder_b on so_delivery_b.csrcbid = saleorder_b.csaleorderbid --销售订单子表
where substr(t.busidate,1,10)>='${sdate}' and substr(t.busidate,1,10)<='${edate}' and t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
      and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--来源于销售系统
      and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
      and orgs.name = '保龄宝生物股份有限公司本部'
      and saleorder_b.dr=0
      
union all
select t.pk_verifydetail 核销明细表主键,saleout_b.cgeneralbid 出库单主键, orgs.name 公司, substr(t.busidate,1,10) 处理日期 ,h.billno 应收单号,t.billno2 收款单号,bd_balatype.name 结算方式,t.scomment 摘要,t.busiflag 处理标志,t.redflag 红冲标志,sfst.name 是否售桶,       
       costorg.name 成本域,case costorg.name when '保龄宝生物股份有限公司本部' then '自产' when '国际业务部成本域' then 'OEM' when '三库同建成本域' then 'OEM' end  是否OEM,so_org.name 销售组织,cust_class.name 客户基本分类,cust.code 客户编码,cust.name 客户名称,
       pd.prodcode 物料编码,pd.prodname 物料名称,pd.spec 规格型号,pd.prodclass_y 产品类型,pd.prodname_y 产品名称,
       case  when b.money_de <> b.notax_de then 0 when b.money_de = b.notax_de then  pd.exp_tax end 不予免征税率,
       saleorder_b.packing_cost 包装成本,saleorder_b.pallet_cost 托盘成本,
       b.local_money_de 借方本币金额,
       case  when invoice_b.cunitid = '0001Z0100000000000XI' or invoice_b.cunitid = '1001B3100000000D26QT' then b.quantity_de / 1000 
       when invoice_b.cunitid = '0001Z0100000000000XK'  then  b.quantity_de   else      0
       end        借方数量,
       t.local_money_de 借方处理本币金额, 
       case  when invoice_b.cunitid = '0001Z0100000000000XI' or invoice_b.cunitid = '1001B3100000000D26QT' then t.quantity_de / 1000 
       when invoice_b.cunitid = '0001Z0100000000000XK'  then  t.quantity_de   else      0
       end 借方处理数量,
       case  when saleorder_b.cunitid = '0001Z0100000000000XI' or saleorder_b.cunitid = '1001B3100000000D26QT' then decode(saleorder_b.vbdef17,'~',0,saleorder_b.vbdef17) * 1000 
       when saleorder_b.cunitid = '0001Z0100000000000XK'  then  decode(saleorder_b.vbdef17,'~',0,saleorder_b.vbdef17)  else      0
       end  主本币含税采购单价,
       b.rate 汇率,
       saleorder_b.vbdef18 海运费原币金额,
       saleorder_b.vbdef19 港杂空运本币吨运费,
       decode(h.src_syscode,0,'应收系统',3,'销售系统',16,'内部交易',19,'库存系统',h.src_syscode) 单据来源系统
from arap_verifydetail t --核销明细表
left join org_orgs orgs on t.pk_org = orgs.pk_org --财务组织
left join ar_recbill h on t.pk_bill = h.pk_recbill --应收单主表
left join ar_recitem b on t.pk_item = b.pk_recitem --应收单子表
left join ar_gatheritem ar_gatheritem on t.pk_item2 = ar_gatheritem.pk_gatheritem --收款单行
left join bd_balatype bd_balatype on ar_gatheritem.pk_balatype = bd_balatype.pk_balatype --结算方式
left join bd_material m on t.material= m.pk_material --物料
left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --物料基本分类
left join bd_customer cust on t.customer = cust.pk_customer --客户
left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --客户基本分类
left join org_orgs so_org on b.so_org = so_org.pk_org --销售组织
left join fr_product_details pd on m.code = pd.prodcode --产品成本信息明细
left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --销售发票待结算明细
left join so_squareinv_b so_squareinv_b on djs.csalesquarebid = so_squareinv_b.csalesquarebid --销售发票待结算单子实体
left join org_orgs costorg on so_squareinv_b.ccostorgid = costorg.pk_org --成本域
left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --销售发票子表
left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --销售出库单子表
left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --销售出库单表头
left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --是否售桶自定义项
--left join so_delivery_b so_delivery_b on saleout_b.csourcebillbid = so_delivery_b.cdeliverybid 
left join so_saleorder_b saleorder_b on saleout_b.csourcebillbid = saleorder_b.csaleorderbid --销售订单子表
where substr(t.busidate,1,10)>='${sdate}' and substr(t.busidate,1,10)<='${edate}' and t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
      and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--来源于销售系统
      and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
      and orgs.name = '保龄宝生物股份有限公司本部'
      and saleorder_b.dr=0
      