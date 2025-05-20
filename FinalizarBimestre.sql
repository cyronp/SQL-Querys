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
    SET 
        TOTALFALTAS = (F1 + F2 + F3 + F4),
        MEDIAFINAL = (N1 + N2 + N3 + N4) / 4,
        PERCFREQ = 100 - (((F1 + F2 + F3 + F4) * 100.0) / (
            SELECT CARGAHORARIA 
            FROM MATERIAS 
            WHERE MATERIAS.SIGLA = MATRICULA.MATERIA 
            AND MATERIAS.CURSO = MATRICULA.CURSO
        )),
        RESULTADO = CASE
                    WHEN (N1 + N2 + N3 + N4) / 4 >= 7 
                         AND (100 - (((F1 + F2 + F3 + F4) * 100.0) / (
                            SELECT CARGAHORARIA 
                            FROM MATERIAS 
                            WHERE MATERIAS.SIGLA = MATRICULA.MATERIA 
                            AND MATERIAS.CURSO = MATRICULA.CURSO
                        ))) > 75 THEN 'APROVADO'
                    WHEN (N1 + N2 + N3 + N4) / 4 < 7 
                         AND (100 - (((F1 + F2 + F3 + F4) * 100.0) / (
                            SELECT CARGAHORARIA 
                            FROM MATERIAS 
                            WHERE MATERIAS.SIGLA = MATRICULA.MATERIA 
                                AND MATERIAS.CURSO = MATRICULA.CURSO
                        ))) > 75 THEN 'EXAME'
                    ELSE 'REPROVADO'
                    END
    WHERE PERLETIVO = (SELECT MAX(PERLETIVO) FROM MATRICULA);
END;
GO
END;
