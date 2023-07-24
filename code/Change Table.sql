-- Update Table
--1
ALTER TABLE Customers
ADD email varchar(255)

--2
ALTER TABLE Sponsored
ADD [address] varchar(max)


-- Update Rows
--1
Update Person
set first_name = 'ali'
where ssn = 1825362274

--2
Update Show
set genre = 'Drama'
where show_id = 5

-- Delete From Table
--1
Delete from Seat 
where row_position = 3

--2
Delete from Ticket
where start_time > '20:30:00.0000000'