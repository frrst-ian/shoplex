-- ================================
-- 03_sales_template.sql
-- Sales & Marketing Department (Jan-Aug 10 2025)
-- ================================

CREATE TABLE orders (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    payment_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE order_items (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE payments (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    payment_method VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP NOT NULL,
    payment_status VARCHAR(50) DEFAULT 'completed',
    transaction_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE marketing_campaigns (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    campaign_name VARCHAR(100) NOT NULL,
    platform VARCHAR(50) NOT NULL, -- 'Google', 'Facebook', 'Email', 'TikTok'
    budget DECIMAL(10,2) NOT NULL,
    spend DECIMAL(10,2) DEFAULT 0,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20) DEFAULT 'active'
);

CREATE TABLE campaign_results (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    campaign_id INTEGER REFERENCES marketing_campaigns(id),
    clicks INTEGER DEFAULT 0,
    orders_generated INTEGER DEFAULT 0,
    revenue_generated DECIMAL(10,2) DEFAULT 0,
    result_date DATE NOT NULL
);
