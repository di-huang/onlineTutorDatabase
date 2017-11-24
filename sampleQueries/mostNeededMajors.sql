SELECT major 
FROM
	(SELECT major, count(*) AS amount
	FROM 
		(
			(SELECT major
			FROM 
				(SELECT tutorID 
				FROM questionAnsweredBy t1
				) nj1
				NATURAL JOIN
				(SELECT tutorID, major 
				FROM tutor t2
				) nj2
			)
			UNION ALL
			(SELECT major
			FROM 
				(SELECT tutorID 
				FROM expertAnswerGivenBy t3
				) nj3
				NATURAL JOIN 
				(SELECT tutorID, major 
				FROM tutor t4
				) nj4
			)
			UNION ALL
			(SELECT major
			FROM 
				(SELECT tutorID 
				FROM textbookSolutionGivenBy t5
				) nj5
				NATURAL JOIN 
				(SELECT tutorID, major 
				FROM tutor
				) nj6
			)
		) u
	GROUP BY major
	) t6
ORDER BY amount desc
Limit 3
	
