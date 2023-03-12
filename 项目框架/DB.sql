/*删库跑路神器
drop table Novel
drop table Comic
drop table Cartoon
drop table _Type
drop table Intro
drop table _User 
drop table _URL
*/

--建立类型表
create table _Type(
ISBN smallint primary key,
_type nchar(3) not null)

insert into _Type values(1,'轻小说')
insert into _Type values(2,'漫画')
insert into _Type values(3,'番剧')
--这里还可以多插点东西，没有约束

--建立路径表
create table _URL(
ISBN smallint primary key,
bilibili nvarchar(50),
Acfun nvarchar(50),
YinHua nvarchar(50),
Light_country nvarchar(50))
--插一个空的链接，懂吧
insert into _URL values(0,' ',' ',' ',' ')


--建立简介表
create table Intro(
ISBN int primary key,
author nvarchar(30) not null,
StoryIntro text not null)
--开一个空简历表，懂吧
insert into Intro values(0,'未知','无')

--建立用户表
create table _User(
_UID bigint unique,
UserName nvarchar(30) not null,
Email nvarchar(30) 
constraint CK_Email check (Email like('%@%')),
_password nvarchar(18) not null)
--建立空用户，能给空番剧 &
insert into _User values
(null,'Administrator','1697081049@qq.com','123456')

--建立番剧表
create table Cartoon(
ISBN bigint unique,
_type smallint constraint FK_CT_TYPE 
foreign key(_type) references _Type(ISBN),
CartoonName nvarchar(30) not null,
intro int constraint FK_CT_INTRO
foreign key(intro) references Intro(ISBN),
_url smallint constraint FK_CT_URL
foreign key(_url) references _URL(ISBN),
contributor bigint constraint FK_CT_UP
foreign key(contributor) references _User(_UID))
--空番剧，指小说或漫画没有番剧
insert into Cartoon(ISBN,_type,CartoonName,intro,_url,contributor)
values(null,3,'未有番剧改编',0,0,null)

--建立漫画表
create table Comic(
ISBN bigint unique,
_type smallint constraint FK_C_TYPE 
foreign key(_type) references _Type(ISBN),
comicName nvarchar(30) not null,
intro int constraint FK_C_INTRO
foreign key(intro) references Intro(ISBN),
_url smallint constraint FK_C_URL
foreign key(_url) references _URL(ISBN),
contributor bigint constraint FK_C_UP
foreign key(contributor) references _User(_UID),
ComicToCartoon bigint constraint FK_C_CTCT
foreign key(ComicToCartoon) references Cartoon(ISBN))
--空漫画，指小说没有番剧
insert into Comic(ISBN,_type,comicName,intro,_url,contributor,ComicToCartoon)
values(null,2,'未有漫画改编',0,0,null,null)

--建立小说表
create table Novel(
ISBN bigint primary key,
_type smallint constraint FK_N_TYPE 
foreign key(_type) references _Type(ISBN),
comicName nvarchar(30) not null,
intro int constraint FK_N_INTRO
foreign key(intro) references Intro(ISBN),
_url smallint constraint FK_N_URL
foreign key(_url) references _URL(ISBN),
contributor bigint not null constraint FK_N_UP
foreign key(contributor) references _User(_UID),
NovelToCartoon bigint constraint FK_N_NTCT
foreign key(NovelToCartoon) references Cartoon(ISBN),
NovelToComic bigint constraint FK_N_NTC
foreign key(NovelToComic) references Comic(ISBN))

/*查找所有的东西
select *from sysobjects where xtype='u'
select *from _Type
select *from _URL
select *from Intro
select *from _User
select *from Cartoon
select *from Comic
select *from Novel
*/

