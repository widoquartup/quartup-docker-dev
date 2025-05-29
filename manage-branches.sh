#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

# Cargar variables del .env
if [ -f .env ]; then
    load_env
else
    echo -e "${RED}Error: No se encontró el archivo .env${NC}"
    echo "Copia .env.example a .env y configura tus variables"
    exit 1
fi

echo -e "${BLUE}=== GESTOR DE RAMAS MÚLTIPLES ===${NC}"
echo "Usuario: $USER_NAME"
echo "Directorio base: ./dev"

if [ "$1" == "list" ]; then
    echo -e "${YELLOW}Ramas disponibles en modo multi:${NC}"
    if [ -d "dev" ]; then
        for dir in dev/*/; do
            if [ -d "$dir" ]; then
                branch=$(basename "$dir")
                echo "  📂 $branch"
                echo "     URL: https://$SERVER_NAME/$branch"
            fi
        done
    else
        echo "No hay ramas clonadas aún. Use 'clone-from-main <nombre>' para crear una."
    fi

elif [ "$1" == "clone-from-main" ] && [ -n "$2" ]; then
    BRANCH_NAME=$2
    echo -e "${YELLOW}Clonando rama '$BRANCH_NAME' desde $QUARTUP_PATH...${NC}"
    
    if [ ! -d "$QUARTUP_PATH" ]; then
        echo -e "${RED}Error: No se encuentra el directorio $QUARTUP_PATH${NC}"
        exit 1
    fi
    
    mkdir -p dev
    cp -r "$QUARTUP_PATH" "dev/$BRANCH_NAME"
    
    echo -e "${GREEN}✓ Rama '$BRANCH_NAME' creada${NC}"
    echo "  📂 Ubicación: dev/$BRANCH_NAME"
    echo "  🌐 URL: https://$SERVER_NAME/$BRANCH_NAME"

elif [ "$1" == "remove" ] && [ -n "$2" ]; then
    BRANCH_NAME=$2
    if [ -d "dev/$BRANCH_NAME" ]; then
        echo -e "${YELLOW}Eliminando rama '$BRANCH_NAME'...${NC}"
        rm -rf "dev/$BRANCH_NAME"
        echo -e "${GREEN}✓ Rama '$BRANCH_NAME' eliminada${NC}"
    else
        echo -e "${RED}La rama '$BRANCH_NAME' no existe${NC}"
    fi

else
    echo -e "${RED}Uso: $0 [comando] [argumentos]${NC}"
    echo ""
    echo "Comandos disponibles:"
    echo "  list                    - Listar ramas existentes"
    echo "  clone-from-main <rama>  - Clonar desde $QUARTUP_PATH"
    echo "  remove <rama>           - Eliminar una rama"
    echo ""
    echo "Ejemplos:"
    echo "  $0 list"
    echo "  $0 clone-from-main feature-login"
    echo "  $0 remove old-branch"
fi 