/*
Source:     DataLemur
Problem:    Employees Earning More Than Their Managers  (Medium)
Question:   Find employees who earn more than their direct manager.
            Return employee_id and name.

Table: employee(employee_id, name, salary, department_id, manager_id)
       manager_id points to another row's employee_id (NULL = no manager)
*/

-- My solution:
SELECT e.employee_id, e.name
FROM employee e
INNER JOIN employee m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

-- Note: self-join the table to itself (e.manager_id = m.employee_id),
-- then keep rows where the employee out-earns the manager.
