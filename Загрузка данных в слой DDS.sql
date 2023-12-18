
DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.lnk_company_employee
DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.lnk_company_department
DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.lnk_department_employee

DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.sat_company
DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.sat_department
DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.sat_employee_info
DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.sat_employee_profession

BEGIN --hub_company and sat_company

	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.hub_company

	SELECT	CAST(HASHBYTES('MD5', "name") AS BINARY(16)) AS company_hash_key
			,SYSDATETIME() AS load_ts
			,record_source
			,"name"
	INTO DWH_DDS.gm_tech_orgstruct.hub_company
	FROM DWH_STG.gm_tech_orgstruct.company

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.hub_company ALTER COLUMN company_hash_key	BINARY(16) NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.hub_company ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_hub_company PRIMARY KEY (company_hash_key)

	select * from DWH_DDS.gm_tech_orgstruct.hub_company


	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.sat_company

	SELECT	CAST(HASHBYTES('MD5', "name") AS BINARY(16)) AS company_hash_key
			,SYSDATETIME() AS load_ts
			,record_source
			,"location"
	INTO DWH_DDS.gm_tech_orgstruct.sat_company
	FROM DWH_STG.gm_tech_orgstruct.company

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_company ALTER COLUMN company_hash_key	BINARY(16)		NOT NULL
	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_company ALTER COLUMN load_ts			DATETIME2(7)	NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_company ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_sat_company PRIMARY KEY (company_hash_key, load_ts)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_company ADD CONSTRAINT fk_from_sat_company_to_hub_company FOREIGN KEY (company_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_company(company_hash_key)

	select * from DWH_DDS.gm_tech_orgstruct.sat_company

END


BEGIN --hub_department and sat_department

	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.hub_department

	SELECT	CAST(HASHBYTES('MD5', "name") AS BINARY(16)) AS department_hash_key
			,SYSDATETIME() AS load_ts
			,record_source
			,"name"
	INTO DWH_DDS.gm_tech_orgstruct.hub_department
	FROM DWH_STG.gm_tech_orgstruct.department

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.hub_department ALTER COLUMN department_hash_key BINARY(16) NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.hub_department ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_hub_department PRIMARY KEY (department_hash_key)

	select * from DWH_DDS.gm_tech_orgstruct.hub_department


	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.sat_department

	SELECT	CAST(HASHBYTES('MD5', "name") AS BINARY(16)) AS department_hash_key
			,SYSDATETIME() AS load_ts
			,record_source
			,"description"
	INTO DWH_DDS.gm_tech_orgstruct.sat_department
	FROM DWH_STG.gm_tech_orgstruct.department

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_department ALTER COLUMN department_hash_key	BINARY(16)		NOT NULL
	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_department ALTER COLUMN load_ts				DATETIME2(7)	NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_department ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_sat_department PRIMARY KEY (department_hash_key, load_ts)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_department ADD CONSTRAINT fk_from_sat_department_to_hub_department FOREIGN KEY (department_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_department(department_hash_key)

	select * from DWH_DDS.gm_tech_orgstruct.sat_department

END


BEGIN --hub_employee and sat_employee

	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.hub_employee

	SELECT	CAST(HASHBYTES('MD5', CAST(social_security_id AS VARCHAR(16))) AS BINARY(16)) AS employee_hash_key
			,SYSDATETIME() AS load_ts
			,record_source
			,social_security_id
	INTO DWH_DDS.gm_tech_orgstruct.hub_employee
	FROM DWH_STG.gm_tech_orgstruct.person

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.hub_employee ALTER COLUMN employee_hash_key BINARY(16) NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.hub_employee ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_hub_employee PRIMARY KEY (employee_hash_key)

	select * from DWH_DDS.gm_tech_orgstruct.hub_employee



	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.sat_employee_info

	SELECT	CAST(HASHBYTES('MD5', CAST(social_security_id AS VARCHAR(16))) AS BINARY(16)) AS employee_hash_key
			,SYSDATETIME() AS load_ts
			,record_source
			,"name"
			,surname
	INTO DWH_DDS.gm_tech_orgstruct.sat_employee_info
	FROM DWH_STG.gm_tech_orgstruct.person

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_employee_info ALTER COLUMN employee_hash_key	BINARY(16)		NOT NULL
	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_employee_info ALTER COLUMN load_ts			DATETIME2(7)	NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_employee_info ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_sat_employee_info PRIMARY KEY (employee_hash_key, load_ts)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_employee_info ADD CONSTRAINT fk_from_sat_employee_info_to_hub_employee FOREIGN KEY (employee_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_employee(employee_hash_key)

	select * from DWH_DDS.gm_tech_orgstruct.sat_employee_info


	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.sat_employee_profession

	SELECT	CAST(HASHBYTES('MD5', CAST(social_security_id AS VARCHAR(16))) AS BINARY(16)) AS employee_hash_key
			,SYSDATETIME() AS load_ts
			,CASE WHEN m.person_id IS NOT NULL THEN 'manager' ELSE 'worker' END AS position
	INTO DWH_DDS.gm_tech_orgstruct.sat_employee_profession
	FROM DWH_STG.gm_tech_orgstruct.person		AS p
	LEFT JOIN DWH_STG.gm_tech_orgstruct.manager	AS m ON p.id = m.person_id

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_employee_profession ALTER COLUMN employee_hash_key	BINARY(16)		NOT NULL
	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_employee_profession ALTER COLUMN load_ts				DATETIME2(7)	NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_employee_profession ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_sat_employee_profession PRIMARY KEY (employee_hash_key, load_ts)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.sat_employee_profession ADD CONSTRAINT fk_from_sat_employee_profession_to_hub_employee FOREIGN KEY (employee_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_employee(employee_hash_key)

	select * from DWH_DDS.gm_tech_orgstruct.sat_employee_profession

END


BEGIN

	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.lnk_company_employee

	SELECT DISTINCT
			 CAST(HASHBYTES('MD5', c."name") AS BINARY(16)) AS company_hash_key
			,CAST(HASHBYTES('MD5', CAST(social_security_id AS VARCHAR(16))) AS BINARY(16)) AS employee_hash_key
			,SYSDATETIME() AS load_ts
			,c.record_source
	INTO DWH_DDS.gm_tech_orgstruct.lnk_company_employee
	FROM DWH_STG.gm_tech_orgstruct.person	AS p
	JOIN DWH_STG.gm_tech_orgstruct.company	AS c ON p.company_id = c.id

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_employee ALTER COLUMN company_hash_key	BINARY(16) NOT NULL
	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_employee ALTER COLUMN employee_hash_key	BINARY(16) NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_employee ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_lnk_company_employee PRIMARY KEY (company_hash_key, employee_hash_key)

	CREATE NONCLUSTERED INDEX nci_employee_hash_key ON DWH_DDS.gm_tech_orgstruct.lnk_company_employee(employee_hash_key) INCLUDE(company_hash_key, load_ts)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_employee ADD CONSTRAINT fk_from_lnk_company_employee_to_hub_employee FOREIGN KEY (employee_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_employee(employee_hash_key)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_employee ADD CONSTRAINT fk_from_lnk_company_employee_to_hub_company FOREIGN KEY (company_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_company(company_hash_key)


	select * from DWH_DDS.gm_tech_orgstruct.lnk_company_employee


	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.lnk_company_department

	SELECT DISTINCT
			 CAST(HASHBYTES('MD5', c."name") AS BINARY(16)) AS company_hash_key
			,CAST(HASHBYTES('MD5', d."name") AS BINARY(16)) AS department_hash_key
			,SYSDATETIME() AS load_ts
			,c.record_source
	INTO DWH_DDS.gm_tech_orgstruct.lnk_company_department
	FROM DWH_STG.gm_tech_orgstruct.person		AS p
	JOIN DWH_STG.gm_tech_orgstruct.company		AS c ON p.company_id = c.id
	JOIN DWH_STG.gm_tech_orgstruct.manager		AS m ON p.id = m.person_id
	JOIN DWH_STG.gm_tech_orgstruct.department	AS d ON m.department_id = d.id

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_department ALTER COLUMN company_hash_key		BINARY(16) NOT NULL
	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_department ALTER COLUMN department_hash_key	BINARY(16) NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_department ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_lnk_company_department PRIMARY KEY (company_hash_key, department_hash_key)

	CREATE NONCLUSTERED INDEX nci_department_hash_key ON DWH_DDS.gm_tech_orgstruct.lnk_company_department(department_hash_key) INCLUDE(company_hash_key, load_ts)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_department ADD CONSTRAINT fk_from_lnk_company_department_to_hub_company FOREIGN KEY (company_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_company(company_hash_key)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_company_department ADD CONSTRAINT fk_from_lnk_company_department_to_hub_department FOREIGN KEY (department_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_department(department_hash_key)

	
	select * from DWH_DDS.gm_tech_orgstruct.lnk_company_department


	DROP TABLE IF EXISTS DWH_DDS.gm_tech_orgstruct.lnk_department_employee

	;WITH cte_managers AS
	(
		SELECT DISTINCT
				 CAST(HASHBYTES('MD5', d."name") AS BINARY(16)) AS department_hash_key
				,CAST(HASHBYTES('MD5', CAST(social_security_id AS VARCHAR(16))) AS BINARY(16)) AS employee_hash_key
				,SYSDATETIME() AS load_ts
				,d.record_source
		FROM DWH_STG.gm_tech_orgstruct.person		AS p
		JOIN DWH_STG.gm_tech_orgstruct.manager		AS m ON p.id = m.person_id
		JOIN DWH_STG.gm_tech_orgstruct.department	AS d ON m.department_id = d.id
	)
	,cte_it_workers AS
	(
		SELECT DISTINCT
				 CAST(HASHBYTES('MD5', 'it') AS BINARY(16)) AS department_hash_key
				,CAST(HASHBYTES('MD5', CAST(social_security_id AS VARCHAR(16))) AS BINARY(16)) AS employee_hash_key
				,SYSDATETIME() AS load_ts
				,p.record_source
		FROM DWH_STG.gm_tech_orgstruct.person		AS p
		LEFT JOIN DWH_STG.gm_tech_orgstruct.manager	AS m ON p.id = m.person_id
		WHERE m.id IS NULL
	)
	,cte_union_employees AS
	(
		SELECT * FROM cte_managers
		UNION ALL
		SELECT * FROM cte_it_workers
	)
	SELECT *
	INTO DWH_DDS.gm_tech_orgstruct.lnk_department_employee
	FROM cte_union_employees

	select * from DWH_DDS.gm_tech_orgstruct.hub_department

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_department_employee ALTER COLUMN department_hash_key	BINARY(16) NOT NULL
	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_department_employee ALTER COLUMN employee_hash_key	BINARY(16) NOT NULL

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_department_employee ADD CONSTRAINT pk_dwh_dds_gm_tech_orgstruct_lnk_department_employee PRIMARY KEY (department_hash_key, employee_hash_key)

	CREATE NONCLUSTERED INDEX nci_employee_hash_key ON DWH_DDS.gm_tech_orgstruct.lnk_department_employee(employee_hash_key) INCLUDE(department_hash_key, load_ts)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_department_employee ADD CONSTRAINT fk_from_lnk_department_employee_to_hub_department FOREIGN KEY (department_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_department(department_hash_key)

	ALTER TABLE DWH_DDS.gm_tech_orgstruct.lnk_department_employee ADD CONSTRAINT fk_from_lnk_department_employee_to_hub_employee FOREIGN KEY (employee_hash_key)
		REFERENCES DWH_DDS.gm_tech_orgstruct.hub_employee(employee_hash_key)

	select * from DWH_DDS.gm_tech_orgstruct.lnk_department_employee

END

