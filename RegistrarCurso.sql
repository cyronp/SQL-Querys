CREATE OR ALTER PROCEDURE RegistrarCurso
(
   @CURSO CHAR(3),
   @NOMECURSO VARCHAR(50) 
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM CURSOS WHERE CURSO = @CURSO)
    BEGIN
        PRINT 'CURSO JA EXISTE';
    END
    ELSE
    BEGIN
        INSERT INTO CURSOS (CURSO,NOME)
        VALUES (@CURSO,@NOMECURSO)
    END
END
GO

