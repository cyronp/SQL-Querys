CREATE OR ALTER PROCEDURE FinalizarBimestre 
(
    @MATRICULA INT,
    @PERLETIVO INT,
    @MATERIA CHAR(3),
    @CURSO CHAR(3)
)
AS
BEGIN
    UPDATE MATRICULA
    SET MEDIAFINAL = (N1 + N2 + N3 + N4) / 4,
        RESULTADO = CASE
                       WHEN (N1 + N2 + N3 + N4) / 4 >= 7 THEN 'APROVADO'
                       ELSE 'REPROVADO'
                    END
    WHERE MATRICULA = @MATRICULA
      AND PERLETIVO = @PERLETIVO
      AND MATERIA = @MATERIA
      AND CURSO = @CURSO
END;
