
DROP TABLE IF EXISTS GM_TECH.orgstruct.manager
DROP TABLE IF EXISTS GM_TECH.orgstruct.person
DROP TABLE IF EXISTS GM_TECH.orgstruct.department
DROP TABLE IF EXISTS GM_TECH.orgstruct.company


CREATE TABLE GM_TECH.orgstruct.company
(
	id					INT			 NOT NULL IDENTITY(1,1),
	"name"				NVARCHAR(64) NOT NULL,
	"location"			NVARCHAR(64),
	CONSTRAINT pk_gm_tech_orgstruct_company_id PRIMARY KEY (id)
)

INSERT INTO GM_TECH.orgstruct.company("name", "location")
VALUES	(N'Джемтех', N'Новосибирск')


CREATE TABLE GM_TECH.orgstruct.person
(
	id					INT			 NOT NULL IDENTITY(1,1),
	"name"				NVARCHAR(64) NOT NULL,
	surname				NVARCHAR(64) NOT NULL,
	social_security_id	BIGINT,
	company_id			INT,
	CONSTRAINT pk_gm_tech_orgstruct_person_id PRIMARY KEY (id),
	CONSTRAINT fk_person_company FOREIGN KEY (company_id) REFERENCES GM_TECH.orgstruct.company(id)
)

INSERT INTO GM_TECH.orgstruct.person("name", surname, social_security_id, company_id)
VALUES	(N'Стефания',	N'Коновалова',	65734853840, 1),
		(N'Михаил',		N'Зайков',		86820129418, 1),
		(N'Оксана',		N'Проняева',	87474483668, 1),
		(N'Александра', N'Суворова',	64339033791, 1),
		(N'Софья',		N'Нестерова',	35851885527, 1),
		(N'Захар',		N'Герасимов',	64008835581, 1),
		(N'Николай',	N'Черкасов',	76609345737, 1),
		(N'Семён',		N'Трифонов',	08716963411, 1),
		(N'Алиса',		N'Терентьева',	79954418485, 1),
		(N'Михаил',		N'Беляев',		91527224597, 1)


CREATE TABLE GM_TECH.orgstruct.department
(
	id					INT				NOT NULL IDENTITY(1,1),
	"name"				VARCHAR(128)	NOT NULL,
	"description"		NVARCHAR(64),
	CONSTRAINT pk_gm_tech_orgstruct_department_id PRIMARY KEY (id)
)

INSERT INTO GM_TECH.orgstruct.department("name")
VALUES	('administrative'),
		('hr'),
		('sales'),
		('marketing'),
		('it')


CREATE TABLE GM_TECH.orgstruct.manager
(
	id				INT	NOT NULL IDENTITY(1,1),
	person_id		INT NOT NULL,
	department_id	INT NOT NULL,
	CONSTRAINT pk_gm_tech_orgstruct_manager_id PRIMARY KEY (id),
	CONSTRAINT fk_manager_person		FOREIGN KEY (person_id) REFERENCES GM_TECH.orgstruct.person(id),
	CONSTRAINT fk_manager_department	FOREIGN KEY (department_id) REFERENCES GM_TECH.orgstruct.department(id)
)

INSERT INTO GM_TECH.orgstruct.manager(person_id, department_id)
VALUES	(1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(5, 5),
		(6, 5)
