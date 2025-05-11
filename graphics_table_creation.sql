CREATE DATABASE graphics;
CREATE TABLE gd_global_data(
	project_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    designer_id INT NOT NULL,
    type_id INT NOT NULL,
    status_id INT NOT NULL,
    satrt_date DATE NOT NULL,
    deadline DATE NOT NULL,
    delivary_date DATE NOT NULL
);
CREATE TABLE clients(
    client_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    industry VARCHAR(255) NOT NULL,
    join_date DATETIME NOT NULL
);
CREATE TABLE projects(
    project_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    project_type VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    deadline DATE NOT NULL
);
CREATE TABLE designers(
    designer_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    design_section VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL
);
CREATE TABLE assignment(
    assignment_id INT NOT NULL,
    project_id INT NOT NULL,
    designer_id INT NOT NULL,
    project_role TEXT NOT NULL,
    due_date DATETIME NOT NULL,
    status VARCHAR(255) NOT NULL,
    PRIMARY KEY(assignment_id)
);
CREATE TABLE assets(
    asset_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    file_url TEXT NOT NULL,
    file_type VARCHAR(255) NOT NULL,
    uploaded DATETIME NOT NULL
);
CREATE TABLE feedback(
    feedback_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    asset_id INT NOT NULL,
    client_id INT NOT NULL,
    comment TEXT NOT NULL,
    rating INT NOT NULL,
    date_of_feedback DATE NOT NULL
);
ALTER TABLE
    gd_global_data ADD CONSTRAINT gd_global_data_client_id_foreign FOREIGN KEY(client_id) REFERENCES clients(client_id);
ALTER TABLE
    assets ADD CONSTRAINT assets_project_id_foreign FOREIGN KEY(project_id) REFERENCES gd_global_data(project_id);
ALTER TABLE
    gd_global_data ADD CONSTRAINT gd_global_data_project_id_foreign FOREIGN KEY(project_id) REFERENCES projects(project_id);
ALTER TABLE
    feedback ADD CONSTRAINT feedback_asset_id_foreign FOREIGN KEY(asset_id) REFERENCES assets(assest_id);
ALTER TABLE
    assignment ADD CONSTRAINT assignment_designer_id_foreign FOREIGN KEY(designer_id) REFERENCES gd_global_data(designer_id);
ALTER TABLE
    gd_global_data ADD CONSTRAINT gd_global_data_designer_id_foreign FOREIGN KEY(designer_id) REFERENCES designers(designer_id);
