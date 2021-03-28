SELECT * FROM python_start

SELECT PY.C#, PY.Ruby
FROM python_start AS PY
WHERE PY.date = '2020-12-01'
GO

SELECT PY.Java
FROM python_start AS PY
ORDER BY PY.Java DESC
GO

SELECT SUM(PY.Java) AS TONG
FROM python_start AS PY
GROUP BY PY.Java
