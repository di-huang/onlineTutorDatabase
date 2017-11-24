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
	WHERE 
		(questionsAnswered <= ALL
			(SELECT count(tutorID) AS questionsAnswered2
			FROM
				(
					(SELECT tutorID 
					FROM questionAnsweredBy t6
					)
					UNION ALL
					(SELECT tutorID 
					FROM expertAnswerGivenBy t7
					)
					UNION ALL
					(SELECT tutorID 
					FROM textbookSolutionGivenBy t8
					)
				) t9
			GROUP BY tutorID
			)
		)
	) nj1
	NATURAL JOIN
	(SELECT tutorID, tutorName, major
	FROM tutor t11
	) nj2
