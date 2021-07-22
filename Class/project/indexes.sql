CREATE INDEX idx_status
ON orders (status);

CREATE INDEX idx_state
ON customers (state);

CREATE INDEX idx_payment_method
ON billing (payment_method);

commit;