SELECT ISBN, bookName, author, copiesSold, unitPrice, totalIncome
FROM
	(
		(SELECT ISBN, copiesSold, unitPrice, totalIncome
		FROM
	       		(SELECT ISBN, sum(quantity) AS copiesSold, price AS unitPrice, sum(quantity) * price AS totalIncome
			FROM suppliedBy
			WHERE description = "purchase"
			GROUP BY ISBN
			) t1	
		WHERE
			(totalIncome >= all
				(SELECT sum(quantity) * price
				FROM suppliedBy
				GROUP BY ISBN
				)
			)
		) nj1
		NATURAL JOIN
		(SELECT ISBN, bookName, author
		FROM book
		) nj2
	)
