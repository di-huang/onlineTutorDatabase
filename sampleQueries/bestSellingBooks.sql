SELECT ISBN, bookName, author, copiesSold, averagePrice, totalIncome
FROM
	(
		(SELECT ISBN, copiesSold, averagePrice, totalIncome
		FROM
	       		(SELECT ISBN, SUM(quantity) AS copiesSold, AVG(price) AS averagePrice, SUM(total) AS totalIncome
			FROM 
				(SELECT ISBN, quantity, price, price * quantity AS total
				FROM suppliedBy
				WHERE description = "purchase"
				) t1
			GROUP BY ISBN
			) t2
		WHERE
			(totalIncome >= all
				(SELECT SUM(total)
				FROM
					(SELECT ISBN, price * quantity AS total
					FROM suppliedBy
					WHERE description = "purchase"
					) t3
				GROUP BY ISBN
				)
			)
		) nj1
		NATURAL JOIN
		(SELECT ISBN, bookName, author
		FROM book
		) nj2
	)
