select ISBN, bookName, booksOrdered from
(
	(select itemType, sum(orderTotal) as booksOrdered from orders group by itemType) t1
	join
	(select * from book) t2
	on itemType = bookName
) 
order by booksOrdered
