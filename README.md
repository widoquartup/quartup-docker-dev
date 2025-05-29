# 🐳 Quartup Docker Development Environment

Entorno de desarrollo Docker moderno y flexible para el proyecto Quartup, con configuración centralizada y soporte para múltiples estilos de trabajo.

## 🚀 Quick Start

```bash
# 1. Clonar el repositorio
git clone git@github.com:widoquartup/quartup-docker-dev.git
cd quartup-docker-dev

# 2. Configurar tu entorno
cp .env.example .env
nano .env  # Personalizar con tus datos

# 3. Configurar modo de trabajo
./setup-mode.sh single  # o 'multi' según tu preferencia

# 4. Levantar el entorno
docker compose up -d
```

¡Listo! Tu entorno estará disponible en `https://dev[tu-usuario].quartup.net`

## 📚 Documentación

### 🔧 [Configuración Centralizada](README-CONFIGURACION.md)
- Sistema de variables con `.env`
- Configuración personalizada por desarrollador
- Setup automático de puertos y dominios

### 🤝 [Convivencia de Estilos](README-CONVIVENCIA.md)
- Modo Single vs Multi
- Comparación de flujos de trabajo
- Casos de uso recomendados

## 🎯 Características Principales

- **🔧 Configuración Centralizada**: Todo en un archivo `.env`
- **🔄 Modo Dual**: Trabaja en single o multi-directorio
- **🚀 Setup Automático**: Scripts que configuran todo por ti
- **🛡️ Sin Conflictos**: Cada desarrollador tiene su configuración
- **📦 Zero Config**: Funciona out-of-the-box

## 🔧 Variables Principales

Solo necesitas personalizar estas variables en tu `.env`:

```bash
HTTP_PORT=8920          # Tu puerto HTTP único
DEBUG_PORT=9920         # Tu puerto Xdebug único
USER_NAME=jmmunoz       # Tu nombre de usuario
SERVER_NAME=devjmm.quartup.net  # Tu dominio
```

## 🎮 Comandos Útiles

### Cambiar Modo de Trabajo
```bash
./setup-mode.sh single    # Un directorio, cambio rápido de ramas
./setup-mode.sh multi     # Múltiples directorios, ramas simultáneas
```

### Gestionar Ramas (modo multi)
```bash
./manage-branches.sh list
./manage-branches.sh clone-from-main feature-nueva
./manage-branches.sh remove rama-vieja
```

### Docker
```bash
docker compose up -d           # Levantar
docker compose down            # Parar
docker compose up -d --build   # Rebuild
```

## 🆚 Modos de Trabajo

| Aspecto | Single Mode | Multi Mode |
|---------|-------------|------------|
| **Directorios** | `../quartup` → `/app` | `./dev/rama` → `/app` |
| **URLs** | `devjmm.quartup.net` | `devjmm.quartup.net/rama` |
| **Cambio rama** | `git checkout` | Navegar carpetas |
| **Espacio disco** | ⭐⭐⭐ | ⭐⭐ |
| **Aislamiento** | ⭐⭐ | ⭐⭐⭐ |

## 🛠️ Requisitos

- Docker & Docker Compose
- Git configurado con acceso al repositorio
- Puerto HTTP único (ej: 8920)
- Puerto Debug único (ej: 9920)

## 🆘 Troubleshooting

### Puerto en uso
```bash
# Cambiar puertos en .env
HTTP_PORT=8930
DEBUG_PORT=9930
```

### Xdebug no conecta
```bash
# Verificar configuración en .env
XDEBUG_IDEKEY=tu-usuario
DEBUG_PORT=9920
```

### Problemas de permisos
```bash
sudo chgrp www-data dev
```

## 🔗 Links Útiles

- **Apache Config**: `/etc/apache2/sites-available/docker-[usuario].ssl.conf`
- **Logs**: `/home/[usuario]/Desarrollo/`
- **SSL Certs**: `/var/www/SSLCert/`

## 🤖 Scripts Incluidos

- `setup-mode.sh` - Configurar modo single/multi
- `manage-branches.sh` - Gestionar ramas en modo multi
- `setup-environment.sh` - Setup inicial completo

---

💡 **¿Primera vez?** Lee [README-CONFIGURACION.md](README-CONFIGURACION.md) para entender el sistema completo.

🤝 **¿Trabajas en equipo?** Revisa [README-CONVIVENCIA.md](README-CONVIVENCIA.md) para workflows colaborativos.
