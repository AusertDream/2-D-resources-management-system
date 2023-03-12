/*删库跑路神器
drop table Novel
drop table Comic
drop table Cartoon
drop table _Type_
drop table Intro
drop table _User 
drop table _URL
*/

--建立路径表
create table _URL(
ISBN bigint primary key,
bilibili nvarchar(50),
Acfun nvarchar(50),
YinHua nvarchar(50),
Light_country nvarchar(50))
--插一个空的链接，让那些没有改编的东西 &
insert into _URL values(0,' ',' ',' ',' ')


--建立简介表
create table Intro(
ISBN bigint primary key,
author nvarchar(30) not null,
StoryIntro text not null)
--开一个空简历表，让那些没有改编的东西 &
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
_type char(2) primary key constraint CK_CT_TYPE 
check(_type='CT'), 
CartoonName nvarchar(30) not null,
intro bigint constraint FK_CT_INTRO
foreign key(intro) references Intro(ISBN),
_url bigint constraint FK_CT_URL
foreign key(_url) references _URL(ISBN),
contributor bigint constraint FK_CT_UP
foreign key(contributor) references _User(_UID))
--空番剧，指小说或漫画没有番剧
insert into Cartoon(ISBN,_type,CartoonName,intro,_url,contributor)
values(null,'CT','未有番剧改编',0,0,null)

--建立漫画表
create table Comic(
ISBN bigint unique,
_type char(2) primary key constraint CK_C_TYPE 
check(_type='C'), 
comicName nvarchar(30) not null,
intro bigint constraint FK_C_INTRO
foreign key(intro) references Intro(ISBN),
_url bigint constraint FK_C_URL
foreign key(_url) references _URL(ISBN),
contributor bigint constraint FK_C_UP
foreign key(contributor) references _User(_UID),
ComicToCartoon bigint constraint FK_C_CTCT
foreign key(ComicToCartoon) references Cartoon(ISBN))
--空漫画，指小说没有番剧
insert into Comic(ISBN,_type,comicName,intro,_url,contributor,ComicToCartoon)
values(null,'C','未有漫画改编',0,0,null,null)

--建立小说表
create table Novel(
ISBN bigint,
_type char(2) constraint CK_N_TYPE 
check(_type='N'), 
comicName nvarchar(30) not null,
intro bigint constraint FK_N_INTRO
foreign key(intro) references Intro(ISBN),
_url bigint constraint FK_N_URL
foreign key(_url) references _URL(ISBN),
contributor bigint not null constraint FK_N_UP
foreign key(contributor) references _User(_UID),
NovelToCartoon bigint constraint FK_N_NTCT
foreign key(NovelToCartoon) references Cartoon(ISBN),
NovelToComic bigint constraint FK_N_NTC
foreign key(NovelToComic) references Comic(ISBN),
primary key(ISBN,_type))

/*查找所有的东西
select *from sysobjects where xtype='u'
select *from _Type_
select *from _URL
select *from Intro
select *from _User
select *from Cartoon
select *from Comic
select *from Novel
*/

