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
				UNION
				(SELECT tutorID 
				FROM expertAnswerGivenBy t2
				)
				UNION
				(SELECT tutorID 
				FROM textbookSolutionGivenBy t3
				)
			) t4
		GROUP BY tutorID
		) t5
	WHERE 
		(questionsAnswered <= ALL
			(SELECT count(tutorID) AS questionsAnswered
			FROM
				(
					(SELECT tutorID 
					FROM questionAnsweredBy t6
					)
					UNION
					(SELECT tutorID 
					FROM expertAnswerGivenBy t7
					)
					UNION
					(SELECT tutorID 
					FROM textbookSolutionGivenBy t8
					)
				) t9
			GROUP BY tutorID
			) t10
		)
	) nj1
	NATURAL JOIN
	(SELECT tutorID, tutorName, major
	FROM tutor t11
	) nj2
