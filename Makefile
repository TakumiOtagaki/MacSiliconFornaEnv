up:
	docker compose up --build -d

down:
	docker compose down

logs:
	docker compose logs -f

sh:
	docker compose exec web bash

rebuild:
	docker compose build --no-cache && docker compose up -d