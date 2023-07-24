
-- Triggers
-- Delete Cascade
GO
CREATE OR ALTER TRIGGER DeleteActHistory ON Plays
AFTER DELETE
AS
BEGIN
    IF (NOT EXISTS (SELECT * FROM Show WHERE Show.show_id in (SELECT deleted.show_id FROM deleted)))
        DELETE FROM Plays WHERE show_id IN (SELECT show_id FROM deleted); 
END;

-- Increase Ticket Price
GO
CREATE OR ALTER TRIGGER IncreaseTicketPrice ON Ticket
AFTER INSERT
AS
BEGIN
    INSERT INTO Ticket(show_id, customer_id, start_time, buy_time, price, row_position, column_position)
    SELECT show_id, customer_id, start_time, buy_time, price + 50, row_position, column_position FROM inserted
END;