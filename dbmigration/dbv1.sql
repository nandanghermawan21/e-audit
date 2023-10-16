CREATE TABLE notification (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  notif_id TEXT NULL,
  title TEXT NULL,
  body TEXT NULL,
  received_date DATE,
  data_type TEXT NULL,
  data_id TEXT NULL,
  is_readed BOOLEAN DEFAULT 0
);