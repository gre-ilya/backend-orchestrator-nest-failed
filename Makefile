start:
	npm run start

dev:
	npm run start:dev

lint:
	npm run lint

delete-db:
	docker compose rm db -s -f -v

run-db:
	docker compose up db -d

wait:
	sleep 1

migrate:
	npx prisma migrate dev

reset-db: delete-db run-db wait migrate

test-e2e:
	npm run test:e2e

admin:
	npx run studio

