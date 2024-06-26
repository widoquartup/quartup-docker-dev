Para la instalación, dentro del usuario de cada uno hacer un clone del git 

    cd quartup-dev-docker

Para la nomenclatura de cada puerto y que no nos pisemos tanto en apache como en debug usaremos el Nº Usuario que podemos buscar en la ficha de nuestro ususario.

Por ej devgdo es el usuario 98

    Puerto http: 8198
    Puerto debug: 9198


Modificar en el archivo ./.env
------------------------------
    
    HTTP_PORT=8198     <<<----- Cambiar por el puerto http que corresponda
    DEBUG_PORT=9189    <<<----- Cambiar por el puerto debug que corresponda
    USER_NAME=devgdo   <<--     Cambiar por el nombre de usuario para que cada imagen y contenedor tenga su nombre
    
Modificar el archivo ./90-quartup.ini en la línea donde define el puerto para xdebug
------------------------------------------------------------------------------------

    xdebug.remote_port=9198 // <<<----- Cambiar por el código definido en el .env para debug
    
Crear el archivo ./.vscode/launch.json
------------------------------------------
Si abres vscode en la carpeta del repositorio docker

    {
        "version": "0.2.0",
        "configurations": [
            {
                "name": "Xdebug en docker",
                "type": "php",
                "request": "launch",
                "port": 9198, // <<<----- Cambiar por el código definido en el .env para debug
                "pathMappings": {
                    "/app/": "${workspaceRoot}/dev/"
                }
            }
        ]
    }

Si abres vscode en la carpeta de la rama

    {
        "version": "0.2.0",
        "configurations": [
            {
                "name": "Xdebug en docker",
                "type": "php",
                "request": "launch",
                "port": 9198, // <<<----- Cambiar por el código definido en el .env para debug
                "pathMappings": {
                    "/app/<nombre de la rama o carpeta>/": "${workspaceRoot}/"
                }
            }
        ]
    }



Para comenzar a trabajar con alguna de las ramas que tenemos:

    cd dev
    sv2 clone <nombre_rama> -d <nombre_rama>
    cd <nombre_rama>

Para crear el docker ejecutar:

    docker compose up -d

Si hacemos alguna modificación a la configuración del docker, podemos volver a generarlo con 

    docker compose up -d --build


Crear un archivo en el servidor para el vhost 
----------------------------------------------

    /etc/apache2/sites-available/docker-<nombre-usuario>.ssl.conf                                                                                          

    <VirtualHost *:443>
        ServerName docker-<nombre-usuario>.quartup.net
        DocumentRoot /var/www/html
    
        ErrorLog /home/<nombre-usuario>/docker/error.log
        CustomLog /home/<nombre-usuario>/docker/access.log combined
    
        ProxyPass / http://localhost:8198/           <<----- cambiar puerto http
        ProxyPassReverse / http://localhost:8198/    <<----- cambiar puerto http
    
        SSLEngine on
        SSLCertificateFile      /var/www/SSLCert/server.bundle
        SSLCertificateKeyFile   /var/www/SSLCert/server.key
    
    </VirtualHost>

    
Crear el archivo quartup.ini.php en el directorio dev
-----------------------------------------------------
Crear una copia del archivo quptmp.ini.php con el nombre quartup.ini.php dentro del directorio dev


Copiar el archivo de tu dev QquupperfIntFile.json al directorio dev del docker

Crear en dev el directorio quptmp.outs y asignar permisos 777

    mkdir quptmp.outs
    chmod 0777 quptmp.outs


Habilitar el vhost
------------------

    sudo a2ensite docker-<nombre-usuario>.ssl.conf   
    sudo service apache2 restart

