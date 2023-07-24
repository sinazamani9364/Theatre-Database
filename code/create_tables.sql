



create table Person (

    first_name NVARCHAR(max) NOT NULL,

    last_name  NVARCHAR(max) NOT NULL,

    -- ssn should be 10 digit length
    ssn bigINT NOT NULL CHECK(ssn BETWEEN 1000000000 and 9999999999),

    birthday DATE check(getdate()>=birthday),

    gender char not null check(gender = 'M' or gender = 'F'),

    phone varchar(11) NOT NULL UNIQUE, 

    CONSTRAINT chk_phone CHECK (phone like '09[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),

    PRIMARY KEY (ssn)
)

-- insert data to check the violations :

-- check ssn :
-- INSERT into Person
-- VALUES('Baktash','Ansari',250115849,'1381-02-14','M','09372531745');

-- check date :
-- INSERT into Person
-- VALUES('Baktash','Ansari',4150115849,'2023-02-14','M','09372531742');

-- check gender :
-- INSERT into Person
-- VALUES('Baktash','Ansari',5150115849,'1381-02-14','g','09372531742');

-- check phone :
-- INSERT into Person
-- VALUES('Baktash','Ansari',9150115849,'1381-02-14','M','08372531748');

---------------------------------------------------------------------------------------------------

create table Customers(

    score bigINT default 0 check (score >-1 and score < 101),

    ssn bigINT NOT NULL UNIQUE CHECK(ssn BETWEEN 1000000000 and 9999999999),

    Customer_id INT IDENTITY(1,1) not null PRIMARY key ,

    FOREIGN KEY (ssn) REFERENCES Person(ssn)

)

---------------------------------------------------------------------------------------------------

create table Actor(

    ssn bigINT NOT NULL  CHECK(ssn BETWEEN 1000000000 and 9999999999),

    Actor_id INT IDENTITY(1,1) not null PRIMARY key ,

    FOREIGN KEY (ssn) REFERENCES Person(ssn)
)

---------------------------------------------------------------------------------------------------

create table Director(

    ssn bigINT NOT NULL  CHECK(ssn BETWEEN 1000000000 and 9999999999),

    Director_id INT IDENTITY(1,1) not null PRIMARY key ,

    FOREIGN KEY (ssn) REFERENCES Person(ssn)
)

---------------------------------------------------------------------------------------------------

-- drop table dbo.Exe_mem

create table Exe_mem(

    ssn bigINT NOT NULL  CHECK(ssn BETWEEN 1000000000 and 9999999999),

    Exe_mem_id INT IDENTITY(1,1) not null PRIMARY key ,

    FOREIGN KEY (ssn) REFERENCES Person(ssn)
)

---------------------------------------------------------------------------------------------------

-- drop table dbo.Aadmin
create table Aadmin(

    ssn bigINT NOT NULL  CHECK(ssn BETWEEN 1000000000 and 9999999999),

    Admin_id INT IDENTITY(1,1) not null PRIMARY key ,

    theater_id int ,

    FOREIGN KEY (theater_id) REFERENCES Theater(theater_id),

    FOREIGN KEY (ssn) REFERENCES Person(ssn)
)

---------------------------------------------------------------------------------------------------

create table Theater(

    theater_id INT IDENTITY(1,1) not null PRIMARY KEY,

    tname nvarchar(max) not null ,

    open_time TIME not null ,

    close_time TIME not null,

    addr nvarchar(150) not null,

    capacity INT not null check(capacity>=0),

    rate int default 0 check(rate>=0 and rate<=100),

)

---------------------------------------------------------------------------------------------------

create table Show(

    show_id Int IDENTITY(1,1) not null primary key,

    title NVARCHAR(max) not null,

    genre VARCHAR(max) not null check(dbo.genre_check(genre) = 1),

    rate int default 0 check(rate>=0 and rate<=100),

    age_limit VARCHAR(max) not null check(dbo.age_check(age_limit) = 1),

    poster_name NVARCHAR (100) DEFAULT NULL,

    -- saving poster file in binary type 
    poster_file varbinary(max) DEFAULT NULL,

    summary TEXT not null,

    start_show TIME not null,

    end_time TIME not null,

    sale_rate INT DEFAULT 0 not null ,

)



---------------------------------------------------------------------------------------------------

create table Advertisment(

    ad_id int IDENTITY(1,1) not null primary KEY,

    ad_file varbinary(max) default NULL,

    link VARCHAR(200) check(dbo.IsValidURL(link) = 1),

    title NVARCHAR(MAX) NOT NULL,

    duration INT not null check(duration>0 and duration<=60), -- based on secconds, up to one minute 

)

---------------------------------------------------------------------------------------------------

create table Sponsored(

    s_id int IDENTITY(1,1) not null primary key,
    
    price money not null,

    ad_id int not null,

    FOREIGN KEY (ad_id) REFERENCES Advertisment(ad_id),

    company_name nvarchar(max) NOT NULL,

)

---------------------------------------------------------------------------------------------------

create table Show_based(


    show_name varchar(20),
    ad_id int not null primary key,

    show_id int ,

    FOREIGN KEY (ad_id) REFERENCES Advertisment(ad_id),

    -- has relation 1:N
    FOREIGN KEY (show_id) REFERENCES Show(show_id),

)

---------------------------------------------------------------------------------------------------

-- Weak entity types : 

create table Ticket(

    tracking_id int IDENTITY(1,1) not null,

    show_id INT not null,

    customer_id INT not null,

    FOREIGN KEY (show_id) REFERENCES Show(show_id),

    FOREIGN KEY (customer_id) REFERENCES Customers(Customer_id),

    start_time time not null,

    buy_time time not null,

    price money not null,
	primary key (tracking_id, show_id),

    row_position int not null check(row_position>0),

    column_position int not null check(column_position>0),


)

---------------------------------------------------------------------------------------------------

create table Seat(

    seat_id int IDENTITY(1,1) not null,

    theater_id int not null,

    is_sold bit default 0 not null,

    row_position int not null check(row_position>0),

    column_position int not null check(column_position>0),
	primary key (seat_id, theater_id),

    FOREIGN KEY (theater_id) REFERENCES Theater(theater_id),

)

---------------------------------------------------------------------------------------------------

-- Relations : 

create table watch(

    customer_id int ,

    show_id int ,

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),

    FOREIGN KEY (show_id) REFERENCES Show(show_id),
	primary key(customer_id, show_id)

)

---------------------------------------------------------------------------------------------------

create table theater_has_sponsored(

    theater_id int ,

    s_id int ,

    FOREIGN KEY (theater_id) REFERENCES Theater(theater_id),
    
    FOREIGN KEY (s_id) REFERENCES Sponsored(s_id),
	primary key(theater_id, s_id)
)

---------------------------------------------------------------------------------------------------


-- relation between show and Theater
create table Hold(

    theater_id int ,

    FOREIGN KEY (theater_id) REFERENCES Theater(theater_id),

    show_id INT ,

    FOREIGN KEY (show_id) REFERENCES Show(show_id),

    play_date date ,
	primary key(theater_id, show_id)
)

---------------------------------------------------------------------------------------------------


create table Plays(

    show_id INT ,

    FOREIGN KEY (show_id) REFERENCES Show(show_id),

    Actor_id int,

    FOREIGN KEY (Actor_id) REFERENCES Actor(Actor_id),
	primary key(show_id, Actor_id)
)

---------------------------------------------------------------------------------------------------


create table Directs(

    show_id INT ,

    FOREIGN KEY (show_id) REFERENCES Show(show_id),

    Director_id int,

    FOREIGN KEY (Director_id) REFERENCES Director(Director_id),
	primary key(show_id, Director_id)
)

---------------------------------------------------------------------------------------------------


create table Works_in(

    show_id INT ,

    FOREIGN KEY (show_id) REFERENCES Show(show_id),

    Exe_mem_id int,

    FOREIGN KEY (Exe_mem_id) REFERENCES Exe_mem(Exe_mem_id),
	primary key(show_id, Exe_mem_id)
)