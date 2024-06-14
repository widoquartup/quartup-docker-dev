Para la instalaci�n, dentro del usuario de cada uno hacer un clone del git 
cd quartup-dev-docker

Para la nomenclatura de cada puerto y que no nos pisemos tanto en apache como en debug usaremos el N� Usuario que podemos buscar en la ficha de nuestro ususario.

Por ej devgdo es el usuario 98
    Puerto http: 8198
    Puerto debug: 9198


Modificar en el archivo ./.env
------------------------------
HTTP_PORT=8198
DEBUG_PORT=9189
USER_NAME=devgdo   <<--modificar esta variable para que cada imagen y contenedor tenga su nombre

Crear el archivo ./.vscode/launch.json
------------------------------------------

{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "1 Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9198, // <<<----- Cambiar por el c�digo definido en el .env para debug
            "pathMappings": {
                "/app/flow/": "${workspaceRoot}/dev/flow/"
            }
        }
    ]
}

Modificar el archivo ./90-quartup.ini en la l�nea donde define el puerto para xdebug
------------------------------------------------------------------------------------
xdebug.remote_port=9198



Para comenzar a trabajar con alguna de las ramas que tenemos:
cd dev
sv2 clone <nombre_rama> -d <nombre_rama>
cd <nombre_rama>

Para crear el docker ejecutar:
    docker compose up -d

Si hacemos alguna modificaci�n a la configuraci�n del docker, podemos volver a generarlo con 

    docker compose up -d --build




