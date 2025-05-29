# 🤝 Convivencia: Dos Estilos, Un Proyecto

Este proyecto permite que **convivan dos filosofías de desarrollo** sin conflictos:

## 🎯 Tu Estilo: Modo Single
**"Un directorio, git checkout para cambiar ramas"**
- ✅ Más eficiente y elegante
- ✅ Sin duplicación de archivos
- ✅ Cambios de rama rápidos
- ✅ Menor uso de disco

## 📂 Estilo Compañeros: Modo Multi
**"Una carpeta por rama para aislamiento total"**
- ✅ Aislamiento completo entre ramas
- ✅ Múltiples ramas simultáneas
- ✅ URLs con segmentos (`/sendcloud`, `/invoicing`)

## 🚀 Configuración Rápida

### Para Ti (Modo Single)
```bash
./setup-mode.sh single
docker compose down && docker compose up -d
```
**Resultado**: `https://devjmm.quartup.net` → `../quartup/`

### Para Compañeros (Modo Multi)
```bash
./setup-mode.sh multi
./manage-branches.sh clone-from-main sendcloud
docker compose down && docker compose up -d
```
**Resultado**: `https://devjmm.quartup.net/sendcloud` → `dev/sendcloud/`

## 🔄 Alternancia Sin Conflictos

### Cambiar a Modo Single (Tu preferencia)
```bash
./setup-mode.sh single
docker compose down && docker compose up -d

# Trabajar normalmente
cd ../quartup
git checkout feature-x
# Código disponible en: https://devjmm.quartup.net
```

### Cambiar a Modo Multi (Compañeros)
```bash
./setup-mode.sh multi
./manage-branches.sh clone-from-main feature-x
./manage-branches.sh clone-from-main hotfix-y
docker compose down && docker compose up -d

# URLs simultáneas:
# https://devjmm.quartup.net/feature-x
# https://devjmm.quartup.net/hotfix-y
```

## 📊 Comparación de Workflows

| Aspecto | Modo Single | Modo Multi |
|---------|-------------|------------|
| **URLs** | `devjmm.quartup.net` | `devjmm.quartup.net/<rama>` |
| **Directorio** | `../quartup/` | `dev/<rama>/` |
| **Cambio de rama** | `git checkout` | Crear carpeta nueva |
| **Espacio disco** | Mínimo | Más uso |
| **Ramas simultáneas** | Una activa | Todas activas |
| **Configuración** | `./setup-mode.sh single` | `./setup-mode.sh multi` |

## 💡 Casos de Uso Ideales

### Modo Single - Perfecto para:
- **Desarrollo normal**: Una rama a la vez
- **Equipos con disciplina Git**: Confían en branches
- **Proyectos grandes**: Donde el espacio importa
- **Desarrollo rápido**: Cambios frecuentes de rama

### Modo Multi - Perfecto para:
- **Desarrollo paralelo**: Múltiples features
- **Testing simultáneo**: Comparar ramas lado a lado
- **Equipos grandes**: Cada dev su rama
- **Demos**: Mostrar múltiples versiones

## 🔧 Scripts y Herramientas

### Gestión de Modo
```bash
./setup-mode.sh single    # Tu estilo
./setup-mode.sh multi     # Estilo compañeros
```

### Gestión de Ramas (Solo en modo multi)
```bash
./manage-branches.sh list                    # Ver ramas
./manage-branches.sh clone-from-main <rama>  # Crear rama
./manage-branches.sh create <rama>           # Rama vacía
```

### Contenedor Docker
```bash
docker compose down      # Parar
docker compose up -d     # Arrancar
docker compose logs -f   # Ver logs
```

## 🎭 Ejemplo de Convivencia Real

### Lunes: Trabajas en modo single
```bash
./setup-mode.sh single
docker compose up -d
cd ../quartup && git checkout feature-login
# Desarrollas en: https://devjmm.quartup.net
```

### Martes: Demo para el equipo (modo multi)
```bash
./setup-mode.sh multi
./manage-branches.sh clone-from-main feature-login
./manage-branches.sh clone-from-main hotfix-urgent
docker compose up -d

# Mostrar:
# https://devjmm.quartup.net/feature-login
# https://devjmm.quartup.net/hotfix-urgent
```

### Miércoles: Vuelves a single
```bash
./setup-mode.sh single
docker compose up -d
# Continúas desarrollo normal
```

## 🏆 Ventajas de la Convivencia

1. **Flexibilidad Total**: Cada desarrollador elige
2. **Sin Conflictos**: Los modos no interfieren
3. **Mismo Contenedor**: Una imagen para todo
4. **Fácil Cambio**: Script de una línea
5. **Misma URL Base**: Consistencia en configuración

## 🎯 Recomendación Final

**Para desarrollo diario**: Usa modo single (más eficiente)
**Para demos/comparaciones**: Cambia temporalmente a multi
**Para trabajar en equipo**: Respeta la preferencia de cada uno

La belleza está en que **no tienes que elegir definitivamente** - puedes cambiar según la situación lo requiera. 