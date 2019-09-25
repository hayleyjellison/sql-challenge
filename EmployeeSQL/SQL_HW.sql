-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL,
    "from_date" VARCHAR(30)   NOT NULL,
    "to_date" VARCHAR(30)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" VARCHAR(30)   NOT NULL,
    "to_date" VARCHAR(30)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" VARCHAR(30)   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "gender" VARCHAR(3)   NOT NULL,
    "hire_date" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" VARCHAR(30)   NOT NULL,
    "to_date" VARCHAR(30)   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    "from_date" VARCHAR(30)   NOT NULL,
    "to_date" VARCHAR(30)   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");



SELECT * FROM salaries;

--List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
JOIN salaries AS s
ON (e.emp_no = s.emp_no);

--List employees who were hired in 1986.

SELECT emp_no, last_name, first_name, hire_date
FROM employees
WHERE hire_date LIKE '1986%';

SELECT * FROM employees;

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager AS dm
JOIN departments AS d
ON (dm.dept_no = d.dept_no)
JOIN employees AS e
ON (dm.emp_no = e.emp_no);

-- List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
JOIN departments AS d
ON (de.dept_no = d.dept_no);

--List all employees whose first name is "Hercules" 
--and last names begin with "B."

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'B%' AND first_name = 'Hercules';

-- List all employees in the Sales department, 
--including their employee number, last name, first name, 
--and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN employees AS e
ON (de.emp_no = e.emp_no)
JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, 
--and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN employees AS e
ON (de.emp_no = e.emp_no)
JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.

SELECT 
COUNT(last_name) AS "count",
last_name 
FROM employees
GROUP BY last_name
ORDER BY "count" DESC;



