#!make
DB_HOST?=localhost
DB_USER?=employee-control
DB_PASSWORD?=employee-control
DB_DATABASE?=employee-control
DB_DSN?=postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):5432/$(DB_DATABASE)?sslmode=disable
ATLASGO_BIN?=$(shell which atlas)

ui:
	@$(ATLASGO_BIN) \
		schema apply \
			-f db.hcl \
			-w \
			-u "$(DB_DSN)"

apply:
	@$(ATLASGO_BIN) \
    			migrate hash \
    			migrate apply -url="$(DB_DSN)"

apply-dev:
	@$(ATLASGO_BIN) \
			migrate apply --revisions-schema public \
			--url "$(DB_DSN)"

migrate-diff:
	@$(ATLASGO_BIN) \
		migrate diff \
		--dir="file://migrations" --to="file://db.hcl" \
        --dev-url="$(DB_DSN)" create_all

dump:
	@echo -n "Dumping to db.hcl ... "
	@$(ATLASGO_BIN) \
		schema inspect \
			-u "$(DB_DSN)" \
			> db.hcl
	@echo "DONE"