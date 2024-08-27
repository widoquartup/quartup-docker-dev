<?php


ini_set('display_errors', 'off');
error_reporting(E_ERROR);

// nº de configuración del fichero 'quupconf', solo hay que cambiarla cuando hay varios working-copy del Quartup que usan la misma BBDD "general"
$quup['num_config'] = 1;

// directorio donde se ubican las clases de las vistas de la aplicación
$quup['viewDir'] = '../b_base_quartup';
//$quup['viewDir'] = '../b_base_doquier';

// true/false para ver las imágenes de login
$quup['swViewLoginImages'] = true;

// tipo de registro de sesiones de quartup
$quup['sessionType'] = 'sql';       // base de datos
/*
// cache de memoria APCU
$quup['sessionType'] = 'mem';
// cache de memoria memcached
$quup['sessionType'] = 'med';
*/
$quup['memcachedServer'] = array('localhost',11211);

// datos de configuración SQL a personalizar en los working-copy !!!
$quup['sqlServer']     = '127.0.0.1';       // servidor de conexión de 'Sql'
$quup['sqlUser']       = 'dev';             // usuario de conexión de 'Sql'
$quup['sqlPasswd']     = 'VkCMXAZrZZK7Es';  // password de conexión de 'sql'
$quup['sqlDBGenPrefix']= 'DEV';             // prefijo de la base de datos 'general'
$quup['sqlDBEmpPrefix']= 'DEV';             // prefijo de las bases de datos de la empresa
$quup['sqlDatabase']   = 'mySQL';           // posibles valores: mySQL, postgreSQL
$quup['sqlMode']       = null;              // si queremos forzar un valor, hay que asignar una string (string vacía fuerza asignar valor vacío, necesario en mysql 5.7)

// nº base-de-datos forzada, indica si trabaja con todas las bases de datos del muti-tenant (valor '0') o solo con una de ellas
// (los working-copy de una sola base de datos permiten tener varios working-copy compartiendo el multi-tenant,
//  pero con cada base-de-datos en revisiones diferentes)
// (hay que tener en cuenta que, en estos casos, la base de datos 'general' sigue estando compartida, por tanto las diferentes revisiones
//  han de ser compatibles con el mismo modelo de datos de 'general', solo pueden diferir en las revisiones de las aplicaciones)
$quup['num_bada']     = 0;

// indicador para forzar que la apertura de sesión recree las tablas principales de 'general'
// activarlo solo en actualizaciones de versiones antiguas que lo requieran, por eso aquí aparece comentado por defecto
//$quup['sw_general_create'] = true;

$quup['viewDir'] = array (
                        'mjl.localhost.quartup'   => '../b_base_quartup',
                        'mjl.localhost.avant'     => '../b_base_doquier',
                        'mjl.localhost.helio' => '../b_helio'
                        );
// dominio development
$quup['id_domain'] = 3;


