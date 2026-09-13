# 📊 8-Week SQL Challenge Portfolio

A collection of end-to-end SQL case studies from Danny Ma's **[8-Week SQL Challenge](https://8weeksqlchallenge.com/)**, engineered to solve real-world business problems using advanced relational database querying and analytical reporting.

---

## 🛠️ Tech Stack & Database Concepts

* **Database Engine:** PostgreSQL

* **Core Concepts:**

  * Multi-table Joins (`INNER`, `LEFT`, `CROSS JOIN`)
  * Data Aggregation & Grouping (`GROUP BY`, `HAVING`, Filtered Aggregations)
  * Window Functions (`ROW_NUMBER()`, `DENSE_RANK()`, `RANK()`, `LEAD()`, `LAG()`)
  * Common Table Expressions (CTEs / `WITH` Clauses) & Subqueries
  * Conditional Business Logic (`CASE WHEN`)
  * Date/Time Parsing & Timestamps

---

## 📂 Case Study Tracker

|  #  | Case Study                 | Business Focus                                        |     Status    | Solutions Link                                                        |
| :-: | :------------------------- | :---------------------------------------------------- | :-----------: | :-------------------------------------------------------------------- |
|  1  | **Danny's Diner**          | Customer spending, visiting patterns & loyalty points |  🟢 Complete  | [View Case Study](./Case%20Study%201%20-%20Danny's%20Diner/README.md) |
|  2  | **Pizza Runner**           | Delivery metrics, runner efficiency & operations      | ⚪ In Progress | *Upcoming*                                                            |
|  3  | **Foodie-Fi**              | Subscription churn, onboarding & payment analysis     |   ⚪ Backlog   | *Upcoming*                                                            |
|  4  | **Data Bank**              | Customer transactions, data allocation & storage      |   ⚪ Backlog   | *Upcoming*                                                            |
|  5  | **Data Mart**              | Sales impact analysis & cleaning time-series data     |   ⚪ Backlog   | *Upcoming*                                                            |
|  6  | **Clique Bait**            | E-commerce funnel, campaign conversion & tracking     |   ⚪ Backlog   | *Upcoming*                                                            |
|  7  | **Balanced Tree Clothing** | Retail sales, product revenue & transaction analysis  |   ⚪ Backlog   | *Upcoming*                                                            |
|  8  | **Fresh Segments**         | Customer interest metrics & composition analysis      |   ⚪ Backlog   | *Upcoming*                                                            |

---

## 🏗️ Repository Architecture

Each case study directory is structured as a self-contained module:

```text
8-Week-SQL-Challenge/
│
├── README.md
│   └── Master project overview
│
└── Case Study 1 - Danny's Diner/
    ├── README.md
    │   └── Problem breakdown & business insights
    │
    ├── setup.sql
    │   └── Schema DDL and sample data insertion
    │
    └── solutions.sql
        └── Clean, executable PostgreSQL solutions
```

---

## 🚀 How to Run Locally

### 1. Clone the repository

```bash
git clone https://github.com/Omkesh-Bash/8-Week-SQL-Challenge.git
```

### 2. Navigate to the desired case study folder

```bash
cd "Case Study 1 - Danny's Diner"
```

### 3. Set up the database

Run `setup.sql` in your local PostgreSQL terminal or client, such as **DBeaver** or **psql**, to initialize the database schema and populate the tables.

### 4. Execute the solutions

Run `solutions.sql` to execute the queries and verify the expected outputs.

```bash
psql -d your_database -f setup.sql
psql -d your_database -f solutions.sql
```

---

## 🎯 Project Goals

This portfolio demonstrates practical SQL skills through progressively complex business problems, including:

* Customer behavior analysis
* Sales and revenue analysis
* Subscription and churn analysis
* Delivery and operational performance
* E-commerce funnel analysis
* Retail transaction analysis
* Customer segmentation
* Time-series data analysis
* Advanced SQL querying and reporting

---

## 📌 About the Challenge

The **8-Week SQL Challenge** was created by **Danny Ma** to help data professionals strengthen their SQL skills through real-world case studies.

Each case study focuses on a different business scenario and requires analytical thinking, data exploration, and progressively advanced SQL techniques.
