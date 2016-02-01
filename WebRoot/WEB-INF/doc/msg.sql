
drop sequence sms_seq;
create sequence sms_seq
 increment by 1
 start with 1
 maxvalue 9999999999
 nocache;


drop table sms_receive cascade constraints;
create table sms_receive(
id		number(10) primary key,		
result		varchar(1) default '0',		
mobile		varchar(21) not null,		
recv_time	varchar2(20),			
sms_number	varchar2(10),		
content		varchar2(140)
);
create index idx_sms_receive_result on sms_receive(result);
create index idx_sms_receive_mobile on sms_receive(mobile);
create index idx_sms_receive_sms_number on sms_receive(sms_number);


drop table sms_send cascade constraints;
create table sms_send(
mobile		varchar2(21) not null,		
content		varchar2(140),		
sms_number	varchar2(10),		
id		number(10) primary key,	
priority	number(1) default 9,	
plan_time	varchar2(19),
	
result		varchar(1) default '0',	
	
seq_id		varchar2(10),		
submit_time	varchar2(20),			
send_time	varchar2(20),		
recv_time	varchar2(20)		
);
create index idx_sms_send_priority on sms_send(priority);
create index idx_sms_send_time on sms_send(plan_time);
create index idx_sms_send_result on sms_send(result);
create index idx_sms_send_seq_id on sms_send(seq_id);
create index idx_sms_send_mobile on sms_send(mobile);


drop table sms_history cascade constraints;
create table sms_history(
mobile		varchar2(21) not null,	
content		varchar2(140),			
sms_number	varchar2(10),			
id		number(10) primary key,		
priority	number(1) default 9,		
plan_time	varchar2(19),
	
result		varchar(1) default '0',	

seq_id		varchar2(10),			
submit_time	varchar2(20),			
send_time	varchar2(20),		
recv_time	varchar2(20)		
);
create index idx_sms_history_priority on sms_history(priority);
create index idx_sms_history_time on sms_history(plan_time);
create index idx_sms_history_result on sms_history(result);
create index idx_sms_history_seq_id on sms_history(seq_id);
create index idx_sms_history_mobile on sms_history(mobile);

