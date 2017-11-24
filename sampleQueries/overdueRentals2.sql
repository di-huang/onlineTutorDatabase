SELECT orderID, quantity, bookName
FROM book NATURAL JOIN suppliedBy
WHERE dueDate < NOW() AND description = "rental"
