
DROP TABLE IF EXISTS DWH_STG.gm_tech_orgstruct.company

SELECT	SYSDATETIME() AS load_ts
		,'gm_tech' AS record_source
		,*
INTO DWH_STG.gm_tech_orgstruct.company
FROM GM_TECH.orgstruct.company

ALTER TABLE DWH_STG.gm_tech_orgstruct.company ADD CONSTRAINT dwh_stg_gm_tech_orgstruct_company PRIMARY KEY (id)


DROP TABLE IF EXISTS DWH_STG.gm_tech_orgstruct.department

SELECT	SYSDATETIME() AS load_ts
		,'gm_tech' AS record_source
		,*
INTO DWH_STG.gm_tech_orgstruct.department
FROM GM_TECH.orgstruct.department

ALTER TABLE DWH_STG.gm_tech_orgstruct.department ADD CONSTRAINT dwh_stg_gm_tech_orgstruct_department PRIMARY KEY (id)


DROP TABLE IF EXISTS DWH_STG.gm_tech_orgstruct.manager

SELECT	SYSDATETIME() AS load_ts
		,'gm_tech' AS record_source
		,*
INTO DWH_STG.gm_tech_orgstruct.manager
FROM GM_TECH.orgstruct.manager

ALTER TABLE DWH_STG.gm_tech_orgstruct.manager ADD CONSTRAINT dwh_stg_gm_tech_orgstruct_manager PRIMARY KEY (id)


DROP TABLE IF EXISTS DWH_STG.gm_tech_orgstruct.person

SELECT	SYSDATETIME() AS load_ts
		,'gm_tech' AS record_source
		,*
INTO DWH_STG.gm_tech_orgstruct.person
FROM GM_TECH.orgstruct.person

ALTER TABLE DWH_STG.gm_tech_orgstruct.person ADD CONSTRAINT dwh_stg_gm_tech_orgstruct_person PRIMARY KEY (id)


