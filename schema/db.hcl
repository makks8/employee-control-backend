table "asset" {
  schema = schema.public
  column "id" {
    null    = false
    type    = serial
    comment = "Идентификатор"
  }
  column "src" {
    null    = false
    type    = character_varying(255)
    comment = "Ссылка"
  }
  primary_key {
    columns = [column.id]
  }
}
table "atlas_schema_revisions" {
  schema = schema.public
  column "version" {
    null = false
    type = character_varying
  }
  column "description" {
    null = false
    type = character_varying
  }
  column "applied" {
    null = false
    type = bigint
  }
  column "total" {
    null = false
    type = bigint
  }
  column "executed_at" {
    null = false
    type = timestamptz
  }
  column "execution_time" {
    null = false
    type = bigint
  }
  column "error" {
    null = true
    type = character_varying
  }
  column "hash" {
    null = false
    type = character_varying
  }
  column "partial_hashes" {
    null = true
    type = jsonb
  }
  column "operator_version" {
    null = false
    type = character_varying
  }
  column "meta" {
    null = false
    type = jsonb
  }
  primary_key {
    columns = [column.version]
  }
}
table "block" {
  schema = schema.public
  column "id" {
    null    = false
    type    = serial
    comment = "Идентификатор блока"
  }
  column "order_index" {
    null    = true
    type    = integer
    comment = "Индекс блока в списке блоков"
  }
  column "type" {
    null    = true
    type    = character_varying(255)
    comment = "Тип блока"
  }
  column "inspiration_id" {
    null    = true
    type    = integer
    comment = "Идентификатор элемента вдохновения"
  }
  column "created_at" {
    null    = true
    type    = timestamptz
    default = sql("now()")
    comment = "Дата создания"
  }
  column "updated_at" {
    null    = true
    type    = timestamptz
    comment = "Дата последнего изменения"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_inspiration_id_fk" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  foreign_key "fk_inspiration_blocks" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "block_another_article_link" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "title" {
    null = false
    type = character_varying(255)
  }
  column "description" {
    null = true
    type = character_varying(255)
  }
  column "link" {
    null = true
    type = character_varying(255)
  }
  column "image_id" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_aa_link_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  foreign_key "block_another_article_link_asset_id_fk" {
    columns     = [column.image_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
}
table "block_button" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "link" {
    null    = false
    type    = character_varying(255)
    comment = "Ссылка на ресурс"
  }
  column "text" {
    null    = false
    type    = character_varying(255)
    comment = "Текст кнопки"
  }
  column "view_type" {
    null    = true
    type    = enum.block_button_view_type
    comment = "Цветовое оформление кнопки"
  }
  column "size" {
    null    = true
    type    = enum.block_button_size
    comment = "Размер кнопки"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_button_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_content_with_icon" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "title" {
    null = false
    type = character_varying(255)
  }
  column "text" {
    null = true
    type = character_varying
  }
  column "icon_id" {
    null = true
    type = integer
  }
  column "text_prepared" {
    null    = false
    type    = character_varying
    default = ""
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_content_with_icon_asset_id_fk" {
    columns     = [column.icon_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
  foreign_key "block_content_with_icon_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_content_with_image" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "text" {
    null = false
    type = character_varying
  }
  column "direction" {
    null    = false
    type    = character_varying
    comment = "Задает порядок расположения изображения и контента"
  }
  column "title" {
    null = true
    type = character_varying(255)
  }
  column "notice" {
    null = true
    type = character_varying
  }
  column "image_id" {
    null = true
    type = integer
  }
  column "text_prepared" {
    null    = false
    type    = character_varying
    default = ""
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_content_with_image_asset_id_fk" {
    columns     = [column.image_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
  foreign_key "block_content_with_image_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_entities_set" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null = true
    type = integer
  }
  column "link" {
    null = true
    type = text
  }
  column "text" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_entities_set_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "fk_block_block_entities_set" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "block_entities_set_entity" {
  schema = schema.public
  column "block_entities_set_id" {
    null = false
    type = integer
  }
  column "entity_id" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.block_entities_set_id, column.entity_id]
  }
  foreign_key "fk_block_entities_set_entity_block_entities_set" {
    columns     = [column.block_entities_set_id]
    ref_columns = [table.block_entities_set.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "fk_block_entities_set_entity_entity" {
    columns     = [column.entity_id]
    ref_columns = [table.entity.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "block_image" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_images_set_id" {
    null = false
    type = integer
  }
  column "image_id" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_image_asset_id_fk" {
    columns     = [column.image_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
  foreign_key "fk_block_image_block_images_set_id" {
    columns     = [column.block_images_set_id]
    ref_columns = [table.block_images_set.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_images_set" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null = false
    type = integer
  }
  column "columns_qty" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_images_set_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_markup" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "markup" {
    null    = false
    type    = character_varying
    comment = "Markdown разметка"
  }
  column "markup_prepared" {
    null    = false
    type    = character_varying
    default = ""
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_markup_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_notice" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "content" {
    null = false
    type = character_varying
  }
  column "content_prepared" {
    null    = false
    type    = character_varying
    default = ""
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_notice_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_ordered_list_item" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "marker" {
    null    = false
    type    = character_varying(2)
    comment = "Контент маркера"
  }
  column "text" {
    null    = false
    type    = character_varying
    comment = "Текстовый контент"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_ordered_list_item_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_quote" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "content" {
    null    = false
    type    = character_varying
    comment = "Текст цитаты"
  }
  column "author" {
    null    = false
    type    = character_varying(255)
    comment = "Автор"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_quote_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_section_header" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null = false
    type = integer
  }
  column "content" {
    null    = false
    type    = character_varying(255)
    comment = "Заголовок раздела"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_section_header_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "block_themed_plate" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "text" {
    null = false
    type = character_varying(255)
  }
  column "title" {
    null = true
    type = character_varying(255)
  }
  column "theme" {
    null = true
    type = enum.block_theme
  }
  column "image_id" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_themed_plate_asset_id_fk" {
    columns     = [column.image_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
  foreign_key "block_themed_plate_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "block_video" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "block_id" {
    null    = false
    type    = integer
    comment = "Идентификатор блока"
  }
  column "url" {
    null    = false
    type    = character_varying(255)
    comment = "Ссылка на видео"
  }
  column "caption" {
    null    = true
    type    = character_varying
    comment = "Подпись к видео"
  }
  column "preview_id" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "block_video_asset_id_fk" {
    columns     = [column.preview_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
  foreign_key "block_video_block_id_fk" {
    columns     = [column.block_id]
    ref_columns = [table.block.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "entity" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "name" {
    null = false
    type = character_varying(255)
  }
  column "link" {
    null = true
    type = text
  }
  column "image_id" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "entity_asset_id_fk" {
    columns     = [column.image_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
}
table "inspiration" {
  schema = schema.public
  column "id" {
    null    = false
    type    = serial
    comment = "Идентификатор"
  }
  column "title" {
    null    = true
    type    = character_varying(255)
    comment = "Заголовок"
  }
  column "view_type" {
    null    = true
    type    = character_varying(255)
    comment = "Тип отображения в списке новостей"
  }
  column "topic_id" {
    null    = true
    type    = integer
    comment = "Идентификатор тематики, по которому выполняется фильтрация"
  }
  column "type" {
    null    = true
    type    = character_varying(255)
    comment = "Тип блока"
  }
  column "available_in_list_view" {
    null    = true
    type    = boolean
    comment = "Признак отображения на странице списка элементов 'Вдохновения'"
  }
  column "status" {
    null    = true
    type    = character_varying(255)
    comment = "Статус публикации элемента"
  }
  column "created_at" {
    null    = true
    type    = timestamptz
    default = sql("now()")
    comment = "Дата создания"
  }
  column "updated_at" {
    null    = true
    type    = timestamptz
    comment = "Дата последнего изменения"
  }
  column "published_at" {
    null    = true
    type    = date
    comment = "Дата публикации статьи"
  }
  primary_key {
    columns = [column.id]
  }
}
table "inspiration_article_item" {
  schema = schema.public
  column "id" {
    null    = false
    type    = serial
    comment = "Идентификатор данных для формирования отображения блока статьи в списке"
  }
  column "inspiration_id" {
    null    = false
    type    = integer
    comment = "Идентификатор элемента вдохновения"
  }
  column "description" {
    null    = true
    type    = character_varying(255)
    comment = "Описание статьи"
  }
  column "image_id" {
    null    = true
    type    = integer
    comment = "Идентификатор изображения"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "inspiration_article_item_asset_id_fk" {
    columns     = [column.image_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
  foreign_key "inspiration_article_item_inspiration_id_fk" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  index "inspiration_article_item_id_uindex" {
    unique  = true
    columns = [column.id]
    type    = BTREE
  }
}
table "inspiration_entities_set" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "inspiration_id" {
    null = true
    type = integer
  }
  column "link" {
    null = true
    type = text
  }
  column "text" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "fk_inspiration_entities_set" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "inspiration_entities_links_set_inspiration_id_fk" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "inspiration_entities_set_entity" {
  schema = schema.public
  column "inspiration_entities_set_id" {
    null = false
    type = integer
  }
  column "entity_id" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.inspiration_entities_set_id, column.entity_id]
  }
  foreign_key "fk_inspiration_entities_set_entity_entity" {
    columns     = [column.entity_id]
    ref_columns = [table.entity.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "fk_inspiration_entities_set_entity_inspiration_entities_set" {
    columns     = [column.inspiration_entities_set_id]
    ref_columns = [table.inspiration_entities_set.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "inspiration_imaged_link" {
  schema = schema.public
  column "id" {
    null    = false
    type    = serial
    comment = "Идентификатор элемента сущности"
  }
  column "inspiration_imaged_links_set_id" {
    null    = false
    type    = integer
    comment = "Идентификатор элемента вдохновения"
  }
  column "text" {
    null    = false
    type    = character_varying(255)
    comment = "Текст ссылки"
  }
  column "link" {
    null    = false
    type    = character_varying(255)
    comment = "Ссылка на ресурс"
  }
  column "image_id" {
    null    = true
    type    = integer
    comment = "Идентификатор изображения"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "inspiration_imaged_link_asset_id_fk" {
    columns     = [column.image_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
  foreign_key "inspiration_imaged_link_inspiration_imaged_links_set_id_fk" {
    columns     = [column.inspiration_imaged_links_set_id]
    ref_columns = [table.inspiration_imaged_links_set.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  index "inspiration_imaged_link_id_uindex" {
    unique  = true
    columns = [column.id]
    type    = BTREE
  }
}
table "inspiration_imaged_links_set" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "inspiration_id" {
    null = false
    type = integer
  }
  column "link" {
    null = true
    type = character_varying(255)
  }
  column "text" {
    null = true
    type = character_varying(255)
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "inspiration_imaged_links_set_inspiration_id_fk" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "inspiration_rating" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "inspiration_id" {
    null    = false
    type    = integer
    comment = "Идентификатор элемента вдохновения"
  }
  column "user_id" {
    null    = false
    type    = integer
    comment = "Идентификатор пользователя"
  }
  column "rating" {
    null    = false
    type    = double_precision
    comment = "Оценка"
  }
  column "created_at" {
    null    = true
    type    = timestamptz
    default = sql("now()")
    comment = "Дата создания"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "inspiration_rating_inspiration_id_fk" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "inspiration_rating_id_uindex" {
    unique  = true
    columns = [column.id]
    type    = BTREE
  }
}
table "inspiration_special_link" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "inspiration_special_links_set_id" {
    null = false
    type = integer
  }
  column "text" {
    null    = false
    type    = character_varying(255)
    comment = "Текст ссылки"
  }
  column "link" {
    null    = false
    type    = character_varying(255)
    comment = "Ссылка на ресурс"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "inspiration_special_link_inspiration_special_links_set_id_fk" {
    columns     = [column.inspiration_special_links_set_id]
    ref_columns = [table.inspiration_special_links_set.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  index "inspiration_special_link_item_id_uindex" {
    unique  = true
    columns = [column.id]
    type    = BTREE
  }
}
table "inspiration_special_links_set" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "inspiration_id" {
    null = false
    type = integer
  }
  column "theme" {
    null    = false
    type    = enum.theme
    comment = "Цветовая тема карточки"
  }
  column "link" {
    null = true
    type = character_varying(255)
  }
  column "text" {
    null = true
    type = character_varying(255)
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "inspiration_special_links_set_inspiration_id_fk" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "inspiration_video_item" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "inspiration_id" {
    null    = false
    type    = integer
    comment = "Идентификатор данных для формирования отображения блока видео в списке"
  }
  column "url" {
    null    = false
    type    = character_varying(255)
    comment = "Ссылка на видео"
  }
  column "preview_id" {
    null    = false
    type    = integer
    comment = "Идентификатор превью"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "inspiration_video_item_asset_id_fk" {
    columns     = [column.preview_id]
    ref_columns = [table.asset.column.id]
    on_update   = NO_ACTION
    on_delete   = SET_NULL
  }
  foreign_key "inspiration_video_item_inspiration_id_fk" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  index "inspiration_video_item_id_uindex" {
    unique  = true
    columns = [column.id]
    type    = BTREE
  }
}
table "inspiration_view" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "inspiration_id" {
    null    = false
    type    = integer
    comment = "Идентификатор элемента вдохновения"
  }
  column "user_id" {
    null    = false
    type    = integer
    comment = "Идентификатор пользователя"
  }
  column "created_at" {
    null    = true
    type    = timestamptz
    default = sql("now()")
    comment = "Дата создания"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "inspiration_view_inspiration_id_fk" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "inspiration_view_id_uindex" {
    unique  = true
    columns = [column.id]
    type    = BTREE
  }
}
table "similar_item" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "inspiration_id" {
    null = true
    type = integer
  }
  column "link" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "fk_inspiration_similar_items" {
    columns     = [column.inspiration_id]
    ref_columns = [table.inspiration.column.id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "topic" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "name" {
    null = false
    type = character_varying(255)
  }
  primary_key {
    columns = [column.id]
  }
}
schema "public" {
}
enum "block_button_view_type" {
  schema = schema.public
  values = ["primary", "secondary"]
}
enum "block_button_size" {
  schema = schema.public
  values = ["m", "s"]
}
enum "block_theme" {
  schema = schema.public
  values = ["gray", "black", "purple", "deep purple"]
}
enum "theme" {
  schema = schema.public
  values = ["black", "deep purple"]
}
