 create FUNCTION dbo.genre_check(@genre varchar(max))RETURNS INT as
 BEGIN     
     DECLARE @result as INT


     SET @result = case when @genre = 'Drama' then 1
                     when @genre = 'Comedy' then 1
 					when @genre = 'Tragedy' then 1
 					when @genre = 'Melodrama' then 1
 					when @genre = 'Fiction' then 1
 					when @genre = 'History' then 1
 					when @genre = 'Narrative' then 1
 					wheN @genre = 'Play' then 1
                     else 0 
                         end
     RETURN @result
 END

-------------------------------------------------------------------------------------

 create FUNCTION dbo.age_check(@age varchar(max))RETURNS INT as
 BEGIN     
     DECLARE @result as INT


     SET @result = case when @age = 'General' then 1
                     when @age = 'PG-13' then 1
 					when @age = 'PG-17' then 1
 					when @age = 'Ristricted' then 1
                     else 0 
                         end
     RETURN @result
 END 

-------------------------------------------------------------------------------------

 CREATE FUNCTION dbo.IsValidURL (@Url VARCHAR(200))
 RETURNS INT
 AS
 BEGIN
     IF CHARINDEX('https://', @url) <> 1
     BEGIN
         RETURN 0;   -- Not a valid URL
     END

     -- Get rid of the http:// stuff
     SET @Url = REPLACE(@URL, 'https://', '');

     -- Now we need to check that we only have digits or numbers
     IF (@Url LIKE '%[^a-zA-Z0-9\-\.]%')
     BEGIN
         RETURN 0;
     END

     -- It is a valid URL
     RETURN 1;
 END