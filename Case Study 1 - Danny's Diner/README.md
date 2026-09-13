## 🍜 Case Study 1: Danny's Diner

**Business Task:**
Danny wants to understand his customers' visiting patterns, how much money they have spent, and their favorite menu items. These insights will help him decide whether to expand his existing customer loyalty program.

---

## 📊 Database Schema
The database consists of three core tables:
* **`sales`:** Captures `customer_id`, `order_date`, and `product_id`.
* **`menu`:** Maps the `product_id` to the `product_name` and `price`.
* **`members`:** Tracks the `customer_id` and their specific `join_date` for the loyalty program.

---

## 🧠 Solutions & Insights

**Q1. What is the total amount each customer spent at the restaurant?**

```sql
-- Paste your clean PostgreSQL code here
SELECT 
  customer_id, 
  SUM(price) AS total_spent
FROM ...