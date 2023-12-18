USE DWH_CDM

GO

CREATE OR ALTER VIEW gm_tech_orgstruct.count_of_employees_by_department AS
WITH cte_managers AS
(
	SELECT	employee_hash_key
			,position
			,ROW_NUMBER() OVER(PARTITION BY employee_hash_key ORDER BY load_ts DESC) AS rn
	FROM DWH_DDS.gm_tech_orgstruct.sat_employee_profession
)
SELECT	hd."name" AS department_name
		,cm.position
		,COUNT(*) AS count_of_employees
FROM DWH_DDS.gm_tech_orgstruct.hub_department			AS hd
JOIN DWH_DDS.gm_tech_orgstruct.lnk_department_employee	AS lde	ON hd.department_hash_key = lde.department_hash_key
JOIN cte_managers										AS cm	ON lde.employee_hash_key = cm.employee_hash_key
WHERE cm.rn = 1
GROUP BY hd."name", cm.position

GO

SELECT	department_name
		,count_of_employees AS count_of_managers
FROM DWH_CDM.gm_tech_orgstruct.count_of_employees_by_department 
WHERE position = 'manager'
ORDER BY department_name

SELECT	department_name
		,count_of_employees AS count_of_workers
FROM DWH_CDM.gm_tech_orgstruct.count_of_employees_by_department 
WHERE position <> 'manager'
ORDER BY department_name
