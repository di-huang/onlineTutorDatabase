SELECT orderID, quantity, bookName
FROM book NATURAL JOIN suppliedBy
WHERE 
book.ISBN
IN
(SELECT ISBN
FROM suppliedBy
WHERE dueDate < NOW())
AND
suppliedBy.orderID
IN
(SELECT orderID
FROM suppliedBy
WHERE dueDate < NOW())

