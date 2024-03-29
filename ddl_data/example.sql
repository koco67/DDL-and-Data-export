--------------------------------------------------------
--  Datei erstellt -Mittwoch-Januar-24-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table D3_BENEFICIARIES
--------------------------------------------------------

  CREATE TABLE "PADDI"."D3_BENEFICIARIES" 
   (	"D1_NAME" VARCHAR2(250 BYTE), 
	"D1A_ID" VARCHAR2(100 BYTE), 
	"D77_C" VARCHAR2(100 BYTE) DEFAULT 2, 
	"D78_KTORGTYPE2" VARCHAR2(100 BYTE), 
	"D3_KTPRETAXDEDUCTION" VARCHAR2(100 BYTE), 
	"D4_STREET" VARCHAR2(50 BYTE), 
	"D5_ZIP" VARCHAR2(5 BYTE), 
	"D6_CITY" VARCHAR2(50 BYTE), 
	"D7_TELEPHONE" VARCHAR2(50 BYTE), 
	"D8_EMAIL" VARCHAR2(320 BYTE), 
	"D600_C" VARCHAR2(100 BYTE) DEFAULT 0, 
	"FKZ" VARCHAR2(50 BYTE) DEFAULT NULL, 
	"TS" DATE DEFAULT CURRENT_TIMESTAMP, 
	"D3A_OP_OVER_5_MIO" NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "P_PROD" ;

   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D1_NAME" IS 'name - Name/Organisation';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D1A_ID" IS 'ID - Eindeutige Kennzeichnung des Beguenstigten';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D77_C" IS 'immer jursitische Person - ktOrgType - Recihtsform';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D78_KTORGTYPE2" IS 'ktOrgType2 - Rechtsform2';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D3_KTPRETAXDEDUCTION" IS 'ktPretaxDeduction - Vorsteuerabzugsberechtigt';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D4_STREET" IS 'street - Strasse';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D5_ZIP" IS 'zip - PLZ';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D6_CITY" IS 'city - Ort';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D7_TELEPHONE" IS 'telephone - Tel.-Nr.';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D8_EMAIL" IS 'email - E-Mail';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D600_C" IS 'trifft f�r uns nicht zu, da D32 immer false ist - ktFinancialInstrumentType - Daten zum Beguenstigten im Zshg mit Finanzinstrumenten';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."FKZ" IS 'F�rderkennzeichen des zugeh�rigen Vorhabens';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."TS" IS 'Timestamp';
   COMMENT ON COLUMN "PADDI"."D3_BENEFICIARIES"."D3A_OP_OVER_5_MIO" IS 'operationOver5Mio - Vorhaben �ber 5 Millionen Euro Gesamtkosten einschl. Mwst.';
--------------------------------------------------------
--  DDL for Index D3_BENEFICIARIES_FKZ
--------------------------------------------------------

  CREATE INDEX "PADDI"."D3_BENEFICIARIES_FKZ" ON "PADDI"."D3_BENEFICIARIES" ("FKZ") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "P_PROD" ;
--------------------------------------------------------
--  DDL for Index D3_BENEFICIARIES_ADR
--------------------------------------------------------

  CREATE INDEX "PADDI"."D3_BENEFICIARIES_ADR" ON "PADDI"."D3_BENEFICIARIES" ("D1_NAME", "D5_ZIP") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "P_PROD" ;
--------------------------------------------------------
--  Constraints for Table D3_BENEFICIARIES
--------------------------------------------------------

  ALTER TABLE "PADDI"."D3_BENEFICIARIES" MODIFY ("TS" NOT NULL ENABLE);
  ALTER TABLE "PADDI"."D3_BENEFICIARIES" MODIFY ("D1A_ID" NOT NULL ENABLE);
  ALTER TABLE "PADDI"."D3_BENEFICIARIES" MODIFY ("D600_C" NOT NULL ENABLE);
  ALTER TABLE "PADDI"."D3_BENEFICIARIES" MODIFY ("D77_C" NOT NULL ENABLE);
  ALTER TABLE "PADDI"."D3_BENEFICIARIES" MODIFY ("D3A_OP_OVER_5_MIO" NOT NULL ENABLE);
