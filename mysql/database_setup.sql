CREATE DATABASE energy;
USE energy
CREATE TABLE electric (
  consumption float DEFAULT NULL,
  interval_start datetime NOT NULL,
  interval_end datetime DEFAULT NULL,
  PRIMARY KEY (`interval_start`)
);

