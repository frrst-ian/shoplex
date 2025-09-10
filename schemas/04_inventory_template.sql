-- ================================
-- 04_inventory_template.sql
-- Inventory & Supply Chain Department (Jan-Aug 2025)
-- ================================

CREATE TABLE suppliers (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone VARCHAR(20),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE purchase_orders (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_id INTEGER REFERENCES suppliers(id),
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE inventory (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    location_id INTEGER REFERENCES locations(id),
    quantity_available INTEGER NOT NULL,
    cost_per_unit DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE stock_movements (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    location_id INTEGER REFERENCES locations(id),
    movement_type VARCHAR(50) NOT NULL, -- 'in', 'out', 'transfer', 'adjustment'
    quantity INTEGER NOT NULL,
    reference_id INTEGER, -- order_id for sales, purchase_order_id for restocking
    movement_date TIMESTAMP NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);
