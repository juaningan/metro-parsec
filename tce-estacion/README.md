# PC TCE de estación
## Descripción
Aplicación gráfica que concentra las diferentes acciones que se pueden realizar en cada estación. Se ejecuta sobre un sistema basado en el kernel Illumos.

## Instalación
El sistema no se instala si no que en cada reinicio se carga como si fuese una nueva instalación. Para ello carga, o bien por red, o bien desde el disco físico, un fichero `boot_archive` donde se encuentra todo lo necesario para funcionar.

Por lo tanto, es necesario que el equipo cumpla uno estos dos requisitos: 
* Tener conectividad de red y acceso al servidor adecuado
* Tener un disco previamente preparado

## Preparación del disco
Si el sistema cumple uno de los dos requisitos: arranca y comprueba si existe disco físico en la máquina. Si existe, lo prepara o actualiza.

## Configuración
Todos los equipos, en el momento del arranque, son genéricos, por lo que  deben cargar su propia configuración. Esta carga se puede realizar desde red o desde disco físico. Será requisito necesario que uno de los dos modos esté disponible.

### Repositorio git
Todas las configuraciones se centralizan en un repositorio git:
http://16.0.96.20:3000/metro/pctce-configs
Los cambios en las configuraciones deberían de hacerse directamente sobre el git, con el usuario adecuado. 

#### tce2git
Como el fabricante tiene un procedimiento propio donde manipula ficheros directamente en el sistema se ha creado un script que carga las últimas modificaciones realizadas. Se realiza una vez al día, por la noche. Estas modificaciones se identifican en el repositorio git con el usuario "repomirror"

## Entorno
Durante el arranque, una vez que ha extraído las configuraciones en el lugar adecuado, se realizan una serie de pasos que autodetectan y definirán variables de entorno. Se escriben en el fichero: `/home/metro/environment`

Al tratarse de una detección basado en ficheros dados por terceros es posible que no estén cubiertos todos los casos. Es un proceso propenso a errores. Por lo que es importante saber que se hace en cada paso y como se puede remediar un error. Las variables que se detectan son las siguientes:
* **Codigo administrativo (id)**
 Se busca en el fichero `/home/metro/sistema/V/CfgConfig.CFG`. Debe devolver un valor único de 5 cifras.
* **Tipo de cancela**
 Busca el puerto configurado para la `CANCELA` en el fichero `/home/metro/sistema/V/CfgConfig.CFG` y compara si es menor o mayor que 16. Si es menor es por UIS, si es mayor es por Maestra.
* **Plano**
 Busca la cadena `UI` dentro del fichero `/home/metro/sistema/V/CfgUI.CFG`. En los equipos sin plano no existe.
* **TCTI y tipo**
 Primero mira si tiene TCTI configurado buscando la cadena `tcti` en el fichero `/home/metro/sistema/V/CfgConfig.CFG`. Si la tiene comprueba que exista la entrada adecuada en el `/etc/hosts`: *tcti+hostname*. Y por último comprueba si en *tcti+hostname* hay un servicio escuchando en el puerto 23. Si no lo hay es TCTI nuevo y si lo hay es antiguo.
* **MBT**
 Busca la cadena `concen-mbt-ppp` en el `/etc/hosts` y de ahí extrae la IP. Además necesitamos saber el ID único de la MBT y este lo busca en el directorio `/home/metro/sistema/V/Mbt/MBT*`. Si no existiese el directorio daría error.

