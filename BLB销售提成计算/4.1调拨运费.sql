SELECT '直销食品配料华南区' 销售部门,prod.prodname_y 产品名称,prod.prodclass_y 产品类别,m.code 物料编码,m.name 物料名称,m.materialspec 规格,to_number(b.vbdef17) 运费金额,
       b.cdelivbill_bid cdelivbill_bid,
       substr(h.dbilldate, 1, 10) dbilldate
  FROM dm_delivbill h
 INNER JOIN dm_delivbill_b b    ON h.cdelivbill_hid = b.cdelivbill_hid
  LEFT JOIN bd_billtype meta    ON b.vsrctype = meta.pk_billtypeid
  LEFT JOIN bd_stordoc stordoc    ON b.creceivestoreid = stordoc.pk_stordoc
  left join bd_material m on b.cinventoryid=m.pk_material
  left join fr_product_details prod on m.code=prod.prodcode
  left join bd_customer cust on b.casscustid = cust.pk_customer
 WHERE h.dr = 0
   AND b.dr = 0
   AND meta.billtypename = '库存调拨出库单'
   AND stordoc.name = '华南办事处仓库'
   and substr(h.dbilldate,1,10)>='${sdate}' and substr(h.dbilldate,1,10)<='${edate}'
union
SELECT '直销食品配料华北区' 销售部门,prod.prodname_y 产品名称,prod.prodclass_y 产品类别,m.code 物料编码,m.name 物料名称,m.materialspec 规格,to_number(b.vbdef17) 运费金额,
       b.cdelivbill_bid cdelivbill_bid,
       substr(h.dbilldate, 1, 10) dbilldate
  FROM dm_delivbill h
 INNER JOIN dm_delivbill_b b    ON h.cdelivbill_hid = b.cdelivbill_hid
  LEFT JOIN bd_billtype meta    ON b.vsrctype = meta.pk_billtypeid
  LEFT JOIN bd_stordoc stordoc    ON b.creceivestoreid = stordoc.pk_stordoc
  left join bd_material m on b.cinventoryid=m.pk_material
  left join fr_product_details prod on m.code=prod.prodcode
  left join bd_customer cust on b.casscustid = cust.pk_customer
 WHERE h.dr = 0
   AND b.dr = 0
   AND meta.billtypename = '库存调拨出库单'
   AND stordoc.name = '东北办事处仓库'
   and substr(h.dbilldate,1,10)>='${sdate}' and substr(h.dbilldate,1,10)<='${edate}'
