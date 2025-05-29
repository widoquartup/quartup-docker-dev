#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para leer variables del .env de forma segura
load_env() {
    while IFS='=' read -r key value; do
        # Ignorar comentarios y líneas vacías
        [[ $key =~ ^[[:space:]]*# ]] && continue
        [[ -z $key ]] && continue
        
        # Remover espacios al inicio y final
        key=$(echo "$key" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
        value=$(echo "$value" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
        
        # Exportar solo si es una variable válida
        if [[ $key =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
            export "$key"="$value"
        fi
    done < .env
}

# Función para generar 90-quartup.ini
generate_ini() {
    envsubst < 90-quartup.ini.template > 90-quartup.ini
    echo "  ✓ Configuración PHP generada (XDEBUG_IDEKEY: $XDEBUG_IDEKEY)"
}

# Cargar variables del .env
if [ -f .env ]; then
    load_env
else
    echo -e "${RED}Error: No se encontró el archivo .env${NC}"
    echo "Copia .env.example a .env y configura tus variables"
    exit 1
fi

echo -e "${GREEN}=== SETUP QUARTUP DEVELOPMENT MODE ===${NC}"
echo "Usuario: $USER_NAME"

if [ "$1" == "single" ]; then
    echo -e "${YELLOW}Configurando modo SINGLE...${NC}"
    
    # Configurar docker-compose para modo single
    cat > docker-compose.yml << EOF
version: "3.8"

services:
  php:
    build: .
    ports:
      - "${HTTP_PORT}:80"
      - "${DEBUG_PORT}:9003"
    volumes:
      - "${QUARTUP_PATH}:/app"
      - "./90-quartup.ini:/usr/local/etc/php/conf.d/90-quartup.ini"
      - "${LOG_PATH}:/var/log/apache2"
    container_name: "quartup-${USER_NAME}"
    env_file:
      - .env
    network_mode: host
EOF

    # Generar 90-quartup.ini desde template
    generate_ini
    
    echo -e "${GREEN}✓ Modo SINGLE configurado${NC}"
    echo "  - Directorio único: $QUARTUP_PATH -> /app"
    echo "  - URL: https://$SERVER_NAME"
    echo "  - Código en: $QUARTUP_PATH"
    echo ""
    echo "Para aplicar los cambios:"
    echo "  docker compose down"
    echo "  docker compose up -d"
    echo ""
    echo "Para cambiar a multi más tarde:"
    echo "  ./setup-mode.sh multi"

elif [ "$1" == "multi" ]; then
    echo -e "${YELLOW}Configurando modo MULTI...${NC}"
    
    # Configurar docker-compose para modo multi
    cat > docker-compose.yml << EOF
version: "3.8"

services:
  php:
    build: .
    ports:
      - "${HTTP_PORT}:80"
      - "${DEBUG_PORT}:9003"
    volumes:
      - "./dev:/app"
      - "./90-quartup.ini:/usr/local/etc/php/conf.d/90-quartup.ini"
      - "${LOG_PATH}:/var/log/apache2"
    container_name: "quartup-${USER_NAME}"
    env_file:
      - .env
    network_mode: host
EOF

    # Crear directorio dev si no existe
    mkdir -p dev
    
    # Generar 90-quartup.ini desde template
    generate_ini
    
    echo -e "${GREEN}✓ Modo MULTI configurado${NC}"
    echo "  - Directorio múltiple: ./dev -> /app"
    echo "  - URLs disponibles:"
    echo "    * https://$SERVER_NAME/[nombre-rama]"
    echo "  - Use manage-branches.sh para gestionar ramas"
    echo ""
    echo "Para aplicar los cambios:"
    echo "  docker compose down"
    echo "  docker compose up -d"
    echo ""
    echo "Para cambiar a single más tarde:"
    echo "  ./setup-mode.sh single"

else
    echo -e "${RED}Uso: $0 [single|multi]${NC}"
    echo ""
    echo "Modos disponibles:"
    echo "  single - Un directorio, cambio rápido entre ramas"
    echo "  multi  - Múltiples directorios, múltiples ramas simultáneas"
    exit 1
fi 