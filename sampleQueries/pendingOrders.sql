SELECT orderID, orderDate, orderTotal 
FROM orders
WHERE orderStatus = "pending"
