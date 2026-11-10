-- ============================================================
-- Script de migración Flyway para crear la estructura de tablas
-- del servicio de gestión de órdenes
-- Versión: 1
-- Fecha de creación: 2024-01-01
-- Descripción: Crea las tablas orders y order_items con sus
--              índices y restricciones necesarias
-- ============================================================

-- Tabla principal de órdenes
CREATE TABLE orders (
    id UUID PRIMARY KEY NOT NULL,
    total_amount NUMERIC(19, 4) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    version INTEGER NOT NULL DEFAULT 0
);

-- Tabla de elementos de orden (relación uno a muchos)
CREATE TABLE order_items (
    id UUID PRIMARY KEY NOT NULL,
    order_id UUID NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price NUMERIC(19, 4) NOT NULL CHECK (price >= 0),
    product_id VARCHAR(255) NOT NULL
);

-- Restricción de clave foránea para la relación orden-items
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id)
REFERENCES orders(id)
ON DELETE CASCADE
ON UPDATE NO ACTION;

-- Índice para buscar órdenes por estado
CREATE INDEX idx_orders_status ON orders(status);

-- Índice para buscar órdenes por fecha de creación
CREATE INDEX idx_orders_created_at ON orders(created_at);

-- Índice para buscar items de orden por ID de orden
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Índice para buscar items de orden por ID de producto
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Comentario sobre la tabla de órdenes
COMMENT ON TABLE orders IS 'Almacena las órdenes del sistema de comercio electrónico';

-- Comentario sobre la tabla de items
COMMENT ON TABLE order_items IS 'Almacena los productos asociados a cada orden';

-- Comentario sobre la columna de estado
COMMENT ON COLUMN orders.status IS 'Estado de la orden: PENDING, CONFIRMED, PROCESSING, SHIPPED, DELIVERED, CANCELLED';

-- Comentario sobre la columna de versión para optimistic locking
COMMENT ON COLUMN orders.version IS 'Número de versión para control de concurrencia optimistic locking';

-- Verificar que la tabla fue creada correctamente
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'orders') THEN
        RAISE EXCEPTION 'La tabla orders no fue creada correctamente';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'order_items') THEN
        RAISE EXCEPTION 'La tabla order_items no fue creada correctamente';
    END IF;
    RAISE NOTICE 'Migración V1 completada exitosamente: tablas orders y order_items creadas';
END $$;