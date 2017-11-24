SELECT tutorID, tutorName, major, questionsAnswered 
FROM
	(SELECT tutorID, questionsAnswered
	FROM
		(SELECT tutorID, count(tutorID) AS questionsAnswered
		FROM
			(
				(SELECT tutorID 
				FROM questionAnsweredBy t1
				)
				UNION ALL
				(SELECT tutorID 
				FROM expertAnswerGivenBy t2
				)
				UNION ALL
				(SELECT tutorID 
				FROM textbookSolutionGivenBy t3
				)
			) t4
		GROUP BY tutorID
		) t5
	) nj1
	NATURAL JOIN
	(SELECT tutorID, tutorName, major
	FROM tutor t11
	) nj2
