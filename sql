------------------------------------------������
drop table member;
create table member(
member_no number primary key,
member_id varchar2(20) not null unique,
member_pw varchar2(60) not null,
member_name varchar2(21) not null,
member_email varchar2(320) not null unique,
member_phone varchar2(11) not  null unique,
member_birth varchar2(8) not null,
member_join_date date default sysdate,
member_last_login date default sysdate,
member_agree_date date not null,
member_grade varchar2(20) default '�Ϲ�'
);

drop sequence member_seq;
create sequence member_seq;

----------------------------------------------ȸ�� ����� ����
drop table member_addr;
create table member_addr(
member_addr_no number primary key,
member_name_extra varchar2(21),
member_addr_post varchar2(6) not null,
member_addr_basic varchar2(150) not null,
member_addr_extra varchar2(150) not null,
member_addr_status varchar2(15) not null check(member_addr_status in('�⺻�ּ�', '�߰��ּ�')),
member_no constraint fk_member_member_addr references member(member_no) on delete set null
);
create sequence member_addr_seq;

---------------------------------------------ȸ�� ����Ʈ
drop table member_point;
create table member_point(
member_point_no number primary key,
member_point_status varchar2(15) not null,
member_point_date date default sysdate,
member_point_limit date,
member_point_change number not null,
member_point_content varchar2(300),
member_no CONSTRAINT fk_member_member_point REFERENCES member(member_no)on delete set null
);
create sequence member_point_seq;


---------------------------------------------������
drop table admin;
create table admin(
admin_no number primary key,
admin_id varchar2(20) not null,
admin_pw varchar2(60) not null,
admin_name varchar2(21) not null,
admin_email varchar2(320) not null,
admin_grade varchar2(20) not null,
admin_join_date date default sysdate,
admin_last_login date default sysdate
);

create sequence admin_seq;


---------------------------------------------�ֹ�����
drop table custom_order;
create table custom_order(
custom_order_no number primary key,
custom_order_title varchar2(100) not null, 
custom_order_content varchar2(4000) not null,
custom_order_date date default sysdate,
custom_order_price number default 0 not null,
custom_order_hopedate varchar2(30) not null,
custom_order_status varchar2(15),
custom_order_type varchar2(15) not null check(custom_order_type in('��û��', '������')) 

);

create sequence custom_order_seq;

---------------------------------------------��û�� �������̺�
drop table member_custom_order;
create table member_custom_order(
member_custom_order_no number primary key,
member_no CONSTRAINT fk_member_member_custom_order REFERENCES member(member_no) on delete set null,
custom_order_no CONSTRAINT fk_custom_order_custom_order REFERENCES custom_order(custom_order_no) on delete set null
);

create sequence member_custom_order_seq;

---------------------------------------------������ �������̺�
drop table seller_custom_order;
create table seller_custom_order(
seller_custom_order_no number primary key,
custom_order_no CONSTRAINT fk_custom_seller_order REFERENCES custom_order(custom_order_no) on delete set null,
seller_no CONSTRAINT fk_seller_seller_custom_order REFERENCES seller(seller_no) on delete set null
);


drop table seller_custom_order;

---------------------------------------------������ �˶�
drop table member_alarm;
create table member_alarm(
member_alarm_no number primary key,
member_alarm_date date,
member_alarm_check varchar2(1) check(member_alarm_check in ('Y', 'N')),
member_alarm_delete varchar2(1)check(member_alarm_delete in ('Y', 'N')),
member_no CONSTRAINT fk_member_alarm_member REFERENCES member(member_no) on delete set null,
seller_custom_order_no CONSTRAINT fk_custom_alarm REFERENCES seller_custom_order(seller_custom_order_no) on delete set null

);

create sequence member_alarm_seq;

---------------------------------------------�Ǹ��� �˶�
drop table seller_alarm;
create table seller_alarm(
seller_alarm_no number primary key,
seller_no CONSTRAINT fk_seller_custom_alarm REFERENCES seller(seller_no) on delete set null,
member_custom_order_no CONSTRAINT fk_seller_alarm_member REFERENCES member_custom_order(member_custom_order_no) on delete set null,
seller_alarm_date date,
seller_alarm_check varchar2(1) check(seller_alarm_check in ('Y', 'N')),
seller_alarm_delete varchar2(1) check(seller_alarm_delete in ('Y', 'N'))
);

create sequence seller_alarm_seq;

---------------------------------------------�������� �Խ���
drop table admin_qna;
create table admin_qna(
admin_qna_no number primary key,
seller_no CONSTRAINT fk_qna_seller REFERENCES seller(seller_no) on delete set null,
member_no CONSTRAINT fk_qna_member REFERENCES member(member_no) on delete set null,
admin_no CONSTRAINT fk_qna_admin REFERENCES admin(admin_no) on delete set null,
admin_qna_content varchar2(4000) not null,
admin_qna_title varchar2(300) not null,
admin_qna_writer varchar2(21) not null,
admin_qna_usertype varchar2(9) not null,
admin_qna_date date default sysdate,
admin_qna_head varchar2(15),
group_no number,
super_no number
);

create sequence admin_qna_seq;

---------------------------------------------����
create table files(
files_no number primary key,
files_size number,
files_savename varchar2(255),
files_uploadname varchar2(255)
);

create sequence files_seq;

---------------------------------------------�ֹ����� ����

drop table file_custom_order;
create table files_custom_order(
files_no CONSTRAINT fk_files_custom REFERENCES files(files_no) on delete set null,
custom_order_no CONSTRAINT fk_custom_order_file REFERENCES custom_order(custom_order_no) on delete set null

);

---------------------------------------------��Ʈ������ ����
drop table portfolio;
create table portfolio(
seller_no CONSTRAINT fk_seller_portfolio REFERENCES seller(seller_no) on delete set null,
files_no CONSTRAINT fk_files_portfolio REFERENCES files(files_no) on delete set null
);

---------------------------------------------��ǰ���� ����
create table files_goods(
files_no CONSTRAINT fk_files_files_goods REFERENCES files(files_no) on delete set null,
goods_no CONSTRAINT fk_files_goods REFERENCES goods(goods_no) on delete set null
);

---------------------------------------------��ǰ ��� ����
create table delivery(
delivery_no number primary key,
delivery_agree varchar2(1) check (delivery_agree in('Y', 'N')),
delivery_set_agree varchar2(1) check (delivery_set_agree in('Y', 'N')),
delivery_company varchar2(30),
delivery_price number,
delivery_option varchar2(15),
delivery_return_set_op_price number,
delivery_return_price number,
goods_no CONSTRAINT fk_delivery_goods REFERENCES goods(goods_no) on delete set null,
seller_no CONSTRAINT fk_seller_delivery REFERENCES seller(seller_no) on delete set null
);

create sequence delivery_seq;

---------------------------------------------����Խ���
create table goods_review(
goods_review_no number primary key,
goods_review_content varchar2(4000),
goods_review_writer varchar2(20) not null,
goods_review_date date default sysdate,
goods_review_star number default 0 not null,
goods_no CONSTRAINT fk_goods_goods_review REFERENCES goods(goods_no) on delete set null,
ordering_no CONSTRAINT fk_ordering_goods_review REFERENCES ordering(ordering_no) on delete set null
);

create sequence goods_review_seq;

---------------------------------------------���� ���

create table goods_review_reply(
goods_review_reply_no number primary key,
goods_review_reply_content varchar2(4000),
goods_review_reply_writer varchar2(21),
goods_review_reply_date date default sysdate,
goods_review_no CONSTRAINT fk_goods_reply_review REFERENCES goods_review(goods_review_no) on delete set null
);

create sequence goods_review_reply_seq;

---------------------------------------------���� ����

create table files_goods_review(
goods_review_no CONSTRAINT fk_goods_review_files REFERENCES goods_review(goods_review_no) on delete set null,
files_no CONSTRAINT fk_files_goods_review REFERENCES files(files_no) on delete set null

);

-------------------------------------------------
drop table seller;
drop table category;
drop table seller_category;
drop table goods;
drop table goods_option;
drop table non;
drop table ordering;
drop table goods_cart;
drop table option_cart;
drop table ordering_info;





---------------------------------------------------- �Ǹ��� ���̺� 

create table seller(
seller_no number primary key,
seller_id varchar2(20) not null unique,
seller_pw varchar2(60) not null,
seller_name varchar2(21) not null,
seller_email varchar2(320) not null unique,
seller_phone varchar2(11) not null unique,
seller_birth varchar2(13) not null unique,
seller_addr_post varchar2(6) not null,
seller_addr_basic varchar2(150) not null,
seller_addr_extra varchar2(150) not null,
seller_store_name varchar2(60) not null unique,
seller_store_phone varchar2(11) not null unique,
seller_store_fax varchar2(20),
seller_join_date date default sysdate not null,
seller_last_login date,
seller_agree_date date not null,
seller_grade varchar2(20) default '�Ϲ�',
seller_cid varchar2(10) not null,
seller_bank_code varchar2(3) not null,
seller_bank_account varchar2(16) not null unique,
seller_bank_username varchar2(21) not null,
seller_bank_birth varchar2(13) not null unique
);

create sequence seller_seq;
commit;



---------------------------------------------------- ī�װ���
create table category(
category_no number primary key,
category_large varchar2(30) not null,
category_middle varchar2(30) not null,
category_small varchar2(30) not null
);

create sequence category_seq;
commit;



---------------------------------------------------- �Ǹ���-ī�װ��� ����
create table seller_category(
category constraint fk_category_seller_category_no references category(category_no) on delete set null,
seller constraint fk_seller_seller_category_no references seller(seller_no) on delete set null
);
commit;



---------------------------------------------------- ��ǰ
create table goods(
goods_no number primary key,
seller constraint fk_seller_goods_no references seller(seller_no) on delete set null,
goods_name varchar2(150) not null,
goods_price number not null,
goods_discount_price number default 0,
goods_discount_start date,
goods_discount_finish date,
goods_stock number default 0,
goods_status varchar2(1) default 'Y' not null,
goods_content varchar2(4000)
);

create sequence goods_seq;
commit;




---------------------------------------------------- �ɼ�
create table goods_option(
goods_option_no number primary key,
goods constraint fk_goods_goods_option_no references goods(goods_no) on delete set null,
goods_option_title varchar2(100) not null,
goods_option_content varchar2(100),
goods_option_price number default 0 not null,
goods_option_stock number default 0 not null,
goods_option_status varchar2(1) default 'Y' not null
);

create sequence goods_option_seq;
commit;



---------------------------------------------------- ��ȸ�� ����
create table non(
non_no number primary key,
non_pw varchar2(60) not null,
non_name varchar2(21) not null,
non_name_extra varchar2(21) not null,
non_email varchar2(320) not null,
non_phone varchar2(11) not null,
non_addr_post varchar2(6),
non_addr_basic varchar2(150),
non_addr_extra varchar2(150),
non_agree_date date not null
);

create sequence non_seq;
commit;






---------------------------------------------------- �ֹ�����
create table ordering(
ordering_no number primary key,
member constraint fk_member_ordering references member(member_no) on delete set null,
non constraint fk_non_ordering references non(non_no) on delete set null,
cid varchar2(20) not null,
tid varchar2(10) not null,
aid varchar2(20) not null,
partner_order_id varchar2(100) not null,
partner_user_id varchar2(100) not null,
item_name varchar2(100) not null,
quantity number not null,
total_amount number not null,
tax_free_amount number not null,
vat_amount number not null,
install_month number default 0 not null,
ordering_status varchar(2) not null,
process_time date default sysdate not null,
used_point number default 0 not null
);

create sequence ordering_seq;
commit;






---------------------------------------------------- ��ǰ ��ٱ���
create table goods_cart(
goods_cart_no number primary key,
member constraint fk_member_goods_cart references member(member_no) on delete set null,
goods constraint fk_goods_goods_cart references goods(goods_no) on delete set null,
goods_cart_quantity number default 0 not null
);

create sequence goods_cart_seq;
commit;






---------------------------------------------------- �ɼ� ��ٱ���
create table option_cart(
option_cart_no number primary key,
goods_cart constraint fk_goods_cart_option_cart references goods_cart(goods_cart_no) on delete set null,
option_cart_quantity number default 0 not null
);

create sequence option_cart_seq;
commit;






---------------------------------------------------- �ֹ��󼼳���
create table ordering_info(
ordering_info_no number primary key,
ordering constraint fk_ordering_ordering_info references ordering(ordering_no) on delete set null,
goods constraint fk_goods_ordering_info references goods(goods_no) on delete set null,
member constraint fk_member_ordering_info references member(member_no) on delete set null
);







---------------------------------------------------- �ֹ��󼼳���-�ɼ�
-- �ܷ�Ű ordering_info -> info (�̸��� �ʹ� ��..)
create table ordering_info_op(
ordering_info_op_no number primary key,
ordering_info constraint fk_info_info_op references ordering_info(ordering_info_no) on delete set null,
goods_option constraint fk_goods_option_info_op references goods_option(goods_option_no) on delete set null,
goods constraint fk_goods_info_op references goods(goods_no) on delete set null,
member constraint fk_member_info_op references member(member_no) on delete set null,
non constraint fk_non_info_op references non(non_no) on delete set null,
ordering_info_op_quantity number default 0 not null
);

create sequence ordering_info_op_seq;
commit;





---------------------------------------------------- ����
create table calculate(
calculate_no number primary key,
ordering constraint fk_ordering_calculate references ordering(ordering_no) on delete set null,
member constraint fk_member_calculate references member(member_no) on delete set null,
non constraint fk_non_calculate references non(non_no) on delete set null,
calculate_start date not null,
calculate_finish date not null,
calculate_ok_date date not null,
calculate_status varchar2(15) not null,
calculate_total number not null,
calculate_exception number default 0 not null,
calculate_final number not null
);

create sequence calculate_seq;
commit;






---------------------------------------------------- ������
create table premium(
premium_no number primary key,
premium_price number default 0 not null,
premium_rate number default 0 not null
);

create sequence premium_seq;
commit;






---------------------------------------------------- ��ǰ���ǰԽ���
create table goods_qna(
goods_qna_no number primary key,
goods constraint fk_goods_goods_qna references goods(goods_no) on delete set null,
seller constraint fk_seller_goods_qna references seller(seller_no) on delete set null,
goods_qna_content varchar2(4000) not null,
goods_qna_writer varchar2(21) not null,
goods_qna_date date default sysdate not null,
goods_qna_head varchar2(15),
goods_qna_groupno number,
goods_qna_superno number
);

create sequence goods_qna_seq;
commit;








