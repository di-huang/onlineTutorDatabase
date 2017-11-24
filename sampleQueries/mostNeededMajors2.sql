SELECT major 
FROM
(SELECT major, count(*) amount
FROM 
(SELECT major
FROM 
(SELECT tutorID 
FROM questionAnsweredBy AS t1) 
NATURAL JOIN 
(SELECT tutorID, major 
FROM tutor AS t2) AS t3)
UNION
(SELECT major
FROM 
(SELECT tutorID 
FROM expertAnswerGivenBy AS t4) 
NATRUAL JOIN 
(SELECT tutorID, major 
FROM tutor AS t5) AS t6)
UNION
(SELECT major
FROM 
(SELECT tutorID 
FROM textbookSolutionGivenBy AS t7) 
NATRUAL JOIN 
(SELECT tutorID, major 
FROM tutor AS t8) AS t9)
GROUP BY major
AS t10)
AS t11
--ORDER BY amount DESC
--LIMIT 3
--AS t11
