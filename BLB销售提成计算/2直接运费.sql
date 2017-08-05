select b.cgeneralbid zj,b.nnum cksl,dm_b.nnum yssl,dm_b.vbdef17 yfje,round(case when b.nnum<dm_b.nnum then dm_b.vbdef17*b.nnum/dm_b.nnum else dm_b.vbdef17*1.00 end,4) ftyfje from ic_saleout_b b
left join ic_saleout_h h on b.cgeneralhid=h.cgeneralhid
left join so_delivery_b so_d_b on b.csourcebillbid=so_d_b.cdeliverybid
left join dm_delivbill_b dm_b on so_d_b.cdeliverybid=dm_b.csrcbid
where  b.dr=0 and h.dr=0 and so_d_b.dr=0 and dm_b.dr=0 and b.nnum>0 
       and  substr(b.dbizdate, 1, 10) >= '${sdate}'
       and substr(b.dbizdate, 1, 10) <= '${edate}'
union all
select  b.cgeneralbid zj,b.nnum cksl,dm_b.nnum yssl,dm_b.vbdef17 yfje,case when b.nnum<dm_b.nnum then dm_b.vbdef17*b.nnum/dm_b.nnum else dm_b.vbdef17*1.00 end ftyfje from ic_saleout_b b
left join ic_saleout_h h on b.cgeneralhid=h.cgeneralhid
left join dm_delivbill_b dm_b on b.cgeneralbid=dm_b.csrcbid
where  b.dr=0 and h.dr=0 and dm_b.dr=0 and b.nnum>0 
       and  substr(b.dbizdate, 1, 10) >= '${sdate}'
       and substr(b.dbizdate, 1, 10) <= '${edate}'