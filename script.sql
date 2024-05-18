CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS carts;
DROP TYPE IF EXISTS status_enum;

CREATE TYPE status_enum AS ENUM ('OPEN', 'ORDERED');

CREATE TABLE carts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL DEFAULT uuid_generate_v4(),
    created_at DATE NOT NULL,
    updated_at DATE NOT NULL,
    status status_enum NOT NULL
);

CREATE TABLE cart_items (
    cart_id UUID REFERENCES carts(id),
    product_id UUID NOT NULL DEFAULT uuid_generate_v4(),
    count INT NOT NULL
);

INSERT INTO carts(user_id, created_at, updated_at, status) VALUES
(uuid_generate_v4(), CURRENT_DATE, CURRENT_DATE, 'OPEN'),
(uuid_generate_v4(), CURRENT_DATE, CURRENT_DATE, 'ORDERED');

INSERT INTO cart_items(cart_id, count) VALUES
((SELECT id FROM carts ORDER BY created_at LIMIT 1), 2),
((SELECT id FROM carts ORDER BY created_at LIMIT 1), 3);
