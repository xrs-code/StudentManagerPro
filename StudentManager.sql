--ָ��ǰҪʹ�õ����ݿ�
use master
go
--�жϵ�ǰ���ݿ��Ƿ����
if exists (select * from sysdatabases where name='StudentManager')
drop database StudentManager--ɾ�����ݿ�
go
--�������ݿ�
create database StudentManager
on primary
(
	--���ݿ��ļ����߼���
    name='StudentManager_data',
    --���ݿ������ļ���������·����
    filename='D:\DB\StudentManager_data.mdf',
    --���ݿ��ļ���ʼ��С
    size=10MB,
    --�����ļ�������
    filegrowth=1MB
)
,
(
   name='StudentManager_data1',
	--������Ҫ�����ļ� 
    filename='D:\DB\StudentManager_data1.ndf',
    size=2MB,
    filegrowth=1MB
)
--������־�ļ�
log on
(
    name='StudentManager_log',
    filename='D:\DB\StudentManager_log.ldf',
    size=2MB,
    filegrowth=1MB
)
,
(
    name='StudentManager_log1',
    filename='D:\DB\StudentManager_log1.ldf',
    size=2MB,
    filegrowth=1MB
)
go

--����ѧԱ��Ϣ���ݱ�
use StudentManager
go
if exists (select * from sysobjects where name='Students')
drop table Students
go
create table Students
(
    StudentId int identity(100000,1) ,
    StudentName varchar(20) not null,
    Gender char(2)  not null,
    Birthday smalldatetime  not null,
    StudentIdNo numeric(18,0) not null,--����֤�� 
    PhoneNumber varchar(50),
    StudentAddress varchar(500),
    ClassId int not null  --�༶���
)
go
--�����༶��
if exists(select * from sysobjects where name='StudentClass')
drop table StudentClass
go
create table StudentClass
(
	ClassId int primary key,
   ClassName varchar(20) not null
)
go
--�����ɼ���
if exists(select * from sysobjects where name='ScoreList')
drop table ScoreList
go
create table ScoreList
(
    id int identity(1,1) primary key,
    StudentId int not null,
    CSharp int null,
    SQLServerDB int null,
    UpdateTime smalldatetime not null
)
go
--��������Ա�û���
if exists(select * from sysobjects where name='Admins')
drop table Admins
create table Admins
(
	LoginId int identity(1000,1) primary key,
    LoginPwd varchar(200) not null,
    AdminName varchar(20) not null
)
go
--�������ݱ��ĸ���Լ��
use StudentManager
go
--������������Լ��primary key
if exists(select * from sysobjects where name='pk_StudentId')
alter table Students drop constraint pk_StudentId

alter table Students
add constraint pk_StudentId primary key (StudentId)


--����ΨһԼ��unique
if exists(select * from sysobjects where name='uq_StudentIdNo')
alter table Students drop constraint uq_StudentIdNo
alter table Students
add constraint uq_StudentIdNo unique (StudentIdNo)

--��������֤�ĳ��ȼ��Լ��
if exists(select * from sysobjects where name='ck_StudentIdNo')
alter table Students drop constraint ck_StudentIdNo
alter table Students
add constraint ck_StudentIdNo check (len(StudentIdNo)=18)

--����Ĭ��Լ��
if exists(select * from sysobjects where name='df_StudentAddress')
alter table Students drop constraint df_StudentAddress
alter table Students 
add constraint df_StudentAddress default ('��ַ����' ) for StudentAddress

if exists(select * from sysobjects where name='df_UpdateTime')
alter table ScoreList drop constraint df_UpdateTime
alter table ScoreList 
add constraint df_UpdateTime default (getdate() ) for UpdateTime

--�������Լ��
if exists(select * from sysobjects where name='fk_classId')
alter table Students drop constraint fk_classId
alter table Students
add constraint fk_classId foreign key (ClassId) references StudentClass(ClassId)

if exists(select * from sysobjects where name='fk_StudentId')
alter table ScoreList drop constraint fk_StudentId
alter table ScoreList
add constraint fk_StudentId foreign key(StudentId) references Students(StudentId)


-------------------------------------------��������--------------------------------------
use StudentManager
go

--����༶����
insert into StudentClass(ClassId,ClassName) values(1,'�ƿƱ�1��')
insert into StudentClass(ClassId,ClassName) values(2,'�ƿƱ�2��')
insert into StudentClass(ClassId,ClassName) values(3,'�ƿƱ�3��')
insert into StudentClass(ClassId,ClassName) values(4,'�ƿƱ�4��')

--����ѧԱ��Ϣ
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','��','1989-08-07',120223198908071111,'022-22222222','102',1)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','Ů','1989-05-06',120223198905062426,'022-33333333','506',2)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','��','1990-02-07',120223199002078915,'022-44444444','506',4)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','Ů','1987-05-12',130223198705125167,'022-55555555',default,2)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','Ů','1986-05-08',130223198605081528,'022-66666666','507',1)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','��','1987-07-18',130223198707182235,'022-77777777',default,1)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','��','1988-09-28',130223198909282235,'022-88888888','508',3)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','��','1987-01-18',130223198701182257,'022-99999999','509',1)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','Ů','1987-06-15',130223198706152211,'022-11111111',default,3)
insert into Students (StudentName,Gender,Birthday,StudentIdNo,PhoneNumber,StudentAddress,ClassId)
         values('��С','Ů','1989-08-19',130223198908192235,'022-11111222',default,4)
         
         
         
--����ɼ���Ϣ
insert into ScoreList (StudentId,CSharp,SQLServerDB)values(100000,60,78)
insert into ScoreList (StudentId,CSharp,SQLServerDB)values(100001,55,88)
insert into ScoreList (StudentId,CSharp,SQLServerDB)values(100002,90,58)
insert into ScoreList (StudentId,CSharp,SQLServerDB)values(100003,88,75)

insert into ScoreList (StudentId,CSharp,SQLServerDB)values(100004,62,88)
insert into ScoreList (StudentId,CSharp,SQLServerDB)values(100006,52,80)
insert into ScoreList (StudentId,CSharp,SQLServerDB)values(100007,91,66)
insert into ScoreList (StudentId,CSharp,SQLServerDB)values(100009,78,35)

--�������Ա��Ϣ(��ʼ���룺123456)
insert into Admins (LoginPwd,AdminName) values('123456','��һ')
insert into Admins (LoginPwd,AdminName) values('123456','���')
insert into Admins (LoginPwd,AdminName) values('123456','����')
insert into Admins (LoginPwd,AdminName) values('123456','����')


--��ʾѧԱ��Ϣ�Ͱ༶��Ϣ
select * from Students
select * from StudentClass
select * from ScoreList
select * from Admins



