-- Initial schema for user registration
DROP TABLE IF EXISTS user_favorites;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS user_activity_log;

-- Crear tabla roles primero
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    rol VARCHAR(50)
);

-- Insertar roles por defecto
INSERT INTO roles (id, rol) VALUES (1, 'Admin') ON CONFLICT (id) DO NOTHING;
INSERT INTO roles (id, rol) VALUES (2, 'Usuario') ON CONFLICT (id) DO NOTHING;
INSERT INTO roles (id, rol) VALUES (3, 'Invitado') ON CONFLICT (id) DO NOTHING;

-- Ahora sí, crear users con la FK a roles
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  lastname VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  phone VARCHAR(10) NOT NULL,
  role_id INT REFERENCES roles(id) DEFAULT 2,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS movies (
  id SERIAL PRIMARY KEY,
  movie_poster text,
  title text,
  year integer,
  summary text,
  genres text,
  runtime text,
  director text,
  "cast" text,
  rating text,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COPY movies (id, movie_poster, title, year, summary, genres, runtime, director, "cast", rating)
FROM 'C:\Users\frank\Desktop\imdb_movies.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE IF NOT EXISTS user_favorites (
  id_user INT REFERENCES users(id),
  id_movie INT REFERENCES movies(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_user, id_movie)
);

-- Audit log table
CREATE TABLE IF NOT EXISTS user_activity_log (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255),
    login_time TIMESTAMP,
    logout_time TIMESTAMP,
    browser VARCHAR(255),
    ip_address VARCHAR(50),
    machine_name VARCHAR(255),
    table_name VARCHAR(255),
    action_type VARCHAR(50),
    description TEXT,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Function to insert into audit log
CREATE OR REPLACE FUNCTION log_table_action() RETURNS TRIGGER AS $$
DECLARE
    v_username VARCHAR(255);
    v_browser VARCHAR(255);
    v_ip VARCHAR(50);
    v_machine VARCHAR(255);
    v_desc TEXT;
    v_table VARCHAR(255);
BEGIN
    v_username := current_setting('app.username', true);
    v_browser := current_setting('app.browser', true);
    v_ip := current_setting('app.ip', true);
    v_machine := current_setting('app.machine', true);
    v_table := TG_TABLE_NAME;

    IF v_table = 'user_favorites' THEN
        IF TG_OP = 'INSERT' THEN
            v_desc := 'Inserted favorite: id_user=' || NEW.id_user || ', id_movie=' || NEW.id_movie;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'INSERT', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            v_desc := 'Deleted favorite: id_user=' || OLD.id_user || ', id_movie=' || OLD.id_movie;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'DELETE', v_desc);
            RETURN OLD;
        END IF;
    ELSIF v_table = 'movies' THEN
        IF TG_OP = 'INSERT' THEN
            v_desc := 'Inserted movie: id=' || NEW.id || ', title=' || NEW.title;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'INSERT', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            v_desc := 'Updated movie: id=' || NEW.id || ', title=' || NEW.title;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'UPDATE', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            v_desc := 'Deleted movie: id=' || OLD.id || ', title=' || OLD.title;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'DELETE', v_desc);
            RETURN OLD;
        END IF;
    ELSE
        IF TG_OP = 'INSERT' THEN
            v_desc := 'Inserted record with id=' || NEW.id;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'INSERT', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            v_desc := 'Updated record with id=' || NEW.id;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'UPDATE', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            v_desc := 'Deleted record with id=' || OLD.id;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'DELETE', v_desc);
            RETURN OLD;
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Attach triggers to all relevant tables
DROP TRIGGER IF EXISTS trg_log_user_favorites_action ON user_favorites;
CREATE TRIGGER trg_log_user_favorites_action
AFTER INSERT OR DELETE ON user_favorites
FOR EACH ROW EXECUTE FUNCTION log_table_action();

DROP TRIGGER IF EXISTS trg_log_movies_action ON movies;
CREATE TRIGGER trg_log_movies_action
AFTER INSERT OR UPDATE OR DELETE ON movies
FOR EACH ROW EXECUTE FUNCTION log_table_action();

DROP TRIGGER IF EXISTS trg_log_users_action ON users;
CREATE TRIGGER trg_log_users_action
AFTER INSERT OR UPDATE OR DELETE ON users
FOR EACH ROW EXECUTE FUNCTION log_table_action();
