/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/5/31 19:55:08                           */
/*==============================================================*/


drop table if exists Users;

drop table if exists address;

drop table if exists catalog_catentry_rel;

drop table if exists catalog_types;

drop table if exists catalogs;

drop table if exists catalogs_rel;

drop table if exists catentry;

drop table if exists catentry_types;

drop table if exists catentrys_rel;

drop table if exists inventory;

drop table if exists order_items;

drop table if exists orders;

drop table if exists orders_history;

drop table if exists ship;

drop table if exists stores;

drop table if exists supplement;

drop table if exists xcatentry;

/*==============================================================*/
/* Table: Users                                                 */
/*==============================================================*/
create table Users
(
   openid               varchar(10) not null,
   nickname             varchar(10) not null,
   gender               int(1),
   province             varchar(10),
   city                 varchar(10),
   country              varchar(5),
   headimgurl           varchar(20),
   privilege            varchar(20),
   unionid              varchar(20),
   user_id              integer not null,
   primary key (user_id)
);

alter table Users comment 'user information
';

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   user_id              integer,
   address_id           integer not null,
   order_id             integer,
   address_type         varchar(2),
   client_name          varchar(5),
   last_name            varchar(5),
   title                varchar(3),
   telephone            varchar(11),
   email                varchar(11),
   country              varchar(5),
   province             varchar(5),
   address1             varchar(15),
   address2             varchar(15),
   zipcode              varchar(8),
   primary key (address_id)
);

/*==============================================================*/
/* Table: catalog_catentry_rel                                  */
/*==============================================================*/
create table catalog_catentry_rel
(
   catalog_catentry_rel_id integer not null,
   catentry_id          integer,
   catalog_id           integer,
   primary key (catalog_catentry_rel_id)
);

/*==============================================================*/
/* Table: catalog_types                                         */
/*==============================================================*/
create table catalog_types
(
   catalog_type_id      integer not null,
   catalog_type_name    varchar(10),
   description          varchar(10),
   field1               varchar(5),
   field2               varchar(5),
   field3               varchar(5),
   field4               varchar(5),
   start_time           datetime,
   end_time             datetime,
   primary key (catalog_type_id)
);

/*==============================================================*/
/* Table: catalogs                                              */
/*==============================================================*/
create table catalogs
(
   catalog_id           integer not null,
   store_id             integer not null,
   catalog_type_id      integer,
   node_name            varchar(10) not null,
   description          varchar(20),
   is_available         boolean not null,
   start_time           datetime,
   end_time             datetime,
   primary key (catalog_id)
);

/*==============================================================*/
/* Table: catalogs_rel                                          */
/*==============================================================*/
create table catalogs_rel
(
   catalog_rel_id       integer not null,
   catalog_id_parent    integer,
   catalog_id_child     integer,
   primary key (catalog_rel_id)
);

alter table catalogs_rel comment 'table for catalogs relavition';

/*==============================================================*/
/* Table: catentry                                              */
/*==============================================================*/
create table catentry
(
   catentry_id          integer not null,
   catentry_type_id     integer,
   inventory_id         integer,
   store_id             integer,
   catentry_name        varchar(20),
   node_name            varchar(10),
   description          varchar(50),
   is_public            boolean,
   is_deleted           boolean,
   partnumber           varchar(20),
   start_date           datetime,
   end_date             datetime,
   price                integer,
   primary key (catentry_id)
);

alter table catentry comment 'the table for items such as products, article or promotion';

/*==============================================================*/
/* Table: catentry_types                                        */
/*==============================================================*/
create table catentry_types
(
   catentry_type_id     integer not null,
   catentry_type_name   varchar(10),
   field1               varchar(10),
   field2               varchar(10),
   field3               varchar(10),
   field4               varchar(10),
   start_date           datetime,
   end_date             datetime,
   description          varchar(10),
   primary key (catentry_type_id)
);

/*==============================================================*/
/* Table: catentrys_rel                                         */
/*==============================================================*/
create table catentrys_rel
(
   catentry_id          integer,
   catentry_parent_id   integer,
   catentry_child_id    integer
);

/*==============================================================*/
/* Table: inventory                                             */
/*==============================================================*/
create table inventory
(
   inventory_id         integer not null,
   store_id             integer,
   quantity             integer,
   primary key (inventory_id)
);

/*==============================================================*/
/* Table: order_items                                           */
/*==============================================================*/
create table order_items
(
   order_item_id        integer not null,
   order_id             integer,
   catentry_id          integer,
   price                integer,
   primary key (order_item_id)
);

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   user_id              integer,
   order_id             integer not null,
   address_id           integer,
   ship_id              integer,
   total_price          integer,
   order_status         char(1),
   currency             varchar(4),
   primary key (order_id)
);

/*==============================================================*/
/* Table: orders_history                                        */
/*==============================================================*/
create table orders_history
(
   orders_history_id    integer not null,
   user_id              integer,
   order_id             integer,
   order_status         varchar(1),
   primary key (orders_history_id)
);

/*==============================================================*/
/* Table: ship                                                  */
/*==============================================================*/
create table ship
(
   ship_id              integer not null,
   catentry_id          integer,
   ship_mode            varchar(5),
   ship_name            varchar(5),
   primary key (ship_id)
);

/*==============================================================*/
/* Table: stores                                                */
/*==============================================================*/
create table stores
(
   store_id             integer not null,
   store_name           varchar(20),
   description          varchar(20),
   currency             varchar(5),
   lang                 varchar(2),
   country              varchar(3),
   primary key (store_id)
);

/*==============================================================*/
/* Table: supplement                                            */
/*==============================================================*/
create table supplement
(
   user_id              integer,
   catentry_id          integer,
   supplement_id        integer not null,
   total_count          integer,
   primary key (supplement_id)
);

alter table supplement comment 'supplement skus record';

/*==============================================================*/
/* Table: xcatentry                                             */
/*==============================================================*/
create table xcatentry
(
   xcatentry_id         integer not null,
   catentry_id          integer,
   unit                 varchar(2),
   volumn               integer,
   primary key (xcatentry_id)
);

alter table address add constraint FK_address_order foreign key (order_id)
      references orders (order_id) on delete restrict on update restrict;

alter table address add constraint FK_address_user foreign key (user_id)
      references Users (user_id) on delete restrict on update restrict;

alter table catalog_catentry_rel add constraint FK_catalog_catent_rel_catentry foreign key (catentry_id)
      references catentry (catentry_id) on delete restrict on update restrict;

alter table catalog_catentry_rel add constraint FK_catalog_catentry_catalog_rel foreign key (catalog_id)
      references catalogs (catalog_id) on delete restrict on update restrict;

alter table catalogs add constraint FK_catalog_catattype foreign key (catalog_type_id)
      references catalog_types (catalog_type_id) on delete restrict on update restrict;

alter table catalogs add constraint FK_catalog_store foreign key (store_id)
      references stores (store_id) on delete restrict on update restrict;

alter table catalogs_rel add constraint FK_catalog_child foreign key (catalog_id_child)
      references catalogs (catalog_id) on delete restrict on update restrict;

alter table catalogs_rel add constraint FK_catalog_parent foreign key (catalog_id_parent)
      references catalogs (catalog_id) on delete restrict on update restrict;

alter table catentry add constraint FK_catentry_catenttype foreign key (catentry_type_id)
      references catentry_types (catentry_type_id) on delete restrict on update restrict;

alter table catentry add constraint FK_catentry_inventory foreign key (inventory_id)
      references inventory (inventory_id) on delete restrict on update restrict;

alter table catentry add constraint FK_catentry_store foreign key (store_id)
      references stores (store_id) on delete restrict on update restrict;

alter table catentrys_rel add constraint FK_catentry_child foreign key (catentry_parent_id)
      references catentry (catentry_id) on delete restrict on update restrict;

alter table catentrys_rel add constraint FK_catentry_parent foreign key (catentry_id)
      references catentry (catentry_id) on delete restrict on update restrict;

alter table inventory add constraint FK_inventory_store foreign key (store_id)
      references stores (store_id) on delete restrict on update restrict;

alter table order_items add constraint FK_orderitem_catentry foreign key (catentry_id)
      references catentry (catentry_id) on delete restrict on update restrict;

alter table order_items add constraint FK_orderitem_order foreign key (order_id)
      references orders (order_id) on delete restrict on update restrict;

alter table orders add constraint FK_order_address foreign key (address_id)
      references address (address_id) on delete restrict on update restrict;

alter table orders add constraint FK_order_ship foreign key (ship_id)
      references ship (ship_id) on delete restrict on update restrict;

alter table orders add constraint FK_order_user foreign key (user_id)
      references Users (user_id) on delete restrict on update restrict;

alter table orders_history add constraint FK_order_history_users foreign key (user_id)
      references Users (user_id) on delete restrict on update restrict;

alter table orders_history add constraint FK_orders_history_orders foreign key (order_id)
      references orders (order_id) on delete restrict on update restrict;

alter table ship add constraint FK_ship_catentry foreign key (catentry_id)
      references catentry (catentry_id) on delete restrict on update restrict;

alter table supplement add constraint FK_supplement_catentry foreign key (catentry_id)
      references catentry (catentry_id) on delete restrict on update restrict;

alter table supplement add constraint FK_supplement_users foreign key (user_id)
      references Users (user_id) on delete restrict on update restrict;

alter table xcatentry add constraint FK_xcatentry_catentry foreign key (catentry_id)
      references catentry (catentry_id) on delete restrict on update restrict;

