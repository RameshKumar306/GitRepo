use bank;

create table customer(
cid varchar(6) primary key not null,
fname varchar(30),
mname varchar(30),
lname varchar(30),
city varchar(15),
mobile varchar(10),
occupation varchar(10),
dob date
);

insert into customer values('C00001','Ramesh','Chandra','Sharma','Delhi','9543198345','Service','1976-12-06');
insert into customer values('C00002','Avinash','Sunder','Minha','Delhi','9876532109','Service','1974-10-16');
insert into customer values('C00003','Rahul','null','Rastogi','Delhi','9765178901','Student','1981-09-26');
insert into customer values('C00004','Parul','null','Gandhi','Delhi','9876532109','Housewife','1976-11-03');
insert into customer values('C00005','Naveen','Chandra','Aedekar','Mumbai','8976523190','Service','1976-09-19');
insert into customer values('C00006','Chitresh','null','Barwe','Mumbai','7651298761','Student','1992-11-06');
insert into customer values('C00007','Amit','Kumar','Borkar','Mumbai','9875189761','Student','1981-09-06');
insert into customer values('C00008','Nisha','null','Damle','Mumbai','7954198761','Service','1975-12-03');
insert into customer values('C00009','Abhishek','null','Dutta','Kolkata','9856198761','Service','1973-05-22');
insert into customer values('C00010','Shankar','null','Nair','Chennai','8765489076','Service','1976-07-12');

create table branch(
bid varchar(6) primary key not null,
bname varchar(30),
bcity varchar(30) 
);

insert into branch values('B00001','Asaf ali road','Delhi');
insert into branch values('B00002','New delhi main branch','Delhi');
insert into branch values('B00003','Delhi cantt','Delhi');
insert into branch values('B00004','jasola','Delhi');
insert into branch values('B00005','Mahim','Mumbai');
insert into branch values('B00006','Ville parle','Mumbai');
insert into branch values('B00007','Mandvi','Kolkata');
insert into branch values('B00008','Jadavpur','Delhi');
insert into branch values('B00009','Kodambakkam','Chennai');

create table ac(
ac_no varchar(6) primary key not null,
cid varchar(6),
bid varchar(6),
o_balance int,
aod date,
atype varchar(10),
astatus varchar(10),
foreign key(cid) references customer(cid) on delete cascade,
foreign key(bid) references branch(bid) on delete cascade
);

insert into ac values('A00001','C00001','B00001','1000','2012-12-15','Saving','Active');
insert into ac values('A00002','C00002','B00001','1000','2012-06-12','Saving','Active');
insert into ac values('A00003','C00003','B00002','1000','2012-05-17','Saving','Active');
insert into ac values('A00004','C00002','B00005','1000','2013-01-27','Saving','Active');
insert into ac values('A00005','C00006','B00006','1000','2012-12-17','Saving','Active');
insert into ac values('A00006','C00007','B00007','1000','2010-08-12','Saving','Suspended');
insert into ac values('A00007','C00007','B00001','1000','2012-10-02','Saving','Active');
insert into ac values('A00008','C00001','B00003','1000','2009-11-09','Saving','Terminated');
insert into ac values('A00009','C00003','B00007','1000','2008-11-30','Saving','Terminated');
insert into ac values('A00010','C00004','B00002','1000','2013-03-01','Saving','Active');

create table loan(
cid varchar(6),
bid varchar(6),
loan_amt int,
foreign key(cid) references customer(cid) on delete cascade,
foreign key(bid) references branch(bid) on delete cascade
);

insert into loan values('C00001','B00001','100000');
insert into loan values('C00002','B00002','200000');
insert into loan values('C00009','B00008','400000');
insert into loan values('C00010','B00009','500000');
insert into loan values('C00001','B00003','600000');
insert into loan values('C00002','B00001','600000');

# Solution1:
alter table ac
add foreign key(cid) references customer(cid) on delete cascade;

# Solution2:
alter table ac
remove foreign key(cid) references customer(cid) on delete cascade;

# Solution3:
select cid,fname,dob from customer
order by dob asc;

# Soution4:
select ac_no,fname,lname,aod from customer
inner join ac
on ac.cid=customer.cid;

# Solution5:
select count(fname) as cus_count from customer where city = "Delhi";

# Solution6:
select ac_no, fname from customer
inner join ac
on ac.cid = customer.cid
where date(aod)>15;

# Solution7:
select bcity,count(bid) as count_branch from branch group by bcity;

# Solution8:
select ac_no,fname,lname from customer
inner join ac
on ac.cid = customer.cid
where astatus = "Active";

# Solution9:
select mobile,fname, loan_amt from customer
inner join loan
on loan.cid = customer.cid
inner join branch
on branch.bid=loan.bid;

# Solution10:
select ac_no,fname,mobile from customer
inner join ac
on ac.cid = customer.cid
where astatus = "Terminated";

# Solution11:
select fname,mobile,city,bcity from customer
inner join ac
on customer.cid=ac.cid
inner join branch
on ac.bid=branch.bid
where city not in (select bcity from branch);

# Solution12:
select fname,mobile,lname from customer
inner join loan
on loan.cid=customer.cid
group by loan.cid
having count(loan.cid)>1;

# Solution13:
select fname from customer
inner join ac
on ac.cid=customer.cid;

# Solution14:
select fname from customer
inner join ac
on ac.cid = customer.cid
inner join loan
on loan.cid = customer.cid
inner join branch
on branch.bid = loan.bid
where city = "Mumbai" and bname = "Mandvi" and astatus="Suspended";

# Solution15:
select fname from customer
inner join loan
on customer.cid = loan.cid
where occupation="Student";

# Solution16:
select fname from customer
inner join loan
on loan.cid=customer.cid
inner join branch
on branch.bid = loan.bid
where city = "delhi" and occupation="service" and bname="asaf ali road";

# Solution17:
select * from customer where mname = "null";