
-- Delete Constraint chk_phone from table Person 

ALTER table Person 
DROP CONSTRAINT chk_phone

-- disable chk_phone constraint :
ALTER table Person 
nocheck CONSTRAINT chk_phone

ALTER table Person
ADD
CONSTRAINT chk_phone CHECK (phone like '09[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')


-- Add Constraint time_chk from table Ticket
-- where buy_time should be equal or less than start_time

ALTER table Ticket
ADD CONSTRAINT time_chk CHECK(buy_time <= start_time)

-- check time_chk constraint 
INSERT INTO Ticket VALUES
(1, 3, '12:00:00', '13:00:00', 1000, 4, 15)
--The INSERT statement conflicted with the CHECK constraint "time_chk". The conflict occurred in database "plast", table "dbo.Ticket".

--Delete constraint CK__Seat__row_positi__68487DD7 from Seat table (row_position >0 )
ALTER table Seat 
DROP CONSTRAINT CK__Seat__row_positi__68487DD7

Alter TABLE Seat
Add CONSTRAINT ch_seat_row_position check(row_position>0)

-- check for delete :
INSERT INTO Seat VALUES
(1, 1, -11, 1)

Delete from Seat where row_position<0

-- Add Constraint chk_time_show that start_show < end_time :

ALTER table Show
Add CONSTRAINT chk_time_show check(start_show<end_time)

ALTER table Show 
DROP CONSTRAINT chk_time_show

