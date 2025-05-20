CREATE OR ALTER PROCEDURE FinalizarBimestre
AS
BEGIN

    UPDATE MATRICULA
    SET 

        TOTALPONTOS = N1 + N2 + N3 + N4,
        TOTALFALTAS = F1 + F2 + F3 + F4,
        MEDIA = (N1 + N2 + N3 + N4) / 4,
        MEDIAFINAL = (N1 + N2 + N3 + N4) / 4,

        PERCFREQ = 100 - (((F1 + F2 + F3 + F4) * (
            SELECT CARGAHORARIA 
            FROM MATERIAS 
            WHERE MATERIAS.SIGLA = MATRICULA.MATERIA 
            AND MATERIAS.CURSO = MATRICULA.CURSO
        )) / 100.0),

        RESULTADO = CASE 
                    WHEN 100 - (((F1 + F2 + F3 + F4) * (
                        SELECT CARGAHORARIA 
                        FROM MATERIAS 
                        WHERE MATERIAS.SIGLA = MATRICULA.MATERIA 
                        AND MATERIAS.CURSO = MATRICULA.CURSO
                    )) / 100.0) < 75 
                         OR (N1 + N2 + N3 + N4) / 4 < 3 THEN 'REPROVADO'
                    WHEN (N1 + N2 + N3 + N4) / 4 < 7 
                         AND (N1 + N2 + N3 + N4) / 4 >= 3 
                         AND 100 - (((F1 + F2 + F3 + F4) * (
                            SELECT CARGAHORARIA 
                            FROM MATERIAS 
                            WHERE MATERIAS.SIGLA = MATRICULA.MATERIA 
                            AND MATERIAS.CURSO = MATRICULA.CURSO
                        )) / 100.0) >= 75 THEN 'EXAME'
                    WHEN (N1 + N2 + N3 + N4) / 4 >= 7 
                         AND 100 - (((F1 + F2 + F3 + F4) * (
                            SELECT CARGAHORARIA 
                            FROM MATERIAS 
                            WHERE MATERIAS.SIGLA = MATRICULA.MATERIA 
                            AND MATERIAS.CURSO = MATRICULA.CURSO
                        )) / 100.0) >= 75 THEN 'APROVADO'
                    END
    WHERE PERLETIVO = (SELECT MAX(PERLETIVO) FROM MATRICULA);  
END;
GO
