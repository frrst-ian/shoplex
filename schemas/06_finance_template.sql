-- ================================
-- 06_finance_template.sql
-- Finance Department (Jan-Aug 2025)
-- ================================

CREATE TABLE revenue (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_id INTEGER REFERENCES departments(id),
    revenue_source VARCHAR(100) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    revenue_date DATE NOT NULL,
    order_id INTEGER REFERENCES orders(id),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE expenses (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_id INTEGER REFERENCES departments(id),
    expense_category VARCHAR(100) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    expense_date DATE NOT NULL,
    vendor VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE monthly_summary (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    month_year DATE NOT NULL, -- first day of month
    total_revenue DECIMAL(12,2) NOT NULL,
    total_expenses DECIMAL(12,2) NOT NULL,
    gross_profit DECIMAL(12,2) GENERATED ALWAYS AS (total_revenue - total_expenses) STORED,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE profit_margins (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    cost_price DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    margin_percent DECIMAL(5,2) GENERATED ALWAYS AS (
        ((selling_price - cost_price) / cost_price * 100)
    ) STORED,
    effective_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE budget_tracking (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_id INTEGER REFERENCES departments(id),
    budget_category VARCHAR(100) NOT NULL,
    budgeted_amount DECIMAL(12,2) NOT NULL,
    actual_amount DECIMAL(12,2) NOT NULL,
    variance DECIMAL(12,2) GENERATED ALWAYS AS (actual_amount - budgeted_amount) STORED,
    month_year DATE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);