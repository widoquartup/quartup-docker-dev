#!/bin/bash

# Script para configurar el entorno según las preferencias del desarrollador
# Uso: ./setup-environment.sh [single|multi] [nombre-rama]

source .env

MODE=${1:-$DIRECTORY_MODE}
BRANCH=${2:-$BRANCH_NAME}

echo "🔧 Configurando entorno Docker..."
echo "👤 Usuario: $USER_NAME"
echo "🌐 Puerto HTTP: $HTTP_PORT"
echo "🐛 Puerto Debug: $DEBUG_PORT"

case $MODE in
    "single")
        echo "📁 Modo: Directorio único"
        echo "📂 Directorio: ../$BASE_DIRECTORY"
        
        # Actualizar docker-compose.yml para modo single
        sed -i "s|volumes:.*|volumes:|" docker-compose.yml
        sed -i "/volumes:/a\\      - ../$BASE_DIRECTORY:/app" docker-compose.yml
        sed -i "/volumes:/,/- .*:\/app/!b; /- .*:\/app/!d" docker-compose.yml
        
        # Actualizar launch.json
        sed -i "s|\"\/app\/\": \".*\"|\"\/app\/\": \"\${workspaceRoot}\/../$BASE_DIRECTORY\/\"|" .vscode/launch.json
        
        echo "✅ Configurado para directorio único: $BASE_DIRECTORY"
        ;;
        
    "multi")
        if [ -z "$BRANCH" ]; then
            echo "❌ Error: En modo multi necesitas especificar una rama"
            echo "   Uso: ./setup-environment.sh multi nombre-rama"
            exit 1
        fi
        
        echo "📁 Modo: Múltiples directorios por rama"
        echo "📂 Directorio: ../$BASE_DIRECTORY-$BRANCH"
        
        # Crear directorio si no existe
        mkdir -p "../$BASE_DIRECTORY-$BRANCH"
        
        # Actualizar docker-compose.yml para modo multi
        sed -i "s|volumes:.*|volumes:|" docker-compose.yml
        sed -i "/volumes:/a\\      - ../$BASE_DIRECTORY-$BRANCH:/app" docker-compose.yml
        sed -i "/volumes:/,/- .*:\/app/!b; /- .*:\/app/!d" docker-compose.yml
        
        # Actualizar launch.json
        sed -i "s|\"\/app\/\": \".*\"|\"\/app\/\": \"\${workspaceRoot}\/../$BASE_DIRECTORY-$BRANCH\/\"|" .vscode/launch.json
        
        # Actualizar .env
        sed -i "s/BRANCH_NAME=.*/BRANCH_NAME=$BRANCH/" .env
        sed -i "s/DIRECTORY_MODE=.*/DIRECTORY_MODE=multi/" .env
        
        echo "✅ Configurado para rama: $BRANCH"
        echo "📁 Directorio creado: ../$BASE_DIRECTORY-$BRANCH"
        ;;
        
    *)
        echo "❌ Modo inválido: $MODE"
        echo "   Modos disponibles: single, multi"
        echo "   Uso: ./setup-environment.sh [single|multi] [nombre-rama]"
        exit 1
        ;;
esac

echo ""
echo "🚀 Para aplicar los cambios ejecuta:"
echo "   docker compose down"
echo "   docker compose up -d --build"
echo ""

case $MODE in
    "single")
        echo "🌐 URL de acceso: https://devjmm.quartup.net"
        ;;
    "multi")
        echo "🌐 URL de acceso: https://devjmm.quartup.net"
        echo "   (Contenido desde: $BASE_DIRECTORY-$BRANCH)"
        ;;
esac 