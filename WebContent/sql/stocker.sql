----------------------------
---------- system ----------
----------------------------
--create user stocker
--identified by stocker
--default tablespace users;
--
--grant connect, resource to stocker;
--grant create any job to stocker;

---------------------------
---------- 초기화 ----------
---------------------------
drop table stock;
drop table center;
drop table product;
drop table product_detail;
drop table warehousing;
drop table be_released;
drop table transfer;
drop table shop;
drop table employee;
drop table ordr;
drop table memo;
drop table calendar;
drop table board_comment;
drop table board;

drop trigger trig_be_released_to_shop;
drop trigger trig_be_released_by_transfer;
drop trigger trg_transfer;
drop trigger trig_warehousing;

drop sequence seq_employee;
drop sequence seq_warehousing;
drop sequence seq_ordr;
drop sequence seq_transfer;
drop sequence seq_be_released;
drop sequence seq_memo;
drop sequence seq_calendar;
drop sequence seq_board_comment;
drop sequence SEQ_BOARD_NO;

begin
dbms_scheduler.drop_job('warehousing_tumblr_job');
dbms_scheduler.drop_job('warehousing_mug_job');
dbms_scheduler.drop_job('warehousing_glass_job');
end;
/

drop procedure warehousing_tumblr;
drop procedure warehousing_mug;
drop procedure warehousing_glass;

purge recyclebin; -- bin 비우기

-----------------------------
---------- product ----------
-----------------------------
create table product ( 
    p_code varchar2(50), 
    p_theme varchar2(50) not null, 
    p_category varchar2(50) not null, 
    p_name varchar2(50) not null, 
    p_color varchar2(50), 
    p_price number not null, 
    constraints pk_product_p_code primary key (p_code),
    constraints ck_product_p_theme check (p_theme in ('시티', '섬머', '리저브')),
    constraints ck_product_p_category check (p_category in ('텀블러', '머그', '글라스', '보온병'))
);

comment on column product.p_code is '상품코드';
comment on column product.p_theme is '테마';
comment on column product.p_category is '분류';
comment on column product.p_name is '상품명';
comment on column product.p_color is '색상';
comment on column product.p_price is '가격';

--p_theme : 시티 c, 섬머 s, 리저브 r
--p_category : 텀블러 t, 머그 m, 글라스 g, 보온병 b
insert into product values('CT001', '시티', '텀블러', '리얼 대전 텀블러' , null, 18000);
insert into product values('CT002', '시티', '텀블러', '리얼 광주 텀블러' , null, 18000);
insert into product values('CT003', '시티', '텀블러', '서울 투어 텀블러' , null, 18000);
insert into product values('CT004', '시티', '텀블러', '리얼 대구 텀블러' , null, 18000);
insert into product values('CT005', '시티', '텀블러', '부산 투어 텀블러' , null, 18000);
insert into product values('CT006', '시티', '텀블러', '인천 투어 텀블러' , null, 18000);
insert into product values('CT007', '시티', '텀블러', '제주 투어 텀블러' , null, 18000);
insert into product values('CT008', '시티', '텀블러', '경주 투어 텀블러' , null, 18000);
insert into product values('CM001', '시티', '머그', '리얼 대전 머그' , null, 15000);
insert into product values('CM002', '시티', '머그', '리얼 광주 머그' , null, 15000);
insert into product values('CM003', '시티', '머그', '서울 투어 머그' , null, 15000);
insert into product values('CM004', '시티', '머그', '리얼 대구 머그' , null, 15000);
insert into product values('CM005', '시티', '머그', '부산 투어 머그' , null, 15000);
insert into product values('CM006', '시티', '머그', '인천 투어 머그' , null, 15000);
insert into product values('CM007', '시티', '머그', '제주 투어 머그' , null, 15000);
insert into product values('CM008', '시티', '머그', '경주 투어 머그' , null, 15000);
insert into product values('CG001', '시티', '글라스', '리얼 대전 글라스' , null, 20000);
insert into product values('CG002', '시티', '글라스', '리얼 광주 글라스' , null, 20000);
insert into product values('CG003', '시티', '글라스', '서울 투어 글라스' , null, 20000);
insert into product values('SM001', '섬머', '머그', '사이렌 그라데이션 핸들 머그' , null, 20000);
insert into product values('SG001', '섬머', '글라스', '섬머 라탄 핸들 글라스' , null, 30000);
insert into product values('SG002', '섬머', '글라스', '섬머 헤리티지 DW 글라스' , null, 30000);
insert into product values('SG003', '섬머', '글라스', '섬머 헤리티지 그린 마블 글라스' , '그린', 32000);
insert into product values('SG004', '섬머', '글라스', '섬머 사이렌 블루 글라스' , '블루', 32000);
insert into product values('SG005', '섬머', '글라스', '라탄 글라스 워터보틀' , null, 28000);
insert into product values('ST001', '섬머', '텀블러', '플로런스 화이트 히비스커스 텀블러' , '화이트', 35000);
insert into product values('ST002', '섬머', '텀블러', '스트랩 화이트 히비스커스 텀블러' , '화이트', 35000);
insert into product values('ST003', '섬머', '텀블러', '트로이 소피아 텀블러' , null, 35000);
insert into product values('ST004', '섬머', '텀블러', '사피어 화이트 텀블러' , '화이트', 32000);
insert into product values('ST005', '섬머', '텀블러', '노바토 사이렌 브라운 텀블러' , '브라운', 38000);
insert into product values('ST006', '섬머', '텀블러', '콩코드 그라데이션 텀블러' , null, 34000);
insert into product values('ST007', '섬머', '텀블러', '엘마 틸블루 그라데이션 텀블러' , '틸블루', 34000);
insert into product values('ST008', '섬머', '텀블러', '제니 워드마크 텀블러' , null, 32000);
insert into product values('SB001', '섬머', '보온병', '브라운 워드마크 보온병', '브라운', 30000);
insert into product values('SB002', '섬머', '보온병', '헤리티지 딥블루 보온병' , '블루', 28000);
insert into product values('RM001', '리저브', '머그', '리저브 블루 머그' , '블루', 36000);
insert into product values('RM002', '리저브', '머그', '리저브 블랙 머그' , '블랙', 23500);
insert into product values('RM003', '리저브', '머그', '리저브 화이트 머그' , '화이트', 23500);
insert into product values('RM004', '리저브', '머그', '리저브 뉴블랙 데미머그' , '블랙', 23500);
insert into product values('RG001', '리저브', '글라스', '리저브 골드핸들 글라스' , '골드', 45000);
insert into product values('RG002', '리저브', '글라스', '리저브 콜드브루 글라스' , null, 49000);

select * from product;

------------------------------
---------- employee ----------
------------------------------
create table employee (
    e_code number, 
    e_name varchar2(50) not null, 
    e_password varchar2(300) not null, 
    e_dept varchar2(50) not null, 
    e_phone varchar2(50) not null, 
    e_email varchar2(50) not null, 
    constraints pk_employee_e_code primary key (e_code)
);

comment on column employee.e_code is '사번';
comment on column employee.e_name is '직원명';
comment on column employee.e_password is '비밀번호';
comment on column employee.e_dept is '부서';
comment on column employee.e_phone is '전화번호';
comment on column employee.e_email is '이메일';
create sequence seq_employee
start with 1003;
​
insert into employee values (seq_employee.nextval, '선동일', '1234', '입고', '01099546325', 'sun_di@kh.or.kr');
insert into employee values (seq_employee.nextval, '송중기', '1234', '입고', '01045686656', 'song_jk@kh.or.kr');
insert into employee values (seq_employee.nextval, '노옹철', '1234', '입고', '01066656263', 'no_hc@kh.or.kr');
insert into employee values (seq_employee.nextval, '송은희', '1234', '입고', '01077607879', 'song_eh@kh.or.kr');
insert into employee values (seq_employee.nextval, '유재식', '1234', '출고', '01099999129', 'yoo_js@kh.or.kr');
insert into employee values (seq_employee.nextval, '정중하', '1234', '출고', '01036654875', 'jung_jh@kh.or.kr');
insert into employee values (seq_employee.nextval, '박나라', '1234', '출고', '01096935222', 'pack_nr@kh.or.kr');
insert into employee values (seq_employee.nextval, '하이유', '1234', '출고', '01036654488', 'ha_iy@kh.or.kr');
insert into employee values (seq_employee.nextval, '김해슬', '1234', '발주', '01078634444', 'nsunny0908@naver.com'); --임의로 수신할수있는 이메일로 설정
insert into employee values (seq_employee.nextval, '심봉선', '1234', '발주', '01033654485', 'sim_bs@kh.or.kr');
insert into employee values (seq_employee.nextval, '윤은해', '1234', '발주', '01019964233', 'youn_eh@kh.or.kr');
insert into employee values (seq_employee.nextval, '전형돈', '1234', '발주', '01044432222', 'jun_hd@kh.or.kr');
insert into employee values (seq_employee.nextval, '장쯔위', '1234', '이송', '01066682224', 'jang_zw@kh.or.kr');
insert into employee values (seq_employee.nextval, '하동윤', '1234', '이송', '01158456632', 'ha_dh@kh.or.kr');
insert into employee values (seq_employee.nextval, '방명수', '1234', '이송', '01074127545', 'bang_ms@kh.or.kr');
insert into employee values (seq_employee.nextval, '대북혼', '1234', '이송', '01088808584', 'dae_bh@kh.or.kr');
insert into employee values (1000, '차태연', '1234', '관리자', '01012341234', 'admin@kh.or.kr');
insert into employee values (1001, '이중석', '1234', '대구물류', '01024453940', 'im_js@kh.or.kr');
insert into employee values (1002, '공이오', '1234', '경기물류', '01024453940', 'im_sw@kh.or.kr');


--비밀번호 1234를 임의로 암호화처리해줌
update employee
set e_password = '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==';

select * from employee;
----------------------------
---------- center ----------
----------------------------
create table center (
    c_code varchar2(50), 
    c_name varchar2(50) not null, 
    c_staff_no number not null, 
    constraints pk_center_c_code primary key(c_code),
    constraints fk_center_c_staff_no foreign key (c_staff_no) references employee(e_code) on delete cascade
);

comment on column center.c_code is '센터코드';
comment on column center.c_name is '센터이름';
comment on column center.c_staff_no is '센터 담당자 사번';

insert into center values('GG', '경기물류센터', 1000);
insert into center values('TK', '대구물류센터', 1001);

select * from center;


--------------------------
---------- shop ----------
--------------------------
create table shop(
    s_code varchar2(50),
    s_name varchar2(50) not null,
    s_location varchar2(50) not null,
    s_tel varchar2(50) not null, 
    constraints pk_shop_s_code primary key(s_code)
);

comment on column shop.s_code is '매장코드';
comment on column shop.s_name is '매장이름';
comment on column shop.s_location is '매장지역';
comment on column shop.s_tel is '매장 전화번호';

insert into shop values('S001', '코엑스 별마당', 'L1', '0293030205');
insert into shop values('S002', '압구정', 'L1', '0283040293');
insert into shop values('S003', '강남오거리', 'L1', '0293040304');
insert into shop values('S004', '강남', 'L1', '0203400203');
insert into shop values('S005', '한티역', 'L1', '020394920504');
insert into shop values('S006', '도산가로수길', 'L1', '0204030504');
insert into shop values('S007', '수원시청', 'L1', '0310293920403');
insert into shop values('S008', '수원성균관대', 'L1', '03102035948');
insert into shop values('S009', '범계역', 'L1', '0310485930494');
insert into shop values('S010', '킨텍스이마트', 'L1', '0310394920394');
insert into shop values('S011', '대구수목원', 'L2', '0539394039402');
insert into shop values('S012', '대구동천', 'L2', '053940392043');
insert into shop values('S013', '경북대', 'L2', '053949493030');
insert into shop values('S014', '부산대연역', 'L2', '0519394069495');
insert into shop values('S015', '수영강변', 'L2', '0517583920493');


select * from shop;

---------------------------------
---------- warehousing ----------
---------------------------------
create table warehousing ( 
    w_code number, 
    p_code varchar2(20) not null, 
    c_code varchar2(50) not null, 
    w_amount number not null, 
    w_reason char(1) not null, 
    w_date date default sysdate, 
    constraints pk_warehousing_w_code primary key (w_code),
    constraints fk_warehousing_p_code foreign key (p_code) references product(p_code) on delete cascade,
    constraints fk_warehousing_c_code foreign key (c_code) references center(c_code) on delete cascade,
    constraints ck_warehousing_w_reason check (w_reason in ('S', 'T'))
);

comment on column warehousing.w_code is '입고코드';
comment on column warehousing.p_code is '입고상품';
comment on column warehousing.c_code is '입고센터';
comment on column warehousing.w_amount is '입고량';
comment on column warehousing.w_reason is '입고사유';
comment on column warehousing.w_date is '입고일';

create sequence seq_warehousing
start with 1000;

--2017년 생산입고 데이터(db 초기화할때 가장 오래된 입고건에 시퀀스 번호가 먼저 매겨질 수 있도록 입고 데이터 제일 위에 위치해주세요)
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'GG', 500, 'S', add_months(sysdate,-36));
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'TK', 500, 'S', add_months(sysdate,-36));
insert into warehousing values(seq_warehousing.nextval, 'CT001', 'GG', 487, 'S', add_months(sysdate,-36));
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'TK', 123, 'S', add_months(sysdate,-36));
--2018년 생산입고 데이터
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'GG', 600, 'S', add_months(sysdate,-24));
insert into warehousing values(seq_warehousing.nextval, 'CG002', 'TK', 546, 'S', add_months(sysdate,-24));
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'GG', 700, 'S', add_months(sysdate,-24));
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'TK', 600, 'S', add_months(sysdate,-24));
--2019년 생산입고 데이터
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'GG', 900, 'S', add_months(sysdate,-18));
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'TK', 889, 'S', add_months(sysdate,-18));
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'GG', 1000, 'S', add_months(sysdate,-18));
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'TK', 766, 'S', add_months(sysdate,-18));


insert into warehousing values(seq_warehousing.nextval, 'CT001', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT001', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT003', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT003', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT004', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT004', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT005', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT005', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT006', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT006', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT007', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT007', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT008', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CT008', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST001', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST001', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST002', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST002', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST003', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST003', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST004', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST004', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST005', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST005', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST006', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST006', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST007', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST007', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST008', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'ST008', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM001', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM001', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM002', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM002', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM003', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM003', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM004', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM004', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM005', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM005', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM006', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM006', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM007', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM007', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM008', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CM008', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SM001', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SM001', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CG002', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CG002', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CG003', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'CG003', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG001', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG001', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG002', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG002', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG003', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG003', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG004', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG004', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG005', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'SG005', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'RG001', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'RG001', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'RG002', 'GG', 100, 'S', to_date('20200601', 'yyyymmdd'));
insert into warehousing values(seq_warehousing.nextval, 'RG002', 'TK', 100, 'S', to_date('20200601', 'yyyymmdd'));

--올해 이번달 생산입고 데이터(오늘로부터 12일전)
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'GG', 60, 'S', sysdate-12);
insert into warehousing values(seq_warehousing.nextval, 'CG001', 'TK', 50, 'S', sysdate-12);
insert into warehousing values(seq_warehousing.nextval, 'CG002', 'GG', 25, 'S', sysdate-12);
insert into warehousing values(seq_warehousing.nextval, 'CG002', 'TK', 60, 'S', sysdate-12);
insert into warehousing values(seq_warehousing.nextval, 'CT001', 'GG', 40, 'S', sysdate-12);
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'GG', 35, 'S', sysdate-12);
insert into warehousing values(seq_warehousing.nextval, 'CT002', 'TK', 25, 'S', sysdate-12);

select * from warehousing;

---------------------------
---------- stock ----------
---------------------------
create table stock (
    c_code varchar2(50) not null, 
    p_code varchar2(50) not null, 
    s_capa number not null, 
    s_amount number not null, 
    constraints pk_stock_c_code_p_code primary key(c_code, p_code),
    constraints fk_stock_c_code foreign key(c_code) references center(c_code) on delete cascade,
    constraints fk_stock_p_code foreign key(p_code) references product(p_code) on delete cascade
);

comment on column stock.c_code is '센터코드';
comment on column stock.p_code is '상품코드';
comment on column stock.s_capa is '안전재고량';
comment on column stock.s_amount is '현재재고량';

insert into stock values('GG', 'RM001', 30, 100);
insert into stock values('GG', 'RM002', 30, 100);
insert into stock values('GG', 'RM003', 30, 100);
insert into stock values('GG', 'RM004', 40, 100);
insert into stock values('GG', 'RG001', 40, 100);
insert into stock values('GG', 'RG002', 40, 100);
insert into stock values('TK', 'CT001', 40, 100);
insert into stock values('TK', 'CT002', 70, 100);
insert into stock values('TK', 'CT003', 60, 100);
insert into stock values('TK', 'CT004', 60, 100);
insert into stock values('TK', 'CT005', 60, 100);
insert into stock values('TK', 'CT006', 60, 100);
insert into stock values('TK', 'CT007', 60, 100);
insert into stock values('TK', 'CT008', 40, 100);
insert into stock values('TK', 'CM001', 40, 100);
insert into stock values('TK', 'CM002', 40, 100);
insert into stock values('TK', 'CM003', 50, 100);
insert into stock values('TK', 'CM004', 10, 100);
insert into stock values('TK', 'CM005', 20, 100);
insert into stock values('TK', 'CM006', 50, 100);
insert into stock values('TK', 'CM007', 30, 100);
insert into stock values('TK', 'CM008', 50, 100);
insert into stock values('TK', 'CG001', 40, 100);
insert into stock values('TK', 'CG002', 50, 100);
insert into stock values('TK', 'CG003', 20, 100);
insert into stock values('TK', 'SM001', 50, 100);
insert into stock values('TK', 'SG001', 40, 100);
insert into stock values('TK', 'SG002', 50, 100);
insert into stock values('TK', 'SG003', 50, 100);
insert into stock values('TK', 'SG004', 70, 100);
insert into stock values('TK', 'SG005', 60, 100);
insert into stock values('TK', 'ST001', 50, 100);
insert into stock values('TK', 'ST002', 40, 100);
insert into stock values('TK', 'ST003', 30, 100);
insert into stock values('TK', 'ST004', 50, 100);
insert into stock values('TK', 'ST005', 50, 100);
insert into stock values('TK', 'ST006', 60, 100);
insert into stock values('TK', 'ST007', 50, 100);
insert into stock values('TK', 'ST008', 30, 100);
insert into stock values('TK', 'SB001', 40, 100);
insert into stock values('TK', 'SB002', 50, 100);
insert into stock values('TK', 'RM001', 60, 100);
insert into stock values('TK', 'RM002', 60, 100);
insert into stock values('TK', 'RM003', 50, 100);
insert into stock values('TK', 'RM004', 40, 100);
insert into stock values('TK', 'RG001', 30, 100);
insert into stock values('TK', 'RG002', 20, 100);
insert into stock values('GG', 'SB001', 50, 100);
insert into stock values('GG', 'SB002', 40, 100);
insert into stock values('GG', 'RM001', 30, 100);
insert into stock values('GG', 'RM002', 30, 100);
insert into stock values('GG', 'RM003', 30, 100);
insert into stock values('GG', 'RM004', 40, 100);
insert into stock values('TK', 'SB001', 40, 100);
insert into stock values('TK', 'SB002', 50, 100);
insert into stock values('TK', 'RM001', 60, 100);
insert into stock values('TK', 'RM002', 60, 100);
insert into stock values('TK', 'RM003', 50, 100);
insert into stock values('TK', 'RM004', 40, 100);

select * from stock;

-- 기존 테이블인 center의 데이터입력을 시도했을 때 c_code가 기본키인 상태에서 여러개인 product의 p_code를 가지지 못하여
-- 재고 테이블을 따로 생성하였음 
-- ex) 
--      센터코드   상품코드   재고량
--       g1      ct001      0
--       g1      ct002      0
--  기존처럼 센터에서 재고를 관리하면 위와같은 데이터 입력이 불가능
--------------------------
---------- ordr ----------
--------------------------

create table ordr (
    o_code number, 
    p_code varchar2(50) not null, 
    o_amount number not null, 
    s_code varchar2(50) not null, 
    c_code varchar2(50) not null, 
    o_date date default sysdate, 
    o_status varchar2(50) default 'W', 
    o_writer number not null,
    o_title varchar2(100) not null,
    o_comment varchar2(300),
    constraints pk_ordr_o_code primary key (o_code),
    constraints fk_ordr_p_code foreign key (p_code) references product(p_code) on delete cascade,
    constraints fk_ordr_s_code foreign key (s_code) references shop(s_code) on delete cascade,
    constraints fk_ordr_c_code foreign key (c_code) references center(c_code) on delete cascade,
    constraints ck_ordr_o_status check (o_status in ('W', 'C')),
    constraints fk_ordr_o_sriter foreign key (o_writer) references employee(e_code) on delete cascade
);

comment on column ordr.o_code is '발주코드';
comment on column ordr.p_code is '발주상품';
comment on column ordr.o_amount is '발주량';
comment on column ordr.s_code is '발주매장';
comment on column ordr.c_code is '출고센터';
comment on column ordr.o_date is '발주일';
comment on column ordr.o_status is '발주상태';
comment on column ordr.o_title is '발주서제목';
comment on column ordr.o_comment is '발주서내용';

create sequence seq_ordr
start with 1000;
--2017년 발주(역시 발주 데이터 제일 위에 복붙바람)
insert into ordr values(seq_ordr.nextval, 'CG001', 500, 'S004', 'GG', to_date('2017-10-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT001', 487, 'S005', 'GG', to_date('2017-10-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CG001', 500, 'S006', 'TK', to_date('2017-10-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT001', 123, 'S007', 'TK', to_date('2017-10-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
--2018년 발주
insert into ordr values(seq_ordr.nextval, 'CG001', 600, 'S004', 'GG', to_date('2018-10-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT002', 700, 'S005', 'GG', to_date('2018-10-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CG002', 546, 'S006', 'TK', to_date('2018-10-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT002', 600, 'S007', 'TK', to_date('2018-10-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
--2019년 발주
insert into ordr values(seq_ordr.nextval, 'CG001', 500, 'S004', 'GG', to_date('2019-01-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT002', 500, 'S005', 'GG', to_date('2019-01-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CG001', 356, 'S006', 'TK', to_date('2019-01-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT002', 512, 'S007', 'TK', to_date('2019-01-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);

--2020년 발주(1, 2월)
insert into ordr values(seq_ordr.nextval, 'CG001', 150, 'S004', 'GG', to_date('2020-01-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT002', 90, 'S005', 'GG', to_date('2020-01-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CG001', 150, 'S006', 'TK', to_date('2020-01-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT002', 100, 'S007', 'TK', to_date('2020-01-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);

insert into ordr values(seq_ordr.nextval, 'CG001', 50, 'S004', 'GG', to_date('2020-02-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT002', 30, 'S005', 'GG', to_date('2020-02-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CG001', 35, 'S006', 'TK', to_date('2020-02-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CT002', 65, 'S007', 'TK', to_date('2020-02-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);

insert into ordr values(seq_ordr.nextval, 'CG001', 10, 'S004', 'GG', to_date('2020-07-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'CG002', 10, 'S005', 'GG', to_date('2020-07-15', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'SG001', 10, 'S006', 'GG', to_date('2020-07-14', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'SG002', 10, 'S007', 'GG', to_date('2020-07-03', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'RG001', 10, 'S008', 'GG', to_date('2020-07-15', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'RG002', 10, 'S009', 'GG', to_date('2020-06-30', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'ST001', 10, 'S010', 'GG', to_date('2020-06-10', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'ST002', 10, 'S011', 'TK', to_date('2020-06-10', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'ST003', 10, 'S012', 'TK', to_date('2020-06-20', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'ST004', 10, 'S013', 'TK', to_date('2020-06-20', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'ST005', 10, 'S014', 'TK', to_date('2020-06-26', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'ST006', 10, 'S015', 'TK', to_date('2020-06-12', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'ST007', 10, 'S001', 'TK', to_date('2020-06-05', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'ST008', 10, 'S002', 'TK', to_date('2020-06-24', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);
insert into ordr values(seq_ordr.nextval, 'RG002', 10, 'S003', 'TK', to_date('2020-06-12', 'yyyy-mm-dd'), 'C', 1013, '결재 부탁드립니다.', null);

select * from ordr;

------------------------------
---------- transfer ----------
------------------------------
create table transfer(
    t_code number, 
    p_code varchar2(50) not null, 
    t_amount number not null, 
    t_date date default sysdate, 
    departure_code varchar2(50) not null, 
    destination_code varchar2(50) not null, 
    t_status varchar2(50) default 'W',
    t_title varchar2(100) not null,
    t_writer varchar2(50) not null,
    constraints pk_transfer_t_code primary key (t_code),
    constraints fk_transfer_departure_code foreign key (departure_code) references center(c_code) on delete cascade,
    constraints fk_transfer_destination_code foreign key (destination_code) references center(c_code) on delete cascade,
    constraints ck_transfer_t_status check (t_status in ('W', 'C'))
);

comment on column transfer.t_code is '이송코드';
comment on column transfer.p_code is '이송상품';
comment on column transfer.t_amount is '이송량';
comment on column transfer.t_date is '이송일';
comment on column transfer.departure_code is '출발센터';
comment on column transfer.destination_code is '도착센터';
comment on column transfer.t_status is '이송상태';
comment on column transfer.t_title is '이송요청서 제목';

create sequence seq_transfer
start with 1000;


insert into transfer values (seq_transfer.nextval, 'CT001', 10, to_date('2020-07-01', 'yyyy-mm-dd'), 'TK', 'GG', 'C', '이송요청합니다.', '이중석');
insert into transfer values (seq_transfer.nextval, 'CT002', 35, to_date('2020-07-02', 'yyyy-mm-dd'), 'GG', 'TK', 'C', '이송요청합니다.', '공이오');
insert into transfer values (seq_transfer.nextval, 'CT003', 3, to_date('2020-07-03', 'yyyy-mm-dd'), 'TK', 'GG', 'C', '이송요청부탁드려요!!', '이중석');
insert into transfer values (seq_transfer.nextval, 'CM001', 1, to_date('2020-07-04', 'yyyy-mm-dd'), 'GG', 'TK', 'C', '이송요청합니다.', '공이오');
insert into transfer values (seq_transfer.nextval, 'CM002', 7, to_date('2020-07-05', 'yyyy-mm-dd'), 'TK', 'GG', 'C', '이송요청합니다.', '이중석');
insert into transfer values (seq_transfer.nextval, 'CM003', 8, to_date('2020-07-06', 'yyyy-mm-dd'), 'GG', 'TK', 'C', '이송요청합니다.', '공이오');
insert into transfer values (seq_transfer.nextval, 'CG001', 13, to_date('2020-07-07', 'yyyy-mm-dd'), 'TK', 'GG', 'C', '이송요청합니다.', '이중석');
insert into transfer values (seq_transfer.nextval, 'CG002', 17, to_date('2020-07-08', 'yyyy-mm-dd'), 'GG', 'TK', 'C', '이송요청합니다.', '공이오');
insert into transfer values (seq_transfer.nextval, 'CG003', 11, to_date('2020-07-09', 'yyyy-mm-dd'), 'TK', 'GG', 'C', '이송요청합니다.', '이중석');
insert into transfer values (seq_transfer.nextval, 'SG001', 21, to_date('2020-07-10', 'yyyy-mm-dd'), 'GG', 'TK', 'C', '얼른해주세요', '공이오');
insert into transfer values (seq_transfer.nextval, 'SG002', 8, to_date('2020-07-11', 'yyyy-mm-dd'), 'TK', 'GG', 'C', '이송요청합니다.', '이중석');
insert into transfer values (seq_transfer.nextval, 'SG003', 6, to_date('2020-07-12', 'yyyy-mm-dd'), 'GG', 'TK', 'C', '이송요청합니다.', '공이오');
insert into transfer values (seq_transfer.nextval, 'ST001', 5, to_date('2020-07-13', 'yyyy-mm-dd'), 'TK', 'GG', 'W', '이송요청합니다.', '이중석');

select * from transfer;

---------------------------------
---------- be_released ----------
---------------------------------
create table be_released(
    r_code number, 
    o_code number, -- 매장출고 시에 해당 발주서의 코드가 필요해서 추가
    t_code number, -- 이송출고 시에 해당 이송코드가 필요해서 추가
    p_code varchar2(50) not null, 
    r_amount number not null, 
    r_reason varchar2(50) not null, -- 출고사유 - 이송출고인지 매장으로 간 출고인지 구분하기 위해 추가
    r_date date default sysdate, 
    constraints pk_be_released_r_code primary key (r_code),
    constraints fk_be_released_o_code foreign key (o_code) references ordr(o_code) on delete cascade,
    constraints fk_be_released_t_code foreign key (t_code) references transfer(t_code) on delete cascade,
    constraints fk_be_released_p_code foreign key (p_code) references product(p_code) on delete cascade
);

comment on column be_released.r_code is '출고코드';
comment on column be_released.o_code is '발주코드';
comment on column be_released.t_code is '이송코드';
comment on column be_released.p_code is '상품코드';
comment on column be_released.r_amount is '출고량';
comment on column be_released.r_reason is '출고사유';
comment on column be_released.r_date is '출고일';

create sequence seq_be_released
start with 1000;


--2017년 출고(출고 데이터는 이거로 대체해도 되지 않을까요)
insert into be_released values(seq_be_released.nextval, 1000, null, 'CG001', 500, '매장출고', to_date('2017-10-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1001, null,'CT001', 487, '매장출고', to_date('2017-10-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1002, null, 'CG001', 500, '매장출고', to_date('2017-10-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1003, null, 'CT001', 123, '매장출고', to_date('2017-10-14', 'yyyy-mm-dd'));
--2018년 출고
insert into be_released values(seq_be_released.nextval, 1004, null, 'CG001', 600, '매장출고', to_date('2018-10-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1005, null,'CT002', 700, '매장출고', to_date('2018-10-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1006, null, 'CG002', 546, '매장출고', to_date('2018-10-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1007, null, 'CT002', 600, '매장출고', to_date('2018-10-14', 'yyyy-mm-dd'));
--2019년 출고
insert into be_released values(seq_be_released.nextval, 1008, null, 'CG001', 500, '매장출고', to_date('2019-03-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1009, null, 'CT002', 500, '매장출고', to_date('2019-05-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1010, null, 'CG001', 356, '매장출고', to_date('2019-07-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1011, null, 'CT002', 512, '매장출고', to_date('2019-09-14', 'yyyy-mm-dd'));
--2020년 출고
insert into be_released values(seq_be_released.nextval, 1012, null, 'CG001', 150, '매장출고', to_date('2020-01-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1013, null, 'CT002', 90, '매장출고', to_date('2020-04-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1014, null, 'CG001', 150, '매장출고', to_date('2020-05-14', 'yyyy-mm-dd'));
insert into be_released values(seq_be_released.nextval, 1015, null, 'CT002', 100, '매장출고', to_date('2020-06-14', 'yyyy-mm-dd'));

insert into be_released values(seq_be_released.nextval, null, null, 'SG005', 50, '매장출고', add_months(sysdate, -2));
insert into be_released values(seq_be_released.nextval, null, null, 'RM002', 10, '매장출고', add_months(sysdate,-2));
insert into be_released values(seq_be_released.nextval, null, null, 'ST007', 35, '매장출고', add_months(sysdate,-3));
insert into be_released values(seq_be_released.nextval, null, null, 'CT006', 65, '매장출고', add_months(sysdate,-1));

insert into be_released values(seq_be_released.nextval, 1016, null, 'CG001', 50, '매장출고', sysdate-4);
insert into be_released values(seq_be_released.nextval, 1017, null, 'CT002', 30, '매장출고', sysdate-2);
insert into be_released values(seq_be_released.nextval, 1018, null, 'CG001', 35, '매장출고', sysdate-3);
insert into be_released values(seq_be_released.nextval, 1019, null, 'CT002', 65, '매장출고', sysdate);

select * from be_released;

------------------------------------
---------- product_detail ----------
------------------------------------
create table product_detail(
    f_time varchar2(50), 
    p_code varchar2(50) not null, 
    p_status char(1) not null, -- 현재 재고 있음 'O' / 매장으로 출고 됨 'X'
    constraints pk_product_detail_f_time primary key (f_time),
    constraints fk_product_detail_p_code foreign key (p_code) references product(p_code) on delete cascade
);

comment on column product_detail.f_time is '생산시간';
comment on column product_detail.p_code is '상품코드';
comment on column product_detail.p_status is '상태';

insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'SM001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'SM001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'SM001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'SM001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'SM001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CT001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CT002', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CT003', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CM001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CM002', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CM003', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CG001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CG002', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'CG003', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'SG001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'SG002', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'SG003', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'ST001', 'O');
insert into product_detail values(to_char(systimestamp,  'YYYYMMDDHH24MISSFF'), 'ST002', 'O');

select * from product_detail;


---------------------------
----------- todo ----------
---------------------------
create table memo(
    m_code number, 
    e_code number not null, 
    m_contents varchar2(100) not null,
    m_status char(1) default 'W', 
    constraints pk_memo_m_code primary key (m_code),
    constraints fk_memo_e_code foreign key (e_code) references employee(e_code) on delete cascade
);
​
comment on column memo.m_code is '메모번호';
comment on column memo.e_code is '메모작성직원';
comment on column memo.m_contents is '메모내용';
comment on column memo.m_status is '메모상태';
​
create sequence seq_memo;
select * from employee;
​
insert into memo values(seq_memo.nextval, 1000, '선동일 짜르기', 'W');
insert into memo values(seq_memo.nextval, 1001, '반차쓰기', 'W');
insert into memo values(seq_memo.nextval, 1002, '점심 많이 먹기', 'W');
insert into memo values(seq_memo.nextval, 1002, '칼퇴하기', 'C');
insert into memo values(seq_memo.nextval, 1003, '퇴사하기', 'W');
insert into memo values(seq_memo.nextval, 1004, '칼퇴하기', 'W');
insert into memo values(seq_memo.nextval, 1005, '불금보내기', 'W');
insert into memo values(seq_memo.nextval, 1006, '사장되기', 'W');
insert into memo values(seq_memo.nextval, 1007, '사장되기', 'W');
insert into memo values(seq_memo.nextval, 1008, '4끼먹기', 'W');
insert into memo values(seq_memo.nextval, 1009, '오늘 파티', 'W');
insert into memo values(seq_memo.nextval, 1010, '기타 배우러 가기', 'W');
insert into memo values(seq_memo.nextval, 1011, '유해진 연락하기', 'W');
insert into memo values(seq_memo.nextval, 1012, '퇴사하기', 'W');
insert into memo values(seq_memo.nextval, 1013, '김종국 연락하기', 'W');
insert into memo values(seq_memo.nextval, 1014, '4끼먹기', 'W');
insert into memo values(seq_memo.nextval, 1015, '귀화하기', 'W');
insert into memo values(seq_memo.nextval, 1016, '별한테 연락하기', 'W');
insert into memo values(seq_memo.nextval, 1017, '유재식 이기기', 'W');
insert into memo values(seq_memo.nextval, 1018, '퇴사하기', 'W');

-------------------------------
----------- calendar ----------
-------------------------------
create table calendar
(
    title varchar2(50) not null,
    color varchar2(20) not null,
    start_date date default sysdate not null,
    end_date date
);
comment on column calendar.title is '일정제목';
comment on column calendar.color is '일정색';
comment on column calendar.start_date is '일정시작일';
comment on column calendar.end_date is '일정종료일';
​
create sequence seq_calendar;
insert into calendar values('글라스 입고', '#89aeff', to_date('20200701', 'yyyymmdd'), null);
insert into calendar values('글라스 입고', '#89aeff', to_date('20200708', 'yyyymmdd'), null);
insert into calendar values('글라스 입고', '#89aeff', to_date('20200715', 'yyyymmdd'), null);
insert into calendar values('글라스 입고', '#89aeff', to_date('20200722', 'yyyymmdd'), null);
insert into calendar values('머그 입고', '#89ff9f', to_date('20200706', 'yyyymmdd'), null);
insert into calendar values('머그 입고', '#89ff9f', to_date('20200713', 'yyyymmdd'), null);
insert into calendar values('머그 입고', '#89ff9f', to_date('20200720', 'yyyymmdd'), null);
insert into calendar values('머그 입고', '#89ff9f', to_date('20200727', 'yyyymmdd'), null);
insert into calendar values('텀블러 입고', '#fda5ff', to_date('20200703', 'yyyymmdd'), null);
insert into calendar values('텀블러 입고', '#fda5ff', to_date('20200710', 'yyyymmdd'), null);
insert into calendar values('텀블러 입고', '#fda5ff', to_date('20200724', 'yyyymmdd'), null);
insert into calendar values('텀블러 입고', '#fda5ff', to_date('20200731', 'yyyymmdd'), null);
insert into calendar values('제헌절', '#ff0000', to_date('20200717', 'yyyymmdd'), null);
insert into calendar values('여름휴가', '#fff6a5', to_date('20200801', 'yyyymmdd'), to_date('20200804', 'yyyymmdd'));
select * from calendar;
commit;



-------------------------------
----------- board ----------
-------------------------------
CREATE TABLE BOARD (	
    "BOARD_NO" NUMBER, 
	"BOARD_TITLE" VARCHAR2(50) NOT NULL, 
	"BOARD_WRITER" VARCHAR2(30), 
	"BOARD_CONTENT" VARCHAR2(2000) NOT NULL, 
	"BOARD_ORIGINAL_FILENAME" VARCHAR2(100), 
	"BOARD_RENAMED_FILENAME" VARCHAR2(100), 
	"BOARD_DATE" DATE DEFAULT SYSDATE, 
	"BOARD_READCOUNT" NUMBER DEFAULT 0, 
    CONSTRAINT PK_BOARD_NO PRIMARY KEY(BOARD_NO)
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글번호';
COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글제목';
COMMENT ON COLUMN "BOARD"."BOARD_WRITER" IS '게시글작성자 아이디';
COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글내용';
COMMENT ON COLUMN "BOARD"."BOARD_ORIGINAL_FILENAME" IS '첨부파일원래이름';
COMMENT ON COLUMN "BOARD"."BOARD_RENAMED_FILENAME" IS '첨부파일변경이름';
COMMENT ON COLUMN "BOARD"."BOARD_DATE" IS '게시글올린날짜';
COMMENT ON COLUMN "BOARD"."BOARD_READCOUNT" IS '조회수';

--게시판시퀀스생성
CREATE SEQUENCE SEQ_BOARD_NO
START WITH 1;

insert into board values (SEQ_BOARD_NO.nextval, '전체 회식합니다.', '차태연', '금일 전체 회식있습니다. 모두 참여바랍니다.', null, null, to_date('20200501', 'yyyymmdd'), 365);
insert into board values (SEQ_BOARD_NO.nextval, '분실물 찾습니다.', '방명수', '3층에서 아이패드 분실했습니다. 발견하시는 분은 연락부탁드립니다.', null, null, to_date('20200513', 'yyyymmdd'), 16);
insert into board values (SEQ_BOARD_NO.nextval, '이송팀 장쯔위사원 결혼합니다.', '하동윤', '이번주 토요일 kh예식장에서 결혼합니다. 모두 축하해주세요.', null, null, to_date('20200520', 'yyyymmdd'), 50);
insert into board values (SEQ_BOARD_NO.nextval, '여름휴가 공지', '선동일', '여름휴가 7월 1일 ~ 7월 8일까지입니다.', null, null, to_date('20200615', 'yyyymmdd'), 77);
insert into board values (SEQ_BOARD_NO.nextval, '워크샵 공지', '선동일', '워크샵 8월 1일~8월2일 1박 2일입니다. 모두 참여바랍니다.', null, null, sysdate, 365);

select * from board;
commit;



-- 댓글
create table board_comment(
    board_comment_no number,
    board_comment_level number default 1,
    board_comment_writer varchar2(15),
    board_comment_content varchar2(2000),
    board_ref number,
    board_comment_ref number,
    board_comment_date date default sysdate,
    constraints pk_board_comment primary key(board_comment_no),
    constraints fk_board_ref foreign key (board_ref) references board(board_no) on delete cascade,
    constraints fk_board_comment_ref foreign key (board_comment_ref) references board_comment(board_comment_no) on delete cascade
);

create sequence seq_board_comment;

--글번호 확인후 insert해야함..
insert into board_comment values (seq_board_comment.nextval, 1, '전형돈', '넵! 꼭 참여하겠습니다 대표님!', 1, null, to_date('20200501', 'yyyymmdd'));
insert into board_comment values (seq_board_comment.nextval, 1, '송은희', '제가 보관중입니다.', 2, null, to_date('20200514', 'yyyymmdd'));
insert into board_comment values (seq_board_comment.nextval, 1, '방명수', '쯔위님 축하드려요~', 3, null, to_date('20200501', 'yyyymmdd'));
insert into board_comment values (seq_board_comment.nextval, 1, '박나라', '축하드립니다~', 3, null, to_date('20200501', 'yyyymmdd'));
insert into board_comment values (seq_board_comment.nextval, 1, '대북혼', '모두 즐거운 여름휴가 보내세요.', 4, null, to_date('20200615', 'yyyymmdd'));
insert into board_comment values (seq_board_comment.nextval, 1, '하이유', '워크샵 기대됩니다 ㅎㅎ', 5, null, sysdate);
insert into board_comment values (seq_board_comment.nextval, 2, '방명수', '감사합니다. 연락드리겠습니다.', 2, 2, to_date('20200514', 'yyyymmdd'));


select * from board_comment;

-----------------------------
---------- trigger ----------
-----------------------------
/* 입고시 재고량 수정 트리거 */
create or replace trigger trig_warehousing
    after
    insert on warehousing
    for each row
begin
    if :new.w_reason = 'S' then
        update stock set s_amount = s_amount + :new.w_amount
        where p_code = :new.p_code and (select c_code from center where c_code = :new.c_code) = c_code;
    end if;
end;
/

/* 일반 출고시 재고량 수정, 발주상태 수정 트리거 */
create or replace trigger trig_be_released_to_shop
    after
    insert on be_released
    for each row
begin
    if :new.r_reason = '매장출고' then
        update stock set s_amount = s_amount - :new.r_amount
        where p_code = :new.p_code and (select c_code from ordr where o_code = :new.o_code) = c_code;
        update ordr set o_status = 'C'
        where o_code = :new.o_code;
    end if;
end;
/

select * from ordr;



/* 1. 이송요청시 출고 트리거 */
create or replace trigger trg_transfer
for update on transfer
compound trigger  
    n_t_code varchar2(20);
    n_p_code varchar2(20);
    n_t_amount number;
  after each row is
  begin
   n_t_code := :new.t_code;
   n_p_code := :new.p_code;
   n_t_amount := :new.t_amount;
  end after each row;
  after statement is
  begin
        insert into be_released values (seq_be_released.nextval, null, n_t_code, n_p_code, n_t_amount, '이송출고', sysdate);
  end after statement;
end trg_transfer;
/

select * from transfer;
update transfer set t_status='C' where t_code = 1051;

select * from be_released;

/* 2. 이송 출고시 재고량 수정 트리거 */
-- mutating error로 compound trigger 사용
create or replace trigger trig_be_released_by_transfer
for insert on be_released
compound trigger  
    n_r_reason varchar2(20);
    n_r_amount number;
    n_p_code varchar2(20);
    n_t_code varchar2(20);
  after each row is
  begin
   n_r_reason := :new.r_reason;
   n_r_amount := :new.r_amount;
   n_p_code := :new.p_code;
   n_t_code := :new.t_code;
  end after each row;
  after statement is
  begin
    if n_r_reason = '이송출고' then
        update stock set s_amount = s_amount + n_r_amount
        where p_code = n_p_code and (select destination_code from be_released  join transfer using (t_code) where t_code = n_t_code) = c_code;
        update stock set s_amount = s_amount - n_r_amount
        where p_code = n_p_code and (select departure_code from be_released  join transfer using (t_code) where t_code = n_t_code) = c_code;
    end if;
  
  end after statement;
end trig_be_released_by_transfer;
/




-------------------------------
---------- scheduler ----------
-------------------------------
-- 텀블러 매주 금요일 4개씩 입고
create or replace procedure warehousing_tumblr is
begin
    insert into warehousing values(seq_warehousing.nextval, 'CT001', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CT001', 'TK', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CT002', 'GG', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CT002', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CT003', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CT003', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CT004', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CT004', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CT005', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CT005', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CT006', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CT006', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CT007', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CT007', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CT008', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CT008', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'ST001', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST001', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'ST002', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST002', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'ST003', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST003', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'ST004', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST004', 'TK', 4, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'ST005', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST005', 'TK', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST006', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST006', 'TK', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST007', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST007', 'TK', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST008', 'GG', 4, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'ST008', 'TK', 4, 'S', sysdate);
end;
/

begin
dbms_scheduler.create_job 
(
    job_name => 'warehousing_tumblr_job',
    job_type => 'plsql_block',
    job_action => 'begin warehousing_tumblr; end;',
    start_date => systimestamp,
    repeat_interval => 'freq=weekly; byday=fri'
);
end;
/

-- 머그 매주 월요일 5개 입고
create or replace procedure warehousing_mug is
begin
    insert into warehousing values(seq_warehousing.nextval, 'CM001', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CM001', 'TK', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CM002', 'GG', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CM002', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CM003', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CM003', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CM004', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CM004', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CM005', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CM005', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CM006', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CM006', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CM007', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CM007', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CM008', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CM008', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'SM001', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SM001', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'SM002', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SM002', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'SM003', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SM003', 'TK', 5, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'SM004', 'GG', 5, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SM004', 'TK', 5, 'S', sysdate);
end;
/

begin
dbms_scheduler.create_job 
(
    job_name => 'warehousing_mug_job',
    job_type => 'plsql_block',
    job_action => 'begin warehousing_mug; end;',
    start_date => systimestamp,
    repeat_interval => 'freq=weekly; byday=mon'
);
end;
/

-- 머그 매주 수요일 3개 입고
create or replace procedure warehousing_glass is
begin
    insert into warehousing values(seq_warehousing.nextval, 'CG001', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CG001', 'TK', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CG002', 'GG', 3, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CG002', 'TK', 3, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'CG003', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'CG003', 'TK', 3, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'SG001', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SG001', 'TK', 3, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'SG002', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SG002', 'TK', 3, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'SG003', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SG003', 'TK', 3, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'SG004', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SG004', 'TK', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SG005', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'SG005', 'TK', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'RG001', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'RG001', 'TK', 3, 'S', sysdate);
    insert into warehousing values(seq_warehousing.nextval, 'RG002', 'GG', 3, 'S', sysdate);
	insert into warehousing values(seq_warehousing.nextval, 'RG002', 'TK', 3, 'S', sysdate);
end;
/

begin
dbms_scheduler.create_job 
(
    job_name => 'warehousing_glass_job',
    job_type => 'plsql_block',
    job_action => 'begin warehousing_glass; end;',
    start_date => systimestamp,
    repeat_interval => 'freq=weekly; byday=wed'
);
end;
/

----실행
--exec dbms_scheduler.enable('warehousing_tumblr_job');
--exec dbms_scheduler.run_job('warehousing_tumblr_job');
--exec dbms_scheduler.enable('warehousing_mug_job');
--exec dbms_scheduler.run_job('warehousing_mug_job');
--exec dbms_scheduler.enable('warehousing_glass_job');
--exec dbms_scheduler.run_job('warehousing_glass_job');
--
---- 일시중지
--exec dbms_scheduler.disable('warehousing_tumblr_job');
--exec dbms_scheduler.disable('warehousing_mug_job');
--exec dbms_scheduler.disable('warehousing_glass_job');
--
---- 다시실행
--exec dbms_scheduler.enable('warehousing_tumblr_job');
--exec dbms_scheduler.enable('warehousing_mug_job');
--exec dbms_scheduler.enable('warehousing_glass_job');



select * from be_released;
select * from ordr;
select * from product;
select * from shop;
select * from warehousing;
select * from center;
select * from product_detail;
select * from stock;
select * from employee;
select * from transfer;
select * from product;
select * from memo;
select * from board;
select * from board_comment;
select * from transfer;
select * from tab;
select * from calendar;

commit;



