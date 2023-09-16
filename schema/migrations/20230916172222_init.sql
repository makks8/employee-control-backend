-- Create "user" table;
CREATE TABLE "public"."user"
(
    "id"            serial                 NOT NULL,
    "name"          character varying(255) NOT NULL,
    "surname"       character varying(255) NOT NULL,
    "phone"         character varying(100) NOT NULL,
    "password_hash" character varying(255) NOT NULL,
    PRIMARY KEY ("id")
);

-- Set comment to column: "id" on table: "user";
COMMENT ON COLUMN "public"."user"."id" IS 'Идентификатор';

-- Set comment to column: "name" on table: "user";
COMMENT ON COLUMN "public"."user"."name" IS 'Имя';

-- Set comment to column: "surname" on table: "user";
COMMENT ON COLUMN "public"."user"."surname" IS 'Фамилия';

-- Set comment to column: "phone" on table: "user";
COMMENT ON COLUMN "public"."user"."phone" IS 'Телефон';

-- Set comment to column: "password_hash" on table: "user";
COMMENT ON COLUMN "public"."user"."password_hash" IS 'Хэш пароля';