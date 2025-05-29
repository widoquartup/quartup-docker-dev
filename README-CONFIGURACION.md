# 🔧 Configuración Centralizada con .env

Este proyecto utiliza un archivo `.env` para centralizar toda la configuración, haciendo más fácil la personalización por desarrollador y evitando conflictos.

## 📋 Configuración Inicial

### 1. Crear tu archivo .env
```bash
cp .env.example .env
```

### 2. Personalizar variables
Edita `.env` con tus datos específicos:

```bash
# Configuración de puertos (único por desarrollador)
HTTP_PORT=8920      # Puerto HTTP para el servidor web
DEBUG_PORT=9920     # Puerto para Xdebug

# Información del desarrollador
USER_NAME=jmmunoz   # Tu nombre de usuario

# Rutas del proyecto
QUARTUP_PATH=../quartup                        # Ruta al código principal
LOG_PATH=/home/jmmunoz/Desarrollo             # Ruta para logs

# Configuración de Xdebug
XDEBUG_IDEKEY=jmmunoz                         # Tu clave para Xdebug
XDEBUG_REMOTE_HOST=127.0.0.1                 # IP para conexión debug

# URLs y dominios
SERVER_NAME=devjmm.quartup.net               # Tu dominio principal
```

## 🎯 Variables Importantes

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `HTTP_PORT` | Puerto web único por desarrollador | `8920` |
| `DEBUG_PORT` | Puerto Xdebug único por desarrollador | `9920` |
| `USER_NAME` | Nombre del desarrollador | `jmmunoz` |
| `QUARTUP_PATH` | Ruta al código principal | `../quartup` |
| `XDEBUG_IDEKEY` | Identificador para debugging | `jmmunoz` |
| `SERVER_NAME` | Dominio de desarrollo | `devjmm.quartup.net` |

## 🚀 Uso de Scripts

### Cambiar Modo de Trabajo
```bash
# Modo single (un directorio)
./setup-mode.sh single

# Modo multi (múltiples directorios)
./setup-mode.sh multi
```

### Gestionar Ramas (modo multi)
```bash
# Listar ramas existentes
./manage-branches.sh list

# Crear nueva rama desde principal
./manage-branches.sh clone-from-main nueva-feature

# Eliminar rama
./manage-branches.sh remove vieja-rama
```

## ⚙️ Archivos Generados Automáticamente

### 1. docker-compose.yml
Se genera automáticamente usando las variables del `.env`:
- Puertos únicos por desarrollador
- Rutas personalizadas
- Nombre de contenedor único

### 2. 90-quartup.ini
Archivo de configuración PHP que se genera desde `90-quartup.ini.template`:
- Configuración Xdebug personalizada
- Puertos de debug únicos
- IDE key específico del desarrollador

## 🔄 Flujo de Trabajo

### Primera Configuración
```bash
# 1. Copiar configuración
cp .env.example .env

# 2. Editar con tus datos
nano .env

# 3. Configurar modo preferido
./setup-mode.sh single

# 4. Aplicar cambios
docker compose down
docker compose up -d
```

### Cambio de Modo
```bash
# Cambiar a multi
./setup-mode.sh multi
docker compose down
docker compose up -d

# Volver a single
./setup-mode.sh single
docker compose down
docker compose up -d
```

## 🚨 Seguridad

El archivo `.env` está incluido en `.gitignore` para evitar:
- ✅ Conflictos entre desarrolladores
- ✅ Exposición de datos sensibles
- ✅ Puertos duplicados en el equipo

## 🛠️ Ventajas de esta Configuración

### ✅ Centralizada
- Todas las variables en un solo lugar
- Fácil personalización por desarrollador
- No más edición manual de múltiples archivos

### ✅ Dinámica
- Archivos de configuración generados automáticamente
- Sin conflictos de merge en git
- Cambio de modo instantáneo

### ✅ Segura
- Configuración personal no versionada
- Puertos únicos evitan conflictos
- Template con valores de ejemplo

## 🔍 Troubleshooting

### Error: "No se encontró el archivo .env"
```bash
cp .env.example .env
```

### Conflicto de puertos
Cambia `HTTP_PORT` y `DEBUG_PORT` en tu `.env` por valores únicos.

### Xdebug no conecta
Verifica que `XDEBUG_IDEKEY` coincida con tu IDE y que `DEBUG_PORT` esté disponible.

---

💡 **Tip**: Cada desarrollador puede tener su propia configuración sin afectar a los demás gracias al sistema de variables centralizadas. 