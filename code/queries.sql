

--1
select * from Theater

--2
select * from Aadmin
where theater_id = 6
go

--3
create procedure get_theater_name_and_rating @ssn bigint
AS
begin
	select tname, t.rate
	from (Actor a inner join Plays p on a.Actor_id = p.Actor_id)
		inner join Hold h on p.show_id = h.show_id
		inner join Theater t on h.theater_id = t.theater_id
	where a.ssn = @ssn
END
go

get_theater_name_and_rating @ssn = 2266083565;

--4
select Director_id, t.rate
from (Directs d join Show s on d.show_id = s.show_id) 
    join (Theater t join Hold h on h.theater_id = t.theater_id) 
    on s.show_id = h.show_id
where Director_id not IN (select Director_id
					from (Directs d join Show s on d.show_id = s.show_id) 
						join (Theater t join Hold h on h.theater_id = t.theater_id) 
						on s.show_id = h.show_id
						where t.rate <= 50);

--5
select first_name, last_name
from (Plays pl inner join Actor a on pl.Actor_id = a.Actor_id) 
	inner join Person p
	on a.ssn = p.ssn
    inner join Hold h 
    on pl.show_id = h.show_id 
where h.theater_id = 4

--6
select tracking_id
from Ticket t inner join Show s on t.show_id = s.show_id
where DatePart(hour, s.end_time) - DatePart(hour, s.start_show) > 1;

--7
select p.ssn, DatePart(year, GETDATE()) - DatePart(year, birthday) - 622 as age
from (Customers c inner join Watch w on c.Customer_id = w.customer_id) 
	inner join Person p
	on c.ssn = p.ssn
    inner join (Show s inner join Hold h on s.show_id = h.show_id) 
    on w.show_id = s.show_id
where h.theater_id = 3

--8
select Director_id, COUNT(show_id) as cnt
from Directs
GROUP BY Director_id
ORDER BY Director_id DESC

--9
select company_name, tname
from Sponsored s inner join theater_has_sponsored h on s.s_id = h.s_id 
    inner join Theater t on h.theater_id = t.theater_id

--10
select AVG(price) as average_price
from Ticket

--11
select tname, average_price
from
(   select th.theater_id, AVG(price) as average_price
    from (Ticket t inner join Show s on t.show_id = s.show_id) inner join 
        (Hold h inner join Theater th on h.theater_id = th.theater_id)
        on s.show_id = h.show_id
    Group by th.theater_id
) v, Theater thtr
where v.theater_id = thtr.theater_id
order by average_price
go

--12
create procedure get_theater_name @ssn bigint
AS
BEGIN
	select tname
	from (Person p inner join Customers c on p.ssn = c.ssn)
			inner join Watch w on c.Customer_id = w.customer_id 
			inner join Hold h on w.show_id = h.show_id
			inner join Theater t on t.theater_id = h.theater_id
	where p.ssn = @ssn
end
go
get_theater_name @ssn = 7390127319

--13
select COUNT(seat_id) as cnt
from Seat
where is_sold = 0

--14
select top 5 p.ssn, first_name, last_name, score
from Customers c inner join Person p on c.ssn = p.ssn
ORDER BY score DESC

--15
select Actor_id, COUNT(show_id) as cnt
from Plays
GROUP BY Actor_id
ORDER BY cnt DESC

--16
select tname
from Hold h join Show s on h.show_id = s.show_id 
    join Theater t 
    on h.theater_id = t.theater_id
where s.genre = 'Drama'

--17
select company_name, COUNT(theater_id) as cnt
from Sponsored s inner join theater_has_sponsored t on s.ad_id = t.s_id
GROUP BY company_name
order by cnt DESC

--18
select distinct first_name, last_name
from Person p inner join Actor a on p.ssn = a.ssn
	inner join Plays pl on a.Actor_id = pl.Actor_id
    join Show s on pl.show_id = s.show_id
where s.genre = 'Comedy'
GO

--19
create procedure get_ticket @t time
AS
BEGIN
    select *
    from Ticket
    Where buy_time >= @t
END
GO

get_ticket @t = '12:00:00.0000000'

--20
select first_name, last_name, average_rating
from 
(   select Director_id, AVG(t.rate) as average_rating
    from (Directs d inner join Show s on d.show_id = s.show_id) 
        join (Hold h inner join Theater t on h.theater_id = t.theater_id) 
        on s.show_id = h.show_id
    GROUP BY Director_id
) v inner join Director on v.Director_id = Director.Director_id
	inner join Person p on Director.ssn = p.ssn
order by average_rating desc