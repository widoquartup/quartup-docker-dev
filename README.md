#### Para la instalación, dentro de la carpeta de tu usuario hacer un clone del git 

    git clone git@github.com:widoquartup/quartup-docker-dev.git
    cd quartup-dev-docker
    sudo chgrp www-data dev

#### Usaremos puertos distintos para cada usuario tanto en apache como en debug. 
#### El Nº Usuario que podemos buscar en la ficha de nuestro usuario.

    Por ejemplo devgdo es el usuario 98

    Puerto http: 8198
    Puerto debug: 9198

#### Modificar en el archivo ./.env
    
    HTTP_PORT=8198
    DEBUG_PORT=9189
    USER_NAME=devgdo   <<--modificar esta variable para que cada imagen y contenedor tenga su nombre

#### Crear el archivo ./.vscode/launch.json
    
    {
        "version": "0.2.0",
        "configurations": [
            {
                "name": "1 Listen for Xdebug",
                "type": "php",
                "request": "launch",
                "port": 9198, // <<<----- Cambiar por el código definido en el .env para debug
                "pathMappings": {
                    "/app/<nombre_rama>/": "${workspaceRoot}/dev/<nombre_rama>/"
                }
            }
        ]
    }
    El ejemplo asume que estés navegando el código en tu visual studio code desde el directorio del docker, pero si has abierto el code desde la carpeta de la rama cambiar por 
        "pathMappings": {
            "/app/sendcloud/": "${workspaceRoot}/"
        }

#### Modificar el archivo ./90-quartup.ini en la línea donde define el puerto para xdebug

    xdebug.remote_port=9198

#### Para crear el docker ejecutar:
    docker compose -p docker-<nombre-usuario> up -d

#### Si hacemos alguna modificación a la configuración del docker, podemos volver a generarlo con 

    docker compose -p docker-<nombre-usuario> up -d --build

#### Crear un archivo en el servidor para el vhost 

    etc/apache2/sites-available/docker-<nombre-usuario>.ssl.conf                                                                                          

    <VirtualHost *:443>
        ServerName docker-<nombre-usuario>.quartup.net
        DocumentRoot /var/www/html
    
        ErrorLog /home/<nombre-usuario>/docker/error.log
        CustomLog /home/<nombre-usuario>/docker/access.log combined

        ProxyPreserveHost On
        RequestHeader set X-Forwarded-Proto "https"
        RequestHeader set X-Forwarded-Port "443"
    
        ProxyPass / http://localhost:8198/           <<----- cambiar puerto
        ProxyPassReverse / http://localhost:8198/    <<----- cambiar puerto
    
        SSLEngine on
        SSLCertificateFile      /var/www/SSLCert/server.bundle
        SSLCertificateKeyFile   /var/www/SSLCert/server.key
    
    </VirtualHost>

#### Crear el archivo quartup.ini.php en el directorio dev
    Crear una copia del archivo quptmp.ini.php con el nombre quartup.ini.php dentro del directorio dev

#### Habilitar el vhost en el servidor de desarrollo

    sudo a2ensite docker-<nombre-usuario>.ssl.conf   
    sudo service apache2 restart

#### Acceso al subdominio
    
    Si no tienes registrado el subdominio docker-<nombre-usuario>.quartup.net puedes crear un acceso en tu ordenador en el archivo hosts
        /etc/hosts (linux / mac)  
        C:\Windows\System32\Drivers\etc\hosts (windows)

    # añadir una nueva línea
    95.217.59.110 docker-<nombre-usuario>.quartup.net

#### Para comenzar a trabajar con alguna de las ramas:

    crear la/s rama/s dentro del directorio quartup-dev-docker/dev

    cd dev
    sv2 clone <nombre_rama> -d <nombre_rama>
    cd <nombre_rama>

    Url de la rama: https://docker-<nombre-usuario>.quartup.net/<nombre_rama>
