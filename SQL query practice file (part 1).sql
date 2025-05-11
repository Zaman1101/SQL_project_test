
-- 1. List all clients with their join dates, sorted by most recent.
SELECT 
    client_id, name AS client_name, email, industry, join_date
FROM
    clients
ORDER BY join_date DESC;

-- 2. Show all projects with their status and deadlines
SELECT 
    project_id, client_id, title, status, deadline
FROM
    projects;

-- 3. Find all designers who specialize in "Web Design"
SELECT 
    designer_id, name AS designer_name, email, design_section, hire_date
FROM
    designers
WHERE
    design_section = 'Web Design'
    ORDER BY hire_date;
    
-- 4. Display all assets uploaded after June 1, 2023
    SELECT 
    asset_id, project_id, name AS file_name, file_url, file_type, uploaded
FROM
    assets
    WHERE uploaded > '2023-06-23';

-- 5. List projects that are "In Progress" status
SELECT 
    project_id,
    client_id,
    title,
    description,
    project_type,
    status,
    start_date,
    deadline
FROM
    projects
WHERE
    status = 'In Progress'
ORDER BY deadline;

-- 6. Show all feedback with ratings less than 4
SELECT 
    feedback_id,
    asset_id,
    client_id,
    comment,
    rating,
    date_of_feedback
FROM
    feedback
WHERE
    rating < 4;
    
-- 7. Find clients from the "Retail" industry
SELECT 
    client_id, name, email, industry, join_date
FROM
    clients
WHERE
    industry = 'Retail';
    
-- 8. List designers hired in 2020.
SELECT 
    designer_id, name, email, design_section, hire_date
FROM
    designers
WHERE
    YEAR(hire_date) = 2020
ORDER BY hire_date;

-- 9. Show projects with deadlines in Q3 2023 (July-September).
SELECT 
    p.project_id,
    p.title AS project_title,
    p.deadline,
    p.status,
    c.name AS client_name
FROM 
    projects p
JOIN 
    clients c ON p.client_id = c.client_id
WHERE 
    p.deadline BETWEEN '2023-07-01' AND '2023-09-30'
ORDER BY 
    p.deadline;
    
-- 10. Display all assignments with "Completed" status.
SELECT 
    a.assignment_id,
    p.title AS project_title,
    d.name AS designer_name,
    a.project_role,
    a.due_date,
    a.status
FROM 
    assignment a
JOIN 
    projects p ON a.project_id = p.project_id
JOIN 
    designers d ON a.designer_id = d.designer_id
WHERE 
    a.status = 'Completed'
ORDER BY 
    a.due_date DESC;

-- 11. Show project titles with their corresponding client names
SELECT 
    p.project_id,
    c.name AS client_name,
    c.industry AS client_industry,
    p.title
FROM
    projects p
        JOIN
    clients c ON p.client_id = c.client_id;
    
-- 12. List all assets with their project names and client names
SELECT 
    a.asset_id,
    c.name AS client_name,
    p.title AS names,
    p.description,
    a.uploaded
    
FROM
    assets a
        JOIN
    projects p ON p.project_id = a.project_id
        JOIN
    clients c ON c.client_id = p.client_id;
    
-- 13. Display designers assigned to each project
SELECT 
    p.project_id,
    p.title AS project_title,
    d.designer_id,
    d.name AS designer_name,
    d.design_section,
    a.project_role,
    a.due_date AS assignment_due_date,
    a.status AS assignment_status
FROM 
    projects p
JOIN 
    assignment a ON p.project_id = a.project_id
JOIN 
    designers d ON a.designer_id = d.designer_id;

-- 14. Show feedback comments with the asset names they refer to
SELECT 
f.feedback_id,
c.name AS client_name,
a.name AS asset_name,
a.file_url,
a.file_type,
f.comment,
f.rating
FROM feedback f

JOIN assets a ON a.asset_id = f.asset_id
JOIN clients c ON f.client_id = c.client_id;

-- 15. List projects with their designers' names and roles.
SELECT 
    p.project_id,
    p.title AS project_title,
    d.designer_id,
    d.name AS designer_name,
    d.design_section AS roles
FROM
    projects p
        JOIN
    assignment a ON a.project_id = p.project_id
        JOIN
    designers d ON a.designer_id = d.designer_id;

-- 16. Show client names with their project counts
SELECT 
    c.client_id,
    c.name AS client_name,
    COUNT(p.project_id) AS project_count
FROM
    clients c
        LEFT JOIN
    projects p ON c.client_id = p.client_id
GROUP BY c.client_id , client_name
ORDER BY project_count;

-- 17. Display projects with their delivery dates (from gd_global_data)
SELECT 
    p.project_id AS id,
    p.title AS project_name,
    d.name AS designer_name,
    g.delivary_date
FROM
    projects p
    
JOIN assignment a ON p.project_id = a.project_id
JOIN designers d ON a.designer_id = d.designer_id
JOIN gd_global_data g ON p.project_id = g.project_id;

-- 18. List designers with the projects they're working on and deadlines
SELECT 
    p.project_id AS id,
    d.name AS designer_name,
    p.title AS project_name,
    p.project_type,
    p.deadline
FROM
    designers d
        JOIN
    assignment a ON d.designer_id = a.designer_id
        JOIN
    projects p ON a.project_id = p.project_id;

-- 19. Show feedback with client names and asset types
SELECT 
    c.client_id AS id,
    c.name AS client_name,
    p.title AS project,
    a.file_type AS asset_type,
    f.comment,
    f.rating
FROM
    feedback f
        JOIN
    clients c ON f.client_id = c.client_id
        JOIN
    assets a ON f.asset_id = a.asset_id
        JOIN
    projects p ON a.project_id = p.project_id;
    
-- 20. Display projects that missed their deadlines (compare deadline to delivery_date)
SELECT 
    p.project_id,
    p.title AS project_name,
    d.designer_id,
    d.name AS designer_name,
    p.deadline AS project_deadline,
    g.delivary_date AS project_delivary_date,
    DATEDIFF(g.delivary_date, p.deadline) AS days_late
FROM
    projects p
        JOIN
    gd_global_data g ON p.project_id = g.project_id
        JOIN
    assignment a ON p.project_id = a.project_id
        JOIN
    designers d ON a.designer_id = d.designer_id
WHERE
    g.delivary_date > p.deadline;

-- 21. Calculate the average feedback rating per client
SELECT 
    c.client_id,
    c.name AS client_name,
    ROUND(AVG(f.rating), 2) AS avg_feedback_rating,
    COUNT(f.feedback_id) AS feedback_count
FROM
    clients c
        LEFT JOIN
    feedback f ON c.client_id = f.client_id
GROUP BY c.client_id , c.name
HAVING COUNT(f.feedback_id) > 0;

-- 22. Find the designer with the most assignments
 SELECT d.designer_id, d.name AS designer_name, d.design_section,
 COUNT(a.assignment_id) AS project_count
 FROM designers d
 JOIN assignment a ON d.designer_id = a.designer_id
 GROUP BY d.designer_id, d.name, d.design_section
 LIMIT 1;
 
 -- 23. Calculate the total number of assets per project type
 SELECT 
    p.project_type, COUNT(a.asset_id) AS total_number_of_assets
FROM
    projects p
        LEFT JOIN
    assets a ON p.project_id = a.project_id
GROUP BY p.project_type
ORDER BY total_number_of_assets DESC;

-- 24. Count how many projects each designer is currently working on
SELECT 
    d.designer_id,
    d.name AS designer_name,
    d.design_section,
    COUNT(a.project_id) AS active_project_count
FROM
    designers d
        JOIN
    assignment a ON d.designer_id = a.designer_id
        JOIN
    projects p ON a.project_id = p.project_id
WHERE
    p.status = 'In Progress'
        AND a.status != 'Completed'
GROUP BY d.designer_id , d.name , d.design_section
ORDER BY active_project_count DESC;

-- 25. Find the client with the highest average feedback rating
SELECT 
    c.client_id,
    c.name AS client_name,
    ROUND(AVG(f.rating), 2) AS average_rating,
    COUNT(f.feedback_id) AS feedback_count
FROM
    clients c
        JOIN
    feedback f ON c.client_id = f.client_id
GROUP BY c.client_id , c.name
HAVING COUNT(f.feedback_id) >= 1
ORDER BY average_rating DESC
LIMIT 1;