CREATE DATABASE IF NOT EXISTS nabu_api
    CHARACTER SET = 'utf8mb4'
    COLLATE = 'utf8mb4_spanish_ci';

USE nabu_api;

CREATE TABLE IF NOT EXISTS roles (
    id TINYINT UNSIGNED NOT NULL,
    name VARCHAR(8) NOT NULL,
    description VARCHAR(16) NOT NULL,
    CONSTRAINT roles_id_pk PRIMARY KEY(id),
    CONSTRAINT roles_name_uk UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS users (
    id CHAR(36) NOT NULL DEFAULT UUID(),
    role_id TINYINT UNSIGNED NOT NULL DEFAULT 3,
    username VARCHAR(64) NOT NULL,
    email VARCHAR(256) NULL,
    password VARCHAR(256) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT NOW(),
    updated_at DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
    deleted_at DATETIME NULL,
    CONSTRAINT users_id_pk PRIMARY KEY(id),
    CONSTRAINT users_role_id_fk FOREIGN KEY(role_id)
        REFERENCES roles(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT users_username_uk UNIQUE(username),
    CONSTRAINT users_email_uk UNIQUE(email)
);

CREATE TABLE IF NOT EXISTS confirmations (
    id CHAR(36) NOT NULL,
    hash VARCHAR(256) NOT NULL,
    expiration DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT confirmations_id_pk PRIMARY KEY(id),
    CONSTRAINT confirmations_id_fk FOREIGN KEY(id)
        REFERENCES users(id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS profiles (
    id CHAR(36) NOT NULL,
    photo VARCHAR(64) NULL,
    cover VARCHAR(64) NULL,
    name VARCHAR(64) NULL,
    bio VARCHAR(256) NULL,
    CONSTRAINT profiles_id_pk PRIMARY KEY(id),
    CONSTRAINT profiles_id_fk FOREIGN KEY(id)
        REFERENCES users(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT profiles_photo_uk UNIQUE(photo),
    CONSTRAINT profiles_cover_uk UNIQUE(cover)
);

CREATE TABLE IF NOT EXISTS posts (
    id CHAR(36) NOT NULL DEFAULT UUID(),
    user_id CHAR(36) NOT NULL,
    slug VARCHAR(256) NOT NULL,
    cover VARCHAR(64) NULL,
    title VARCHAR(256) NOT NULL,
    excerpt VARCHAR(512) NOT NULL,
    body MEDIUMTEXT NOT NULL,
    active BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT NOW(),
    updated_at DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
    CONSTRAINT posts_id_pk PRIMARY KEY(id),
    CONSTRAINT posts_user_id_fk FOREIGN KEY(user_id)
        REFERENCES users(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT posts_slug_uk UNIQUE(slug),
    CONSTRAINT posts_cover_uk UNIQUE(cover)
);

CREATE TABLE IF NOT EXISTS comments (
    id CHAR(36) NOT NULL DEFAULT UUID(),
    post_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    body VARCHAR(512) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT comments_post_id_fk FOREIGN KEY(post_id)
        REFERENCES posts(id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE,
    CONSTRAINT comments_user_id_fk FOREIGN KEY(user_id)
        REFERENCES users(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS favorites (
    id CHAR(36) NOT NULL DEFAULT UUID(),
    post_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT favorites_id_pk PRIMARY KEY(id),
    CONSTRAINT favorites_post_id_fk FOREIGN KEY(post_id)
        REFERENCES posts(id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE,
    CONSTRAINT favorites_user_id_fk FOREIGN KEY(user_id)
        REFERENCES users(id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT favorites_post_id_user_id_uk UNIQUE(post_id, user_id)
);

CREATE TABLE IF NOT EXISTS subscriptions (
    id CHAR(36) NOT NULL DEFAULT UUID(),
    email VARCHAR(256) NOT NULL,
    hash VARCHAR(256) NOT NULL,
    CONSTRAINT subscriptions_id_pk PRIMARY KEY(id),
    CONSTRAINT subscriptions_email_uk UNIQUE(email)
);

INSERT IGNORE INTO roles VALUES
    (1, 'admin', 'Administrador'),
    (2, 'mod', 'Moderador'),
    (3, 'user', 'Usuario');

INSERT IGNORE INTO users(role_id, username, email, password, active) VALUES(1, 'admin', 'admin@ugto.mx', '$2y$10$7Vy7tVDU0Eyy4pwC0t2k/OYhQlBX.9XTqn5MgA/UPGx.Js/SspFGW', TRUE);
