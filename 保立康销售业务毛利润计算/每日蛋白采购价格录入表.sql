select * from FR_BLK_protein_PURCHAse_PRICE;

drop table FR_BLK_protein_PURCHAse_PRICE;
create table FR_BLK_protein_PURCHAse_PRICE
(
  idate                VARCHAR2(10) not null,
  proteinpower_price   NUMBER(9,4),
  liquid_protein_price NUMBER(9,4)
)
tablespace NNC_DATA01
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );