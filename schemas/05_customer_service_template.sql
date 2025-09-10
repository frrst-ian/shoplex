-- ================================
-- 05_customer_service_template.sql 
-- Customer Operations Department (Jan-Aug 2025)
-- ================================

CREATE TABLE support_tickets (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_id INTEGER REFERENCES orders(id),
    subject VARCHAR(200) NOT NULL,
    status VARCHAR(50) DEFAULT 'open',
    priority VARCHAR(20) DEFAULT 'medium',
    assigned_agent VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW(),
    resolved_at TIMESTAMP
);

CREATE TABLE returns (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    customer_id INTEGER REFERENCES customers(id),
    reason VARCHAR(100) NOT NULL,
    return_status VARCHAR(50) DEFAULT 'requested',
    refund_amount DECIMAL(10,2),
    return_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE customer_feedback (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_id INTEGER REFERENCES orders(id),
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    comments TEXT,
    feedback_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE faq_usage (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    faq_topic VARCHAR(100) NOT NULL,
    question_title VARCHAR(200) NOT NULL,
    view_count INTEGER DEFAULT 1,
    date_accessed DATE NOT NULL,
    helpful_rating INTEGER CHECK (helpful_rating >= 1 AND helpful_rating <= 5),
    created_at TIMESTAMP DEFAULT NOW()
);