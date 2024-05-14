CREATE DATABASE energy;
USE energy
CREATE TABLE electric (
  consumption float DEFAULT NULL,
  interval_start datetime NOT NULL,
  interval_end datetime DEFAULT NULL,
  PRIMARY KEY (`interval_start`)
);

-- create a limited user to access the energy data from grafana
-- Obviously don't use this password for real!
CREATE USER 'grafanauser'@'%' IDENTIFIED BY 'passw0rd';
GRANT SELECT ON energy.* TO 'grafanauser'@'%';
