--建立类型表
create table _Type(
ISBN smallint primary key,
_type nchar(3) not null)

insert into _Type values(1,'轻小说')
insert into _Type values(2,'漫画')
insert into _Type values(3,'番剧')

--建立路径表
create table _URL(
ISBN smallint primary key,
WebName nvarchar(10) not null)

insert into _URL values(1,'B站/B漫')
insert into _URL values(2,'Acfun')
insert into _URL values(3,'樱花漫画')
insert into _URL values(4,'轻之国度')

--建立简介表
create table Intro(
ISBN int primary key,
author nvarchar not null,
StoryIntro text not null)

--建立用户表
create table _User(
_UID bigint primary key,
UserName nvarchar(30) not null,
Email nvarchar(30) 
constraint CK_Email check (Email like('%@')),
_password nvarchar(18) not null)

--建立番剧表
create table Cartoon(
ISBN bigint primary key,
_type smallint constraint FK_CT_TYPE 
foreign key(_type) references _Type(ISBN),
CartoonName nvarchar(30) not null,
intro int constraint FK_CT_INTRO
foreign key(intro) references Intro(ISBN),
_url smallint constraint FK_CT_URL
foreign key(_url) references _URL(ISBN),
contributor bigint not null constraint FK_CT_UP
foreign key(contributor) references _User(_UID))

--建立漫画表
create table Comic(
ISBN bigint primary key,
_type smallint constraint FK_C_TYPE 
foreign key(_type) references _Type(ISBN),
comicName nvarchar(30) not null,
intro int constraint FK_C_INTRO
foreign key(intro) references Intro(ISBN),
_url smallint constraint FK_C_URL
foreign key(_url) references _URL(ISBN),
contributor bigint not null constraint FK_C_UP
foreign key(contributor) references _User(_UID),
ComicToCartoon bigint constraint FK_C_CTCT
foreign key(ComicToCartoon) references Cartoon(ISBN))

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
