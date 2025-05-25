-- USERS table
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR,
    email VARCHAR,
    password VARCHAR,
    role ENUM('Admin', 'Investigator', 'Officer', 'Citizen'),  
    clearance ENUM('low', 'medium', 'high', 'critical'),
    created_at DATE
);

-- CASES table
CREATE TABLE cases (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR,
    description TEXT,
    area VARCHAR,
    city VARCHAR,
    type ENUM('violent', 'property', 'drug', 'cybercrime', 'organized'),
    status ENUM('pending', 'ongoing', 'closed'),
    created_by BIGINT,
    created_at DATE,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- PERSONS table
CREATE TABLE persons (
    id BIGSERIAL PRIMARY KEY,
    case_id BIGINT,
    name VARCHAR,
    age BIGINT,
    type ENUM('suspect', 'victim', 'witness'),
    gender ENUM('male', 'female'),
    role VARCHAR,
    FOREIGN KEY (case_id) REFERENCES cases(id)
);

-- EVIDENCE table
CREATE TABLE evidence (
    id BIGSERIAL PRIMARY KEY,
    case_id BIGINT,
    type ENUM('text', 'image'),
    path VARCHAR,
    content TEXT,
    created_by BIGINT,
    created_at DATE,
    is_deleted BOOLEAN,
    deleted_at DATE,
    FOREIGN KEY (case_id) REFERENCES cases(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- EVIDENCE_LOGS table
CREATE TABLE evidence_logs (
    id BIGSERIAL PRIMARY KEY,
    evidence_id BIGINT,
    user_id BIGINT,
    type ENUM('add', 'update', 'softDelete', 'hardDelete'),
    created_at DATE,
    remarks TEXT,
    FOREIGN KEY (evidence_id) REFERENCES evidence(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- REPORTS table
CREATE TABLE reports (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT,
    case_id BIGINT,
    email VARCHAR,
    name VARCHAR,
    role VARCHAR,
    created_at DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (case_id) REFERENCES cases(id)
);
