-- 생성자 Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   위치:        2022-04-20 09:36:45 KST
--   사이트:      Oracle Database 11g
--   유형:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE board (
    bo_date       DATE,
    bo_content    VARCHAR2(1000) NOT NULL,
    bo_title      VARCHAR2(20) NOT NULL,
    bo_no         NUMBER(5) NOT NULL,
    bo_hit        NUMBER(5),
    member_mem_id VARCHAR2(20 BYTE) NOT NULL,
    member_mem_no NUMBER NOT NULL
)
LOGGING;

ALTER TABLE board ADD CONSTRAINT board_pk PRIMARY KEY ( bo_no );

CREATE TABLE class (
    cla_no         NUMBER(5) NOT NULL,
    cla_name       VARCHAR2(20),
    cla_intro      VARCHAR2(100),
    teacher_tea_id VARCHAR2(20) NOT NULL
)
LOGGING;

ALTER TABLE class ADD CONSTRAINT class_pk PRIMARY KEY ( cla_no );

CREATE TABLE "COMMENT" (
    co_nom        NUMBER(5) NOT NULL,
    co_content    VARCHAR2(300) NOT NULL,
    co_date       DATE,
    board_bo_no   NUMBER(5) NOT NULL,
    member_mem_id VARCHAR2(20 BYTE) NOT NULL
)
LOGGING;

ALTER TABLE "COMMENT" ADD CONSTRAINT comment_pk PRIMARY KEY ( co_nom );

CREATE TABLE exam (
    ex_type      VARCHAR2(1000),
    ex_no        NUMBER(5),
    ex_correct   NUMBER(5),
    ex_incorrect NUMBER(5),
    ex_question  VARCHAR2(1000),
    ex_answer    VARCHAR2(1000),
    ex_right     NUMBER(5)
)
LOGGING;

CREATE TABLE manager (
    type   NUMBER(5) NOT NULL,
    man_id VARCHAR2(20) NOT NULL,
    man_pw VARCHAR2(20) NOT NULL
)
LOGGING;

ALTER TABLE manager ADD CONSTRAINT manager_pk PRIMARY KEY ( man_id );

CREATE TABLE member (
    mem_id       VARCHAR2(20 BYTE) NOT NULL,
    mem_pw       VARCHAR2(20) NOT NULL,
    mem_image    BLOB,
    mem_birth    DATE,
    mem_email    VARCHAR2(100 BYTE) NOT NULL,
    mem_content  VARCHAR2(100),
    mem_type     NUMBER NOT NULL,
    mem_class    NUMBER,
    mem_tel      VARCHAR2(20),
    mem_license  VARCHAR2(20),
    mem_name     VARCHAR2(100) NOT NULL,
    class_cla_no NUMBER(5) NOT NULL
)
LOGGING;

ALTER TABLE member ADD CONSTRAINT mem_pk PRIMARY KEY ( mem_id );

CREATE TABLE question (
    q_no         NUMBER(5),
    q_correct    NUMBER(5),
    q_incorrect  NUMBER(5),
    q_question   VARCHAR2(1000),
    q_answer     VARCHAR2(1000),
    q_right      NUMBER(5),
    class_cla_no NUMBER(5) NOT NULL
)
LOGGING;

CREATE TABLE teacher (
    type       NUMBER(5),
    tea_no     NUMBER(5),
    tea_id     VARCHAR2(20) NOT NULL,
    tea_class  NUMBER(5),
    tea_pw     VARCHAR2(20),
    tea_major  VARCHAR2(20),
    tea_name   VARCHAR2(20),
    tea_birth  DATE,
    tea_name_1 VARCHAR2(20),
    tea_image  BLOB,
    tea_email  VARCHAR2(20),
    tea_tel    VARCHAR2(20)
)
LOGGING;

ALTER TABLE teacher ADD CONSTRAINT tea_pk PRIMARY KEY ( tea_id );

ALTER TABLE board
    ADD CONSTRAINT board_member_fk FOREIGN KEY ( member_mem_id )
        REFERENCES member ( mem_id )
    NOT DEFERRABLE;

ALTER TABLE class
    ADD CONSTRAINT class_teacher_fk FOREIGN KEY ( teacher_tea_id )
        REFERENCES teacher ( tea_id )
    NOT DEFERRABLE;

ALTER TABLE "COMMENT"
    ADD CONSTRAINT comment_board_fk FOREIGN KEY ( board_bo_no )
        REFERENCES board ( bo_no )
    NOT DEFERRABLE;

ALTER TABLE "COMMENT"
    ADD CONSTRAINT comment_member_fk FOREIGN KEY ( member_mem_id )
        REFERENCES member ( mem_id )
    NOT DEFERRABLE;

ALTER TABLE member
    ADD CONSTRAINT member_class_fk FOREIGN KEY ( class_cla_no )
        REFERENCES class ( cla_no )
    NOT DEFERRABLE;

ALTER TABLE question
    ADD CONSTRAINT question_class_fk FOREIGN KEY ( class_cla_no )
        REFERENCES class ( cla_no )
    NOT DEFERRABLE;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             12
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
