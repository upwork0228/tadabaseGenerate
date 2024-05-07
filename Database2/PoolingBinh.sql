if '$(dropTable)' = 'true'
    BEGIN
        DECLARE @isContinue BINARY(1) = 1;
        DECLARE @sql varchar(max);
        while @isContinue=1
            BEGIN
                SELECT TOP(1) @sql = 'ALTER TABLE ' 
                    + '['+ Schema_name(PK.schema_id) 
                    + '].['+ OBJECT_NAME(PK.parent_object_id) 
                    + ']'+ ' DROP  CONSTRAINT ' 
                    + '[' + PK.name + ']' 
                    FROM   sys.foreign_keys AS PK
                EXEC (@sql)
                IF @sql IS NULL
                    BEGIN
	                    SET @isContinue = 0;
                    END
            END
DROP TABLE IF EXISTS [dbo].[Courses]
DROP TABLE IF EXISTS [dbo].[Students]
DROP TABLE IF EXISTS [dbo].[Enrollments]
    END

CREATE TABLE [dbo].[Students] (
    [StudentID] uniqueidentifier PRIMARY KEY,
    [LastName] varchar(255) NOT NULL,
    [FirstName] varchar(255) NOT NULL,
    [EnrollmentDate] date
);
CREATE TABLE [dbo].[Courses] (
    [CourseID]  uniqueidentifier NOT NULL PRIMARY KEY,
    [Title] varchar(255) NOT NULL,
    [Credits] varchar(255) NOT NULL
);
CREATE TABLE [dbo].[Enrollments] (
    [EnrollmentID]  uniqueidentifier PRIMARY KEY,
    [CourseID] uniqueidentifier FOREIGN KEY REFERENCES [dbo].[Courses](CourseID),
    [StudentID] uniqueidentifier FOREIGN KEY REFERENCES [dbo].[Students](StudentID),
    [Grade] varchar(255) NOT NULL,
);

