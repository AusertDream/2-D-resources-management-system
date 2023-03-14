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
ISBN bigint primary key identity,
_type nvarchar(3) constraint CK_TYPE
check(_type = '番剧' or _type = '漫画' or _type = '轻小说'))
--插入两空引用
insert into _Type values('番剧')
insert into _Type values('漫画')

--建立路径表
create table _URL(
ISBN bigint primary key,
bilibili nvarchar(50),
Acfun nvarchar(50),
YinHua nvarchar(50),
Light_country nvarchar(50))
--插一个空的链接，懂吧
insert into _URL(ISBN,	bilibili,	Acfun,	YinHua,	Light_country) 
values			(1,		' ',		' ',	' ',	' ')


--建立简介表
create table Intro(
ISBN bigint primary key,
author nvarchar(30) not null,
StoryIntro text not null)
--开一个空简历表，懂吧
insert into Intro(ISBN, author, StoryIntro) 
values			 (1,    '未知', '无')

--建立用户表
create table _User(
_UID bigint primary key identity,
UserName nvarchar(30) not null,
Email nvarchar(30) 
constraint CK_Email check (Email like('%@%')),
_password nvarchar(18) not null)
--建立空用户，能给空番剧 &
insert into _User(UserName,		  Email,			  _password)
values			 ('Administrator','1697081049@qq.com','123456')

--建立番剧表
create table Cartoon(
ISBN bigint primary key,
_type bigint constraint FK_CT_TYPE 
foreign key(_type) references _Type(ISBN),
CartoonName nvarchar(30) not null,
intro bigint constraint FK_CT_INTRO
foreign key(intro) references Intro(ISBN),
_url bigint constraint FK_CT_URL
foreign key(_url) references _URL(ISBN),
contributor bigint constraint FK_CT_UP
foreign key(contributor) references _User(_UID))
--空番剧，指小说或漫画没有番剧
insert into Cartoon(ISBN, _type,  CartoonName,	  intro,  _url,  contributor)
values			   (1,	  1,	  '未有番剧改编', 1,	  1,	 1)

--建立漫画表
create table Comic(
ISBN bigint primary key,
_type bigint constraint FK_C_TYPE 
foreign key(_type) references _Type(ISBN),
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
insert into Comic(ISBN,  _type,  comicName,		intro,_url,contributor,ComicToCartoon)
values			 (2,     2,		 '未有漫画改编',1,	  1,   1,			1)

--建立小说表
create table Novel(
ISBN bigint primary key,
_type bigint constraint FK_N_TYPE 
foreign key(_type) references _Type(ISBN),
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

