



conn <- pg13::local_connect()
pg13::query(
        conn = conn,
        sql_statement =

                "
                DROP TABLE IF EXISTS mth_ext.MRHIER;
                CREATE TABLE mth_ext.MRHIER (
                    CUI	char(8) NOT NULL,
                    AUI	varchar(9) NOT NULL,
                    CXN	integer NOT NULL,
                    PAUI	varchar(10),
                    SAB	varchar(40) NOT NULL,
                    RELA	varchar(100),
                    PTR	text,
                    HCD	varchar(100),
                    CVF	integer,
                    FILLER_COLUMN text),
                    ANCESTOR text
                )

        WITH ext AS (
                select
                  cui,
                  aui,
                  cxn,
                  paui,
                  sab,
                  rela,
                  ptr,
                  hcd,
                  cvf,
                  filler_col,
                  regexp_split_to_table(ptr, '[.]') AS ancestor
                 from mth.mrhier
        )

        INSERT INTO mth_ext.MRHIER
        SELECT * FROM ext

        ;"
)
