SELECT ISBN, bookName, author, copiesOrdered, averagePrice, totalIncome, description
FROM
	(
		(SELECT ISBN, copiesOrdered, averagePrice, totalIncome, description
		FROM
	       		(SELECT ISBN, description, SUM(quantity) AS copiesOrdered, AVG(price) AS averagePrice, SUM(total) AS totalIncome
			FROM 
				(SELECT ISBN, quantity, description, price, price * quantity AS total
				FROM suppliedBy
				) t1
			GROUP BY ISBN, description
			) t2
		) nj1
		NATURAL JOIN
		(SELECT ISBN, bookName, author
		FROM book
		) nj2
	)
