NAME		:= inception
YML_FILE	:= srcs/docker-compose.yml

DC	:= docker-compose --project-name=$(NAME) --file=$(YML_FILE)

MARIADB_DATA	:= /home/sneshev/data/mariadb
WORDPRESS_DATA	:= /home/sneshev/data/wordpress

all:
	mkdir -p $(MARIADB_DATA)
	mkdir -p $(WORDPRESS_DATA)
	$(DC) up --build --detach

clean:
	$(DC) down

fclean:
	$(DC) down --volumes
	rm -rf $(MARIADB_DATA)
	rm -rf $(WORDPRESS_DATA)

re: fclean all

ps:
	$(DC) ps

define select_container
@echo "Choose a container:"
@$(DC) ps --services | nl -w1 -s'. '
endef

# 	add n=0 -> log all containers
logs:
	$(select_container)
	@read -p "Enter number: " n; \
	[ "$$n" -eq "$$n" ] && \
	SELECTED=$$($(DC) ps --services | sed -n "$$n"p); \
	[ -n "$$SELECTED" ] && \
	$(DC) logs -f $$SELECTED

exec:
	$(select_container)
	@read -p "Enter number: " n; \
	[ "$$n" -eq "$$n" ] && \
	SELECTED=$$($(DC) ps --services | sed -n "$$n"p); \
	[ -n "$$SELECTED" ] && \
	$(DC) exec -it $$SELECTED bash

.PHONY: all clean fclean re ps logs exec 