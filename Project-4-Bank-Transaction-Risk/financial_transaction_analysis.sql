-- Project: Financial Transaction Analysis
-- Tools: MySQL
-- Analyst: MercyLina
-- Description: SQL analysis of bank transaction data to uncover spending patterns and potential fraud signals


-- preview
SELECT * FROM bank_transactions
LIMIT 10;

-- Monthly Transaction Performance
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount
FROM bank_transactions
GROUP BY month
ORDER BY month;

-- Spending by Category
SELECT 
    category,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_spent
FROM bank_transactions
WHERE transaction_type = 'Debit'
GROUP BY category
ORDER BY total_spent DESC;

-- Top 10 Highest-Spending Customers
SELECT 
    customer_id,
    ROUND(SUM(amount), 2) AS total_spent,
    COUNT(*) AS number_of_transactions
FROM bank_transactions
WHERE transaction_type = 'Debit'
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Average Transaction Value per Customer
SELECT 
    customer_id,
    ROUND(AVG(amount), 2) AS avg_transaction_amount
FROM bank_transactions
GROUP BY customer_id
ORDER BY avg_transaction_amount DESC;

-- High-Frequency Transaction Detection (Fraud Signal)
SELECT 
    customer_id,
    COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY customer_id
HAVING COUNT(*) > 40
ORDER BY transaction_count DESC;

-- Debit vs Credit Analysis
SELECT 
    transaction_type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY transaction_type;

-- Total Transactions & Total Amount
SELECT 
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM bank_transactions;

-- Risk profiling (customer segmentation)
SELECT 
    customer_id,
    CASE 
        WHEN COUNT(*) > 50 THEN 'High Risk'
        WHEN COUNT(*) BETWEEN 30 AND 50 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level
FROM bank_transactions
GROUP BY customer_id;
