# 🐳 Quartup Docker Development Environment

Sistema multicarpeta para desarrollo simultáneo de múltiples ramas.

## 🎯 Concepto Original Restaurado

**Una imagen Docker** que sirve **múltiples ramas** simultáneamente:
- ✅ Un solo contenedor Docker
- ✅ Múltiples carpetas de rama en `dev/`
- ✅ URLs con segmentos: `/sendcloud`, `/invoicing`, etc.
- ✅ Todas las ramas accesibles al mismo tiempo

## 📁 Estructura de Directorios

```
~/Desarrollo/
├── quartup-docker-dev/     (configuración Docker)
│   ├── dev/
│   │   ├── sendcloud/      (rama sendcloud)
│   │   ├── invoicing/      (rama invoicing)
│   │   └── main/           (rama main)
│   └── docker-compose.yml
└── quartup/                (código principal - opcional)
```

## 🚀 Configuración

### Configuración inicial
```bash
# 1. Configurar puertos y usuario en .env
HTTP_PORT=8920
DEBUG_PORT=9920
USER_NAME=jmmunoz

# 2. Levantar el contenedor
docker compose up -d --build
```

### Crear ramas
```bash
# Crear rama clonando desde quartup principal
./manage-branches.sh clone-from-main sendcloud

# Crear rama vacía
./manage-branches.sh create invoicing

# Copiar desde otro directorio
./manage-branches.sh copy main ../otro-proyecto

# Listar ramas existentes
./manage-branches.sh list
```

## 🌐 URLs de Acceso

**Todas las ramas funcionan simultáneamente:**
- `https://devjmm.quartup.net/sendcloud`
- `https://devjmm.quartup.net/invoicing`
- `https://devjmm.quartup.net/main`
- `https://jmm.localhost/sendcloud`

## 🔧 Gestión de Ramas

### Comandos disponibles

| Comando | Descripción |
|---------|-------------|
| `./manage-branches.sh create <rama>` | Crear rama vacía |
| `./manage-branches.sh clone-from-main <rama>` | Clonar desde ../quartup |
| `./manage-branches.sh copy <rama> <origen>` | Copiar directorio |
| `./manage-branches.sh list` | Listar ramas |

### Ejemplos prácticos
```bash
# Crear nueva rama para feature
./manage-branches.sh clone-from-main nueva-funcionalidad

# Crear rama de hotfix
./manage-branches.sh create hotfix-urgente

# Ver todas las ramas
./manage-branches.sh list
```

## 🐛 Debug Configuration

**Configuración automática para múltiples ramas:**
- **Puerto**: 9920
- **IDE Key**: jmmunoz

### VS Code Launch Configuration
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "1 Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9920,
            "pathMappings": {
                "/app/": "${workspaceRoot}/dev/"
            }
        }
    ]
}
```

**Para debuggear rama específica:**
- Abre VS Code desde `quartup-docker-dev/dev/sendcloud/`
- O ajusta pathMappings: `"/app/sendcloud/": "${workspaceRoot}/"`

## 💡 Ventajas del Sistema

1. **Una imagen, múltiples ramas**: Eficiencia máxima
2. **Acceso simultáneo**: Todas las URLs funcionan al mismo tiempo
3. **Desarrollo paralelo**: Múltiples desarrolladores, múltiples ramas
4. **Aislamiento**: Cada rama es independiente
5. **Flexibilidad**: Fácil crear/eliminar ramas

## 🔄 Workflow Típico

### Desarrollador que prefiere una rama
```bash
# Trabajar solo en sendcloud
cd dev/sendcloud
# Editar código...
# Acceder: https://devjmm.quartup.net/sendcloud
```

### Desarrollador que necesita múltiples ramas
```bash
# Crear múltiples ramas
./manage-branches.sh clone-from-main feature-a
./manage-branches.sh clone-from-main feature-b

# Acceder simultáneamente:
# https://devjmm.quartup.net/feature-a
# https://devjmm.quartup.net/feature-b
```

## 🆘 Troubleshooting

### Rama no responde
```bash
# Verificar que existe la carpeta
ls dev/

# Reiniciar contenedor si es necesario
docker compose down && docker compose up -d
```

### Debug no conecta
1. Verificar puerto 9920 libre
2. Confirmar pathMappings en launch.json
3. Reiniciar VS Code

### Crear nueva rama
```bash
# Desde código principal
./manage-branches.sh clone-from-main nueva-rama

# Desde otra rama existente
./manage-branches.sh copy nueva-rama dev/rama-existente
```

## 🎯 Resumen

Este sistema permite que **todos tengan su preferencia**:
- **Una rama**: Trabajar solo en `dev/mi-rama/`
- **Múltiples ramas**: Acceder a `/rama-a`, `/rama-b`, etc.
- **Mismo contenedor**: Una imagen sirve todo
- **URLs simultáneas**: Todo funciona al mismo tiempo 