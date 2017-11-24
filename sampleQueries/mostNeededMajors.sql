(SELECT major 
FROM
	(SELECT major, count(*) amount
	FROM 
		(((SELECT major
		FROM 
			(SELECT tutorID 
			FROM questionAnsweredBy
			AS t1)
			NATURAL JOIN 
			(SELECT tutorID, major 
			FROM tutor
			AS t12) AS t13
		)
		AS t3
		UNION
		(SELECT major
		FROM 
			(SELECT tutorID 
			FROM expertAnswerGivenBy
			AS t18)
			NATURAL JOIN 
			(SELECT tutorID, major 
			FROM tutor 
			AS t13) AS t20
		)
		AS t6)) AS t21
		UNION
		(SELECT major
		FROM 
			(SELECT tutorID 
			FROM textbookSolutionGivenBy
			AS t19)
			NATURAL JOIN 
			(SELECT tutorID, major 
			FROM tutor
			AS t14) AS T22
		)
		AS t9) AS t16 
	AS t23
)
AS t11
--ORDER BY amount DESC
--LIMIT 3
--AS t11
