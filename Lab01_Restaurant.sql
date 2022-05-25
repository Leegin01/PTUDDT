CREATE DATABASE RestaurantManagement
go
use RestaurantManagement

--Query--
--lấy hết Data trong table
CREATE PROCEDURE Category_GetAll
AS
BEGIN
	SELECT * FROM dbo.Category
END
GO
EXEC Category_GetAll

--Lấy hết Data trong table theo ID
CREATE PROCEDURE Category_GetID
(
@ID int
)
AS
BEGIN
	SELECT * FROM dbo.Category WHERE ID = @ID
END
GO
EXEC Category_GetID '01'

-- Add Data vào table
CREATE PROCEDURE Category_Add
(
@ID int,
@Name NVARCHAR(1000),
@Type int
)
AS
BEGIN
	IF (not exists (select Name from dbo.Category where Name=@Name))
	INSERT INTO dbo.Category (ID,Name,Type) VALUES (@ID,@Name,@Type)
END
GO
EXEC Category_Add '01','FastFood','50'    
EXEC Category_Add '02','HealthyFood','40'
select * from Category

--Update data in a table
CREATE PROCEDURE Category_Update
(
@ID int,
@Name nvarchar(1000),
@Type int
)
AS
BEGIN
	UPDATE dbo.Category
	SET [Name] = @Name , [Type] = @Type
	WHERE ID = @ID
END
GO
EXEC Category_Update '01','FastFood','60'
select * from Category

--Delete data in a table
CREATE PROCEDURE Category_Delete
(
@ID int
)
AS
BEGIN
	DELETE FROM dbo.Category
	WHERE ID = @ID
END
GO
EXEC Category_Delete '01'
select * from Category

--ADVANCE Add--
ALTER PROCEDURE dbo.Category_Add
(
@ID int output,
@Name NVARCHAR(1000),
@Type int
)
AS
BEGIN
	IF (not exists (select Name from dbo.Category where Name=@Name))
	INSERT INTO dbo.Category (Name,Type) VALUES (@Name,@Type)
	SET @ID = @@IDENTITY
END
GO
DECLARE @ID INT =0;
EXEC dbo.Category_Add @ID =@ID output, @Name = 'FastFood', @Type =1
select*from dbo.Category 
where ID= @ID

--Lấy mẫu tin theo table
CREATE PROCEDURE [dbo].[_GetAll]
(
@TableName nvarchar(200)
)
AS
BEGIN
	DECLARE @sql nvarchar(1000)
	SET @sql = 'select * from '+@TableName
	EXEC (@sql)
END
GO
EXEC dbo._GetAll 'Category'
drop proc [dbo].[_GetAll]
