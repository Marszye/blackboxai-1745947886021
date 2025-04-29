-- Database schema for MindTrade Journal

CREATE DATABASE IF NOT EXISTS mindtrade_journal;
USE mindtrade_journal;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE trades (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  pair VARCHAR(20) NOT NULL,
  position ENUM('Buy', 'Sell') NOT NULL,
  entry_price DECIMAL(15,5) NOT NULL,
  sl DECIMAL(15,5),
  tp DECIMAL(15,5),
  size DECIMAL(15,5) NOT NULL,
  result DECIMAL(15,5),
  emotion_before SET('Ragu','FOMO','Overconfidence','Netral') DEFAULT NULL,
  emotion_after SET('Marah','Puas','Menyesal','Netral') DEFAULT NULL,
  reflection TEXT,
  screenshot_path VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE checklist (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  trade_id INT NOT NULL,
  is_valid_setup BOOLEAN NOT NULL,
  meets_rr BOOLEAN NOT NULL,
  stable_psych BOOLEAN NOT NULL,
  exit_plan BOOLEAN NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (trade_id) REFERENCES trades(id) ON DELETE CASCADE
);

CREATE TABLE settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  daily_loss_limit DECIMAL(10,2) DEFAULT 0,
  max_risk_percent DECIMAL(5,2) DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
