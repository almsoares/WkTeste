/*==============================================================*/
/* Created on:     13/06/2022 10:09:37                          */
/*==============================================================*/
/*
drop index ix_tbcliente_001 on tbcliente;
drop table if exists tbcliente;
drop table if exists tbpedido;
drop index ixpedidoproduto001 on tbpedidoproduto;
drop table if exists tbpedidoproduto;
drop index ix_tbproduto_001 on tbproduto;
drop table if exists tbproduto;
drop view vwpedido;
drop view vwpedidoproduto;
*/

create database wkteste;

use wkteste;

/*==============================================================*/
/* Table: tbcliente                                             */
/*==============================================================*/
create table tbcliente
(
   clienteid            integer not null,
   nome                 varchar(60) not null,
   cidade               varchar(60) not null,
   uf                   varchar(2) not null,
   primary key (clienteid)
);

/*==============================================================*/
/* Index: ix_tbcliente_001                                      */
/*==============================================================*/
create index ix_tbcliente_001 on tbcliente
(
   nome
);

/*==============================================================*/
/* Table: tbpedido                                              */
/*==============================================================*/
create table tbpedido
(
   numeropedido         integer not null,
   clienteid            integer,
   dataemissao          date not null,
   valor                numeric(15,2) not null,
   primary key (numeropedido)
);

/*==============================================================*/
/* Table: tbpedidoproduto                                       */
/*==============================================================*/
create table tbpedidoproduto
(
   pedidoprodutoid      integer not null auto_increment,
   numeropedido         integer not null,
   produtoid            integer not null,
   quantidade           numeric(15,2) not null,
   valorunitario        numeric(15,2) not null,
   valortotal           numeric(15,2) not null,
   primary key (pedidoprodutoid)
);

/*==============================================================*/
/* Index: ixpedidoproduto001                                    */
/*==============================================================*/
create index ixpedidoproduto001 on tbpedidoproduto
(
   numeropedido,
   pedidoprodutoid
);

/*==============================================================*/
/* Table: tbproduto                                             */
/*==============================================================*/
create table tbproduto
(
   produtoid            integer not null,
   descricao            varchar(60) not null,
   prcvenda             numeric(15,2) not null,
   primary key (produtoid)
);

/*==============================================================*/
/* Index: ix_tbproduto_001                                      */
/*==============================================================*/
create index ix_tbproduto_001 on tbproduto
(
   descricao
);

/*==============================================================*/
/* View: vwpedido                                               */
/*==============================================================*/
create or replace view vwpedido as
select numeropedido, tbcliente.clienteid, tbcliente.nome, dataemissao, valor, cidade, uf
from tbpedido 
  inner join tbcliente on tbpedido.clienteid = tbcliente.clienteid;
  
/*==============================================================*/
/* View: vwpedidoproduto                                        */
/*==============================================================*/
create or replace view vwpedidoproduto as
select numeropedido, pedidoprodutoid, tbproduto.produtoid, descricao, quantidade, valorunitario, valortotal
from tbpedidoproduto
inner join tbproduto on tbproduto.produtoid = tbpedidoproduto.produtoid;


alter table tbpedido add constraint fkpedido001 foreign key (clienteid)
      references tbcliente (clienteid) on delete restrict on update restrict;

alter table tbpedidoproduto add constraint fkpedidoproduto001 foreign key (numeropedido)
      references tbpedido (numeropedido) on delete restrict on update restrict;

alter table tbpedidoproduto add constraint fkpedidoproduto002 foreign key (produtoid)
      references tbproduto (produtoid) on delete restrict on update restrict;

