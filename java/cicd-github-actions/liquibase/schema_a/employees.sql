-- liquibase formatted sql

-- changeset liquibase:2
CREATE TABLE SCHEMA_A.EMPLOYEES (
    EMPLOYEE_ID         NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    EMPLOYEE_FIRSTNAME  VARCHAR2 (255) NOT NULL,
    EMPLOYEE_LASTNAME   VARCHAR2 (255) NOT NULL,
    DEPARTMENT_ID       NUMBER REFERENCES SCHEMA_A.DEPARTMENTS(DEPARTMENT_ID)
) LOGGING;


--rollback DROP TABLE SCHEMA_A.EMPLOYEES;