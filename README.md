# Parcial 2 - Pruebas automáticas de software

## Recursos
Para la realización de las pruebas se utiliza la máquina Macbook pro de Apple con las siguientes configuraciones y versiones de las tecnologías asociadas:

**MacBook pro 13**

procesador 2.5 GHz Intel Core i5, ram 12 GB 1333 MHz DDR3, Disco duro 500Gb, graphics Intel HD Graphics 4000 1536 MB.

**Software**

MacOS: versión 10.14.1 (Mojave)
Android Studio:  versión 3.1.4
calabash-android: versión 0.9.8
cucumber: versión 3.1.2
node: versión 8.10
ruby: versión 2.3.7

**Emulador**

AVD Manager - Android Studio
Nexus 5, Sistema operativo Android Oreo versión 8.0 cpu(x86), display 1080x1920

## Estrategia

Se usará para las pruebas la gema de ruby Android-calabash que facilita la escritura y la descripción de los casos de prueba usando como lenguaje o tecnología cucumber. Esto facilita enormemente las pruebas y optimiza el tiempo.

## Desarrollo

Se procede a realizar el firmado de la aplicación para su posterior instalación.

Se crea el proyecto y haciendo uso de calabash-android  

    $ calabash-android gen

Se realiza el procedimiento inicialmente para la línea base de la aplicación, es decir, la aplicación se deja al nivel de la carpeta feature y se ejecuta el comando

    $ calabash-android resign com.evancharlton.mileage_3110.apk

Inicialmente se realiza la instalación del apk en el emulador.

    $ calabash-android run com.evancharlton.mileage_3110.apk

Sin embargo al ejecutar el comando, se presenta un error. Averiguando el origen se establece que Calabash necesita los permisos necesarios del app para ejecutar los steps.

![Error Firma](images/ErrorFirma.png)