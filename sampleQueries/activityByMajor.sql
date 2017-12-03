SELECT major, count(*) AS questionsSolved
FROM 
	(SELECT major
	FROM 
		(
			(SELECT tutorID 
			FROM expertAnswerGivenBy
			)
			UNION ALL
			(SELECT tutorID
			FROM textbookSolutionGivenBy
			)
			UNION ALL
			(SELECT tutorID
			FROM questionAnsweredBy
			)
		) nj1
		NATURAL JOIN
		(SELECT tutorID, major
		FROM tutor
		) nj2
	) t1
GROUP BY major
;
			
			
