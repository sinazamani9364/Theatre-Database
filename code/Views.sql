

-- Views
-- Getting the first row in the theater
CREATE VIEW FirstRow AS 
SELECT * 
FROM Seat
WHERE row_position = 0;

-- Shows that the specified actor plays in
CREATE VIEW ActorShows AS
SELECT actor_id
FROM Show JOIN Plays ON Show.show_id = Plays.show_id
WHERE Actor_id = 1;