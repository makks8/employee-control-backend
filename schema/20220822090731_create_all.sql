-- create "block_button_size" type
CREATE TYPE block_button_size AS ENUM ('m', 's');
-- create "block_button_view_type" type
CREATE TYPE block_button_view_type AS ENUM ('primary', 'secondary');
-- create "block_theme" type
CREATE TYPE block_theme AS ENUM ('gray', 'black', 'purple', 'deep purple');
-- create "theme" type
CREATE TYPE theme AS ENUM ('black', 'deep purple');
-- create "topic" table
CREATE TABLE "public"."topic"
(
    "id"   serial                 NOT NULL,
    "name" character varying(255) NOT NULL,
    PRIMARY KEY ("id")
);
-- create "inspiration" table
CREATE TABLE "public"."inspiration"
(
    "id"                     serial                 NOT NULL,
    "title"                  character varying(255) NULL,
    "view_type"              character varying(255) NULL,
    "topic_id"               integer                NULL,
    "type"                   character varying(255) NULL,
    "available_in_list_view" boolean                NULL,
    "status"                 character varying(255) NULL,
    "created_at"             timestamptz            NULL DEFAULT now(),
    "updated_at"             timestamptz            NULL,
    PRIMARY KEY ("id")
);
-- set comment to column: "id" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."id" IS 'Идентификатор';
-- set comment to column: "title" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."title" IS 'Заголовок';
-- set comment to column: "view_type" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."view_type" IS 'Тип отображения в списке новостей';
-- set comment to column: "topic_id" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."topic_id" IS 'Идентификатор тематики, по которому выполняется фильтрация';
-- set comment to column: "type" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."type" IS 'Тип блока';
-- set comment to column: "available_in_list_view" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."available_in_list_view" IS 'Признак отображения на странице списка элементов ''Вдохновения''';
-- set comment to column: "status" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."status" IS 'Статус публикации элемента';
-- set comment to column: "created_at" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."created_at" IS 'Дата создания';
-- set comment to column: "updated_at" on table: "inspiration"
COMMENT ON COLUMN "public"."inspiration"."updated_at" IS 'Дата последнего изменения';
-- create "block" table
CREATE TABLE "public"."block"
(
    "id"             serial                 NOT NULL,
    "order_index"    integer                NULL,
    "type"           character varying(255) NULL,
    "inspiration_id" integer                NULL,
    "created_at"     timestamptz            NULL DEFAULT now(),
    "updated_at"     timestamptz            NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_inspiration_id_fk" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT "fk_inspiration_blocks" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- set comment to column: "id" on table: "block"
COMMENT ON COLUMN "public"."block"."id" IS 'Идентификатор блока';
-- set comment to column: "order_index" on table: "block"
COMMENT ON COLUMN "public"."block"."order_index" IS 'Индекс блока в списке блоков';
-- set comment to column: "type" on table: "block"
COMMENT ON COLUMN "public"."block"."type" IS 'Тип блока';
-- set comment to column: "inspiration_id" on table: "block"
COMMENT ON COLUMN "public"."block"."inspiration_id" IS 'Идентификатор элемента вдохновения';
-- set comment to column: "created_at" on table: "block"
COMMENT ON COLUMN "public"."block"."created_at" IS 'Дата создания';
-- set comment to column: "updated_at" on table: "block"
COMMENT ON COLUMN "public"."block"."updated_at" IS 'Дата последнего изменения';
-- create "block_markup" table
CREATE TABLE "public"."block_markup"
(
    "id"       serial            NOT NULL,
    "block_id" integer           NOT NULL,
    "markup"   character varying NOT NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_markup_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_markup"
COMMENT ON COLUMN "public"."block_markup"."block_id" IS 'Идентификатор блока';
-- set comment to column: "markup" on table: "block_markup"
COMMENT ON COLUMN "public"."block_markup"."markup" IS 'Markdown разметка';
-- create "block_ordered_list_item" table
CREATE TABLE "public"."block_ordered_list_item"
(
    "id"       serial               NOT NULL,
    "block_id" integer              NOT NULL,
    "marker"   character varying(2) NOT NULL,
    "text"     character varying    NOT NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_ordered_list_item_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_ordered_list_item"
COMMENT ON COLUMN "public"."block_ordered_list_item"."block_id" IS 'Идентификатор блока';
-- set comment to column: "marker" on table: "block_ordered_list_item"
COMMENT ON COLUMN "public"."block_ordered_list_item"."marker" IS 'Контент маркера';
-- set comment to column: "text" on table: "block_ordered_list_item"
COMMENT ON COLUMN "public"."block_ordered_list_item"."text" IS 'Текстовый контент';
-- create "block_quote" table
CREATE TABLE "public"."block_quote"
(
    "id"       serial                 NOT NULL,
    "block_id" integer                NOT NULL,
    "content"  character varying      NOT NULL,
    "author"   character varying(255) NOT NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_quote_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_quote"
COMMENT ON COLUMN "public"."block_quote"."block_id" IS 'Идентификатор блока';
-- set comment to column: "content" on table: "block_quote"
COMMENT ON COLUMN "public"."block_quote"."content" IS 'Текст цитаты';
-- set comment to column: "author" on table: "block_quote"
COMMENT ON COLUMN "public"."block_quote"."author" IS 'Автор';
-- create "block_video" table
CREATE TABLE "public"."block_video"
(
    "id"           serial                 NOT NULL,
    "block_id"     integer                NOT NULL,
    "url"          character varying(255) NOT NULL,
    "caption"      character varying      NULL,
    "preview_id"   integer                NULL,
    "preview_src"  character varying(255) NOT NULL,
    "preview_name" character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_video_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_video"
COMMENT ON COLUMN "public"."block_video"."block_id" IS 'Идентификатор блока';
-- set comment to column: "url" on table: "block_video"
COMMENT ON COLUMN "public"."block_video"."url" IS 'Ссылка на видео';
-- set comment to column: "caption" on table: "block_video"
COMMENT ON COLUMN "public"."block_video"."caption" IS 'Подпись к видео';
-- create "block_another_article_link" table
CREATE TABLE "public"."block_another_article_link"
(
    "id"          serial                 NOT NULL,
    "block_id"    integer                NOT NULL,
    "title"       character varying(255) NOT NULL,
    "description" character varying(255) NULL,
    "link"        character varying(255) NULL,
    "image_id"    integer                NULL,
    "image_src"   character varying(255) NOT NULL,
    "image_name"  character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_aa_link_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_another_article_link"
COMMENT ON COLUMN "public"."block_another_article_link"."block_id" IS 'Идентификатор блока';
-- create "block_entities_set" table
CREATE TABLE "public"."block_entities_set"
(
    "id"       serial  NOT NULL,
    "block_id" integer NULL,
    "link"     text    NULL,
    "text"     text    NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_entities_set_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT "fk_block_block_entities_set" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- create "entity" table
CREATE TABLE "public"."entity"
(
    "id"         serial                 NOT NULL,
    "name"       character varying(255) NOT NULL,
    "link"       text                   NULL,
    "image_id"   integer                NULL,
    "image_src"  text                   NULL,
    "image_name" character varying(255) NULL,
    PRIMARY KEY ("id")
);
-- create "block_entities_set_entity" table
CREATE TABLE "public"."block_entities_set_entity"
(
    "block_entities_set_id" integer NOT NULL,
    "entity_id"             integer NOT NULL,
    PRIMARY KEY ("block_entities_set_id", "entity_id"),
    CONSTRAINT "fk_block_entities_set_entity_block_entities_set" FOREIGN KEY ("block_entities_set_id") REFERENCES "public"."block_entities_set" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT "fk_block_entities_set_entity_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."entity" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- create "block_content_with_icon" table
CREATE TABLE "public"."block_content_with_icon"
(
    "id"        serial                 NOT NULL,
    "block_id"  integer                NOT NULL,
    "title"     character varying(255) NOT NULL,
    "text"      character varying      NULL,
    "icon_id"   integer                NULL,
    "icon_src"  character varying(255) NOT NULL,
    "icon_name" character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_content_with_icon_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_content_with_icon"
COMMENT ON COLUMN "public"."block_content_with_icon"."block_id" IS 'Идентификатор блока';
-- create "block_section_header" table
CREATE TABLE "public"."block_section_header"
(
    "id"       serial                 NOT NULL,
    "block_id" integer                NOT NULL,
    "content"  character varying(255) NOT NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_section_header_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "content" on table: "block_section_header"
COMMENT ON COLUMN "public"."block_section_header"."content" IS 'Заголовок раздела';
-- create "inspiration_view" table
CREATE TABLE "public"."inspiration_view"
(
    "id"             serial      NOT NULL,
    "inspiration_id" integer     NOT NULL,
    "user_id"        integer     NOT NULL,
    "created_at"     timestamptz NULL DEFAULT now(),
    PRIMARY KEY ("id"),
    CONSTRAINT "inspiration_view_inspiration_id_fk" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE NO ACTION ON DELETE CASCADE
);
-- create index "inspiration_view_id_uindex" to table: "inspiration_view"
CREATE UNIQUE INDEX "inspiration_view_id_uindex" ON "public"."inspiration_view" ("id");
-- set comment to column: "inspiration_id" on table: "inspiration_view"
COMMENT ON COLUMN "public"."inspiration_view"."inspiration_id" IS 'Идентификатор элемента вдохновения';
-- set comment to column: "user_id" on table: "inspiration_view"
COMMENT ON COLUMN "public"."inspiration_view"."user_id" IS 'Идентификатор пользователя';
-- set comment to column: "created_at" on table: "inspiration_view"
COMMENT ON COLUMN "public"."inspiration_view"."created_at" IS 'Дата создания';
-- create "inspiration_imaged_links_set" table
CREATE TABLE "public"."inspiration_imaged_links_set"
(
    "id"             serial                 NOT NULL,
    "inspiration_id" integer                NOT NULL,
    "link"           character varying(255) NULL,
    "text"           character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "inspiration_imaged_links_set_inspiration_id_fk" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- create "inspiration_rating" table
CREATE TABLE "public"."inspiration_rating"
(
    "id"             serial           NOT NULL,
    "inspiration_id" integer          NOT NULL,
    "user_id"        integer          NOT NULL,
    "rating"         double precision NOT NULL,
    "created_at"     timestamptz      NULL DEFAULT now(),
    PRIMARY KEY ("id"),
    CONSTRAINT "inspiration_rating_inspiration_id_fk" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE NO ACTION ON DELETE CASCADE
);
-- create index "inspiration_rating_id_uindex" to table: "inspiration_rating"
CREATE UNIQUE INDEX "inspiration_rating_id_uindex" ON "public"."inspiration_rating" ("id");
-- set comment to column: "inspiration_id" on table: "inspiration_rating"
COMMENT ON COLUMN "public"."inspiration_rating"."inspiration_id" IS 'Идентификатор элемента вдохновения';
-- set comment to column: "user_id" on table: "inspiration_rating"
COMMENT ON COLUMN "public"."inspiration_rating"."user_id" IS 'Идентификатор пользователя';
-- set comment to column: "rating" on table: "inspiration_rating"
COMMENT ON COLUMN "public"."inspiration_rating"."rating" IS 'Оценка';
-- set comment to column: "created_at" on table: "inspiration_rating"
COMMENT ON COLUMN "public"."inspiration_rating"."created_at" IS 'Дата создания';
-- create "block_notice" table
CREATE TABLE "public"."block_notice"
(
    "id"       serial            NOT NULL,
    "block_id" integer           NOT NULL,
    "content"  character varying NOT NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_notice_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_notice"
COMMENT ON COLUMN "public"."block_notice"."block_id" IS 'Идентификатор блока';
-- create "inspiration_entities_set" table
CREATE TABLE "public"."inspiration_entities_set"
(
    "id"             serial  NOT NULL,
    "inspiration_id" integer NULL,
    "link"           text    NULL,
    "text"           text    NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "fk_inspiration_entities_set" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT "inspiration_entities_links_set_inspiration_id_fk" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE NO ACTION ON DELETE CASCADE
);
-- create "inspiration_entities_set_entity" table
CREATE TABLE "public"."inspiration_entities_set_entity"
(
    "inspiration_entities_set_id" integer NOT NULL,
    "entity_id"                   integer NOT NULL,
    PRIMARY KEY ("inspiration_entities_set_id", "entity_id"),
    CONSTRAINT "fk_inspiration_entities_set_entity_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."entity" ("id") ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT "fk_inspiration_entities_set_entity_inspiration_entities_set" FOREIGN KEY ("inspiration_entities_set_id") REFERENCES "public"."inspiration_entities_set" ("id") ON UPDATE NO ACTION ON DELETE CASCADE
);
-- create "inspiration_special_links_set" table
CREATE TABLE "public"."inspiration_special_links_set"
(
    "id"             serial                 NOT NULL,
    "inspiration_id" integer                NOT NULL,
    "theme"          theme                  NOT NULL,
    "link"           character varying(255) NULL,
    "text"           character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "inspiration_special_links_set_inspiration_id_fk" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "theme" on table: "inspiration_special_links_set"
COMMENT ON COLUMN "public"."inspiration_special_links_set"."theme" IS 'Цветовая тема карточки';
-- create "inspiration_video_item" table
CREATE TABLE "public"."inspiration_video_item"
(
    "id"             serial                 NOT NULL,
    "inspiration_id" integer                NOT NULL,
    "url"            character varying(255) NOT NULL,
    "preview_id"     integer                NOT NULL,
    "preview_src"    character varying(255) NOT NULL,
    "preview_name"   character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "inspiration_video_item_inspiration_id_fk" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- create index "inspiration_video_item_id_uindex" to table: "inspiration_video_item"
CREATE UNIQUE INDEX "inspiration_video_item_id_uindex" ON "public"."inspiration_video_item" ("id");
-- set comment to column: "inspiration_id" on table: "inspiration_video_item"
COMMENT ON COLUMN "public"."inspiration_video_item"."inspiration_id" IS 'Идентификатор данных для формирования отображения блока видео в списке';
-- set comment to column: "url" on table: "inspiration_video_item"
COMMENT ON COLUMN "public"."inspiration_video_item"."url" IS 'Ссылка на видео';
-- set comment to column: "preview_id" on table: "inspiration_video_item"
COMMENT ON COLUMN "public"."inspiration_video_item"."preview_id" IS 'Идентификатор превью';
-- set comment to column: "preview_src" on table: "inspiration_video_item"
COMMENT ON COLUMN "public"."inspiration_video_item"."preview_src" IS 'Ссылка на изображение';
-- set comment to column: "preview_name" on table: "inspiration_video_item"
COMMENT ON COLUMN "public"."inspiration_video_item"."preview_name" IS 'Название файла изображения';
-- create "block_themed_plate" table
CREATE TABLE "public"."block_themed_plate"
(
    "id"         serial                 NOT NULL,
    "block_id"   integer                NOT NULL,
    "text"       character varying(255) NOT NULL,
    "title"      character varying(255) NULL,
    "theme"      block_theme            NULL,
    "image_id"   integer                NULL,
    "image_src"  character varying(255) NULL,
    "image_name" character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_themed_plate_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE NO ACTION ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_themed_plate"
COMMENT ON COLUMN "public"."block_themed_plate"."block_id" IS 'Идентификатор блока';
-- create "inspiration_article_item" table
CREATE TABLE "public"."inspiration_article_item"
(
    "id"             serial                 NOT NULL,
    "inspiration_id" integer                NOT NULL,
    "description"    character varying(255) NULL,
    "image_id"       integer                NULL,
    "image_src"      character varying(255) NOT NULL,
    "image_name"     character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "inspiration_article_item_inspiration_id_fk" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- create index "inspiration_article_item_id_uindex" to table: "inspiration_article_item"
CREATE UNIQUE INDEX "inspiration_article_item_id_uindex" ON "public"."inspiration_article_item" ("id");
-- set comment to column: "id" on table: "inspiration_article_item"
COMMENT ON COLUMN "public"."inspiration_article_item"."id" IS 'Идентификатор данных для формирования отображения блока статьи в списке';
-- set comment to column: "inspiration_id" on table: "inspiration_article_item"
COMMENT ON COLUMN "public"."inspiration_article_item"."inspiration_id" IS 'Идентификатор элемента вдохновения';
-- set comment to column: "description" on table: "inspiration_article_item"
COMMENT ON COLUMN "public"."inspiration_article_item"."description" IS 'Описание статьи';
-- set comment to column: "image_id" on table: "inspiration_article_item"
COMMENT ON COLUMN "public"."inspiration_article_item"."image_id" IS 'Идентификатор изображения';
-- set comment to column: "image_src" on table: "inspiration_article_item"
COMMENT ON COLUMN "public"."inspiration_article_item"."image_src" IS 'Ссылка на изображение';
-- set comment to column: "image_name" on table: "inspiration_article_item"
COMMENT ON COLUMN "public"."inspiration_article_item"."image_name" IS 'Название файла изображения';
-- create "inspiration_imaged_link" table
CREATE TABLE "public"."inspiration_imaged_link"
(
    "id"                              serial                 NOT NULL,
    "inspiration_imaged_links_set_id" integer                NOT NULL,
    "text"                            character varying(255) NOT NULL,
    "link"                            character varying(255) NOT NULL,
    "image_id"                        integer                NULL,
    "image_src"                       character varying(255) NOT NULL,
    "image_name"                      character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "inspiration_imaged_link_inspiration_imaged_links_set_id_fk" FOREIGN KEY ("inspiration_imaged_links_set_id") REFERENCES "public"."inspiration_imaged_links_set" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- create index "inspiration_imaged_link_id_uindex" to table: "inspiration_imaged_link"
CREATE UNIQUE INDEX "inspiration_imaged_link_id_uindex" ON "public"."inspiration_imaged_link" ("id");
-- set comment to column: "id" on table: "inspiration_imaged_link"
COMMENT ON COLUMN "public"."inspiration_imaged_link"."id" IS 'Идентификатор элемента сущности';
-- set comment to column: "inspiration_imaged_links_set_id" on table: "inspiration_imaged_link"
COMMENT ON COLUMN "public"."inspiration_imaged_link"."inspiration_imaged_links_set_id" IS 'Идентификатор элемента вдохновения';
-- set comment to column: "text" on table: "inspiration_imaged_link"
COMMENT ON COLUMN "public"."inspiration_imaged_link"."text" IS 'Текст ссылки';
-- set comment to column: "link" on table: "inspiration_imaged_link"
COMMENT ON COLUMN "public"."inspiration_imaged_link"."link" IS 'Ссылка на ресурс';
-- set comment to column: "image_id" on table: "inspiration_imaged_link"
COMMENT ON COLUMN "public"."inspiration_imaged_link"."image_id" IS 'Идентификатор изображения';
-- set comment to column: "image_src" on table: "inspiration_imaged_link"
COMMENT ON COLUMN "public"."inspiration_imaged_link"."image_src" IS 'Ссылка на изображение';
-- set comment to column: "image_name" on table: "inspiration_imaged_link"
COMMENT ON COLUMN "public"."inspiration_imaged_link"."image_name" IS 'Название файла изображения';
-- create "similar_item" table
CREATE TABLE "public"."similar_item"
(
    "id"             serial  NOT NULL,
    "inspiration_id" integer NULL,
    "link"           text    NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "fk_inspiration_similar_items" FOREIGN KEY ("inspiration_id") REFERENCES "public"."inspiration" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- create "block_content_with_image" table
CREATE TABLE "public"."block_content_with_image"
(
    "id"         serial                 NOT NULL,
    "block_id"   integer                NOT NULL,
    "text"       character varying      NOT NULL,
    "direction"  character varying      NOT NULL,
    "title"      character varying(255) NULL,
    "notice"     character varying      NULL,
    "image_id"   integer                NULL,
    "image_src"  character varying(255) NOT NULL,
    "image_name" character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_content_with_image_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_content_with_image"
COMMENT ON COLUMN "public"."block_content_with_image"."block_id" IS 'Идентификатор блока';
-- set comment to column: "direction" on table: "block_content_with_image"
COMMENT ON COLUMN "public"."block_content_with_image"."direction" IS 'Задает порядок расположения изображения и контента';
-- create "block_images_set" table
CREATE TABLE "public"."block_images_set"
(
    "id"          serial  NOT NULL,
    "block_id"    integer NOT NULL,
    "columns_qty" integer NOT NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_images_set_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- create "block_image" table
CREATE TABLE "public"."block_image"
(
    "id"                  serial                 NOT NULL,
    "block_images_set_id" integer                NOT NULL,
    "image_id"            integer                NULL,
    "image_src"           character varying(255) NOT NULL,
    "image_name"          character varying(255) NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "fk_block_image_block_images_set_id" FOREIGN KEY ("block_images_set_id") REFERENCES "public"."block_images_set" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- create "block_button" table
CREATE TABLE "public"."block_button"
(
    "id"        serial                 NOT NULL,
    "block_id"  integer                NOT NULL,
    "link"      character varying(255) NOT NULL,
    "text"      character varying(255) NOT NULL,
    "view_type" block_button_view_type NULL,
    "size"      block_button_size      NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "block_button_block_id_fk" FOREIGN KEY ("block_id") REFERENCES "public"."block" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- set comment to column: "block_id" on table: "block_button"
COMMENT ON COLUMN "public"."block_button"."block_id" IS 'Идентификатор блока';
-- set comment to column: "link" on table: "block_button"
COMMENT ON COLUMN "public"."block_button"."link" IS 'Ссылка на ресурс';
-- set comment to column: "text" on table: "block_button"
COMMENT ON COLUMN "public"."block_button"."text" IS 'Текст кнопки';
-- set comment to column: "view_type" on table: "block_button"
COMMENT ON COLUMN "public"."block_button"."view_type" IS 'Цветовое оформление кнопки';
-- set comment to column: "size" on table: "block_button"
COMMENT ON COLUMN "public"."block_button"."size" IS 'Размер кнопки';
-- create "inspiration_special_link" table
CREATE TABLE "public"."inspiration_special_link"
(
    "id"                               serial                 NOT NULL,
    "inspiration_special_links_set_id" integer                NOT NULL,
    "text"                             character varying(255) NOT NULL,
    "link"                             character varying(255) NOT NULL,
    PRIMARY KEY ("id"),
    CONSTRAINT "inspiration_special_link_inspiration_special_links_set_id_fk" FOREIGN KEY ("inspiration_special_links_set_id") REFERENCES "public"."inspiration_special_links_set" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);
-- create index "inspiration_special_link_item_id_uindex" to table: "inspiration_special_link"
CREATE UNIQUE INDEX "inspiration_special_link_item_id_uindex" ON "public"."inspiration_special_link" ("id");
-- set comment to column: "text" on table: "inspiration_special_link"
COMMENT ON COLUMN "public"."inspiration_special_link"."text" IS 'Текст ссылки';
-- set comment to column: "link" on table: "inspiration_special_link"
COMMENT ON COLUMN "public"."inspiration_special_link"."link" IS 'Ссылка на ресурс';
