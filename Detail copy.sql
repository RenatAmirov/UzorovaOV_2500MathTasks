-- REGISTRATION

--STEP 1

DECLARE 
-- Название схемы детали.
@DetailSchemaName NCHAR(100) = 'UsrИмяСхемыДетали',
-- Название схемы объекта детали.
@EntitySchemaName NVARCHAR(100) = 'UsrИмяСхемыОбъектаДетали',
-- Название детали используя латиницу.
@DetailCaption NVARCHAR(100) = 'DetailName' 
-- В случае если название содержит кириллицу используйте:
-- @DetailCaption NVARCHAR(100) = N'ИмяДетали' 
 
INSERT INTO SysDetail(
	ProcessListeners,
	Caption,
	DetailSchemaUId,
	EntitySchemaUId
)
VALUES (
	0,
	@DetailCaption,
	(SELECT TOP 1 UId
		FROM SysSchema
	WHERE name = @DetailSchemaName),
	(SELECT TOP 1 UId
		FROM SysSchema
	WHERE name = @EntitySchemaName)
	)
            
--STEP 2

DECLARE
-- Название схемы страницы добавления детали.
@CardSchemaName NCHAR(100) = 'UsrИмяМоделиПредставления',
-- Название схемы объекта детали.
@EntitySchemaName NVARCHAR(100) = 'UsrИмяОбъектаДетали',
-- Название страницы детали.
@PageCaption NVARCHAR(100) = N'Страница добавления детали', -- Пустая строка.@Blank NCHAR(100) = ''
INSERT INTO SysModuleEntity(
	ProcessListeners,
	SysEntitySchemaUId
)
VALUES (
	0,
	(SELECT TOP 1 UId
		FROM SysSchema
		WHERE Name = @EntitySchemaName
	)
	INSERT INTO SysModuleEdit(
		SysModuleEntityId,
		UseModuleDetails,
		Position,
		HelpContextId,
		ProcessListeners,
		CardSchemaUId,
		ActionKindCaption,
		ActionKindName,
		PageCaption
	)
	VALUES (
		(SELECT TOP 1 Id
			FROM SysModuleEntity
			WHERE SysEntitySchemaUId = (
				SELECT TOP 1 UId
				FROM SysSchema
				WHERE Name = @EntitySchemaName
			)
		),
		1,
		0,
		@Blank,
		0,
		(SELECT TOP 1 UId
			FROM SysSchema
			WHERE name = @CardSchemaName
		),
		@Blank,
		@Blank,
	@PageCaption
	) 
            
-- UNREGISTRATION

--STEP 1

DECLARE @Name varchar(max);
SET @Name = 'UsrИмяСхемыДетали';
DECLARE @UId UNIQUEIDENTIFIER;
SELECT @UId = [UId] FROM SysSchema WHERE [Name] = @Name;
DELETE FROM SysDetail WHERE DetailSchemaUId = @UId; 
            
-- STEP 2

DECLARE
@EntitySchemaName NVARCHAR(100) = 'UsrИмяОбъектаДетали'
DECLARE @SysSchemaUId UNIQUEIDENTIFIER;
SELECT @SysSchemaUId = [UId] FROM SysSchema WHERE [Name] = @EntitySchemaName ;
DECLARE @SysModuleEntityId UNIQUEIDENTIFIER;
SELECT @SysModuleEntityId = [Id] FROM SysModuleEntity WHERE [SysEntitySchemaUId] = @SysSchemaUId;
DELETE FROM SysModuleEntity WHERE SysEntitySchemaUId = @SysSchemaUId;
DELETE FROM SysModuleEdit WHERE SysModuleEntityId= @SysModuleEntityId;
            

