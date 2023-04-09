start: down build up

down: 
	docker compose down

build:
	docker compose build

up:
	docker compose up

dev:
	npm run start:dev

lint:
	npm run lint

migrate:
	npx prisma migrate dev

reset-db: delete-db run-db wait migrate

test-e2e:
	npm run test:e2e

admin:
	npx run studio

