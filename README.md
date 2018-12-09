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

## Estrategia y Desarrollo

Se usará para las pruebas la gema de ruby Android-calabash que facilita la escritura y la descripción de los casos de prueba usando los steps predefinidos ahorrando tiempo y esfuerzo.

Se procede entonces a realizar pruebas E2E sobre la aplicación móvil MileAge disponible para Android.

APLICACIÓN **MileAge**

Aplicación creada para llevar el control de consumo de combustible de uno o más vehículo y realizar estadísticas de consumo, viajes, consumo por vehículo y demás donde se pueden editar desde los registros de consumo hasta el tipo de automotor pasando por el vehículo como tal.

![app1](images/app1.png)

![app2](images/app2.png)

![app3](images/app3.png)

![app4](images/app4.png)

![app5](images/app5.png)

Se procede a realizar el firmado de la aplicación para su posterior instalación.

Se crea el proyecto y haciendo uso de calabash-android  

    $ calabash-android gen

Se realiza el procedimiento inicialmente para la línea base de la aplicación, es decir, la aplicación se deja al nivel de la carpeta feature y se ejecuta el comando

    $ calabash-android resign com.evancharlton.mileage_3110.apk

Inicialmente se realiza la instalación del apk en el emulador.

    $ calabash-android run com.evancharlton.mileage_3110.apk

Sin embargo al ejecutar el comando, se presenta un error. Averiguando el origen se establece que Calabash necesita los permisos necesarios del app para ejecutar los steps.

![Error Firma](images/ErrorFirma.png)

## Decoding

Se requiere en este punto decompilar el apk 

![decodingAPK](images/decodingAPK.png)

y convertir el empaquetado a código fuente nuevamente

![originalCode](images/originalCode.png)

modificar el archivo `manifest.xml` para adiciónar la línea

    ...
    <uses-permission android:name="android.permission.INTERNET"/>
    ...

![AndroidManifestModify](images/manifestModify.png)

y compilar nuevamente el paquete para generar el apk. Para tal fin se ejecuta el comando

    $ java -jar apktool.jar b .

De esta forma, se compila el código nuevamente y genera el apk en la carpeta `dist/` de la ubicación actual.

![buildAPK](images/buildApk.png)

Ahora el apk está listo para ser firmado nuevamente y generar el certificado necesario para instalar la aplicación en el emulador. Para este punto se ejecuta el comando

    $ calabash-android resign com.evancharlton.mileage_3110.apk

Después del firmado de la aplicación, se ejecuta el comando

    $ calabash-android run com.evancharlton.mileage_3110.apk

Este comando, instala la aplicación en el emulador y corre el test de prueba para seleccionar la opción `Vehicles` dentro del app.

![runBaseLine](images/executeBaseLine.png)

Se crean los features que permiten a través de diferentes escenarios probar la creación, actualización y eliminación de vehículo y fillup.

![BaseLineGif](src/baseline/FillUpTest_CalabashAndroid.gif)

Dichos features, se ejecutan por cada grupo de mutantes para establecer o encontrar el error en cada una de las versiones tomadas.

---
## Oráculo

La línea base de la aplicación (ORÁCULO) genera ejecutando los escenarios, los siguientes screenshots a comparar:

### Fillup

![0](src/baseline/screenshots/screenshot_0.png)

![1](src/baseline/screenshots/screenshot_1.png)

### Vehicle

![2](src/baseline/screenshots/screenshot_2.png)

![3](src/baseline/screenshots/screenshot_3.png)

![4](src/baseline/screenshots/screenshot_4.png)

![5](src/baseline/screenshots/screenshot_5.png)

---

# Resultado de la ejecución de las pruebas de fillup y vehicle.

## Mutante 41-58 WRONG_MAIN_ACTIVITY

El mutante presente problemas en la interfaz de usuario y siempre muestra la misma UI con errores de conexión a la bd local.

Todos los casos de pruebas son ejecutados y  todos generaron problemas a la hora de validar los features.

El problema generado fue de timeout.

Timeout waiting for elements: * marked:'Fillup' (Calabash::Android::WaitHelpers::WaitError)
        features/fillup.feature:4:in `When I press "Fillup"'
        Then I enter "9800" into input field number 1

map * marked:'Vehicles', query failed because: java.util.concurrent.TimeoutException
       (RuntimeError)
      features/vehicle.feature:42:in `When I press "Vehicles"'

Cada uno de los steps generaron problemas de timeout porque no encontraba los textos requerdiso, los botones, o las condiciones necesarias para ejecutar correctamente los escenarios.

**Log**

    makito$ calabash-android run com.evancharlton.mileage_3110.apk
    No test server found for this combination of app and calabash version. Recreating test server.

    Warning:
    The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore /Users/makito/.android/debug.keystore -destkeystore /Users/makito/.android/debug.keystore -deststoretype pkcs12".
    Done signing the test server. Moved it to test_servers/17c8a370bd203945bbc45a2c1b59d2a1_0.9.8.apk
    Feature: fillup Scenarios

    Success
    Success
    Scenario: As a valid user I can create fillup                    # features/fillup.feature:3
        When I press "Fillup"                                          # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Timeout waiting for elements: * marked:'Fillup' (Calabash::Android::WaitHelpers::WaitError)
        features/fillup.feature:4:in `When I press "Fillup"'
        Then I enter "9800" into input field number 1                  # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "5" into input field number 2                     # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "134000" into input field number 3                # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I press view with id "date"                               # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I set the date to "08-12-2018" on DatePicker with index 1 # calabash-android-0.9.8/lib/calabash-android/steps/date_picker_steps.rb:2
        Then I press view with id "button1"                            # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press view with id "partial"                            # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press view with id "save_btn"                           # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press "History"                                         # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I take a screenshot                                       # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9
        Then I should see text containing "12/8/18"                    # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13

    Scenario: As a valid user I can edit fillup     # features/fillup.feature:17
        When I press "History"                        # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Timeout waiting for elements: * marked:'History' (Calabash::Android::WaitHelpers::WaitError)
        features/fillup.feature:18:in `When I press "History"'
        Then I should see text containing "12/8/18"   # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13
        Then I long press "12/8/18" and select "Edit" # calabash-android-0.9.8/lib/calabash-android/steps/context_menu_steps.rb:8
        Then I clear input field number 2             # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:21
        Then I enter "10" into input field number 2   # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I hide the keyboard                      # features/step_definitions/calabash_steps.rb:3
        Then I wait                                   # calabash-android-0.9.8/lib/calabash-android/steps/progress_steps.rb:5
        Then I press view with id "save_btn"          # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I take a screenshot                      # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9
        Then I should see text containing "10.00 g"   # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13

    Feature: Vehicle Scenarios

    Scenario: As a valid user I can create new car                      # features/vehicle.feature:3
        When I press "Vehicles"                                           # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Timeout waiting for elements: * marked:'Vehicles' (Calabash::Android::WaitHelpers::WaitError)
        features/vehicle.feature:4:in `When I press "Vehicles"'
        Then I press the menu key                                         # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:5
        # Then I wait
        Then I press "Add new vehicle"                                    # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I enter "Mazda3" into input field number 1                   # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "2019" into input field number 2                     # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "Japón" into input field number 3                    # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "Grand Touring" into input field number 4            # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "Con tecnología SkyActive" into input field number 5 # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        # Then I press view with id "type"
        # Then I press list item number 1
        Then I scroll down                                                # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I press view with id "distance"                              # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press "Kilometers"                                         # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I scroll down                                                # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I press view with id "economy"                               # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press "Km / Gallon"                                        # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I scroll down                                                # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I press view with id "save_btn"                              # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I take a screenshot                                          # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9
        Then I should see text containing "Mazda3"                        # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13

    Scenario: As a valid user I can edit Mazda3 car                                 # features/vehicle.feature:26
        When I press "Vehicles"                                                       # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Timeout waiting for elements: * marked:'Vehicles' (Calabash::Android::WaitHelpers::WaitError)
        features/vehicle.feature:27:in `When I press "Vehicles"'
        Then I should see text containing "Mazda3"                                    # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13
        Then I long press "Mazda3" and select "Edit"                                  # calabash-android-0.9.8/lib/calabash-android/steps/context_menu_steps.rb:8
        # Then I press press the "Mazda3"
        Then I clear input field number 5                                             # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:21
        Then I enter "Descripción actualizada del vehículo" into input field number 5 # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I hide the keyboard                                                      # features/step_definitions/calabash_steps.rb:3
        Then I wait                                                                   # calabash-android-0.9.8/lib/calabash-android/steps/progress_steps.rb:5
        Then I scroll down                                                            # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I scroll down                                                            # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I press view with id "save_btn"                                          # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I take a screenshot                                                      # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9
        Then I should see text containing "Descripción actualizada del vehículo"      # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13

    Scenario: As a valid user I set Mazda3 has default car # features/vehicle.feature:41
        When I press "Vehicles"                              # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        map * marked:'Vehicles', query failed because: java.util.concurrent.TimeoutException
        (RuntimeError)
        features/vehicle.feature:42:in `When I press "Vehicles"'
        Then I should see text containing "Mazda3"           # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13
        Then I long press "Mazda3" and select item number 1  # calabash-android-0.9.8/lib/calabash-android/steps/context_menu_steps.rb:1
        Then I take a screenshot                             # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9

    Scenario: As a valid user I can delete default car    # features/vehicle.feature:47
        When I press "Vehicles"                             # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Timeout waiting for elements: * marked:'Vehicles' (Calabash::Android::WaitHelpers::WaitError)
        features/vehicle.feature:48:in `When I press "Vehicles"'
        Then I should see text containing "Default vehicle" # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13
        # Then I long press "Default vehicle" and select "Delete"
        Then I long press "Default vehicle"                 # calabash-android-0.9.8/lib/calabash-android/steps/context_menu_steps.rb:15
        Then I press "Edit"                                 # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I hide the keyboard                            # features/step_definitions/calabash_steps.rb:3
        Then I wait                                         # calabash-android-0.9.8/lib/calabash-android/steps/progress_steps.rb:5
        Then I press the menu key                           # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:5
        Then I press "Delete"                               # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I press "OK"                                   # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I don't see "Default vehicle"                  # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:27
        Then I take a screenshot                            # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9

    Failing Scenarios:
    cucumber features/fillup.feature:3 # Scenario: As a valid user I can create fillup
    cucumber features/fillup.feature:17 # Scenario: As a valid user I can edit fillup
    cucumber features/vehicle.feature:3 # Scenario: As a valid user I can create new car
    cucumber features/vehicle.feature:26 # Scenario: As a valid user I can edit Mazda3 car
    cucumber features/vehicle.feature:41 # Scenario: As a valid user I set Mazda3 has default car
    cucumber features/vehicle.feature:47 # Scenario: As a valid user I can delete default car

    6 scenarios (6 failed)
    67 steps (6 failed, 61 skipped)
    4m16.536s

La aplicación presenta Error desde el primer pantallazo y no puede realizar el proceso de pruebas generando errores de timeout.

## vrt

![1](src/baseline/diff/diff4158_1.png)

![2](src/baseline/diff/diff4158_2.png)

![3](src/baseline/diff/diff4158_3.png)

![4](src/baseline/diff/diff4158_4.png)

![5](src/baseline/diff/diff4158_5.png)

![6](src/baseline/diff/diff4158_6.png)

---

## Mutante 4263 CLOSING_NULL_CURSOR

El mutante presente problemas en la interfaz de usuariosobre el feature: As a Valid User I can edit fillup.

El problema generado fue de HTTPClient: KeepAliveDisconnected.

    Then I clear input field number 2             # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:21
      HTTPClient::KeepAliveDisconnected: Connection reset by peer @ io_fillbuf - fd:7  (HTTPClient::KeepAliveDisconnected)
      features/fillup.feature:22:in `Then I clear input field number 2'


    Failing Scenarios:
    cucumber features/fillup.feature:17 # Scenario: As a valid user I can edit fillup

    6 scenarios (1 failed, 5 passed)
    67 steps (1 failed, 6 skipped, 60 passed)
    1m45.554s

**Log**

    makitos-mbp:baseline makito$ calabash-android run com.evancharlton.mileage_3110.apk
    No test server found for this combination of app and calabash version. Recreating test server.

    Warning:
    The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore/Users/makito/.android/debug.keystore -destkeystore /Users/makito/.android/debug.keystore -deststoretype pkcs12".
    Done signing the test server. Moved it to test_servers/eafa52e935c96ad1fa5f2d88f6c90fe3_0.9.8.apk
    Feature: fillup Scenarios

    Success
    Success
    Scenario: As a valid user I can create fillup                    # features/fillup.feature:3
        When I press "Fillup"                                          # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I enter "9800" into input field number 1                  # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "5" into input field number 2                     # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "134000" into input field number 3                # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I press view with id "date"                               # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I set the date to "08-12-2018" on DatePicker with index 1 # calabash-android-0.9.8/lib/calabash-android/steps/date_picker_steps.rb:2
        Then I press view with id "button1"                            # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press view with id "partial"                            # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press view with id "save_btn"                           # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press "History"                                         # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I take a screenshot                                       # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9
        Then I should see text containing "12/8/18"                    # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13

    Scenario: As a valid user I can edit fillup     # features/fillup.feature:17
        When I press "History"                        # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I should see text containing "12/8/18"   # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13
        Then I long press "12/8/18" and select "Edit" # calabash-android-0.9.8/lib/calabash-android/steps/context_menu_steps.rb:8
        Warning: This predefined step is deprecated.
        Then I clear input field number 2             # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:21
        HTTPClient::KeepAliveDisconnected: Connection reset by peer @ io_fillbuf - fd:7  (HTTPClient::KeepAliveDisconnected)
        features/fillup.feature:22:in `Then I clear input field number 2'
        Then I enter "10" into input field number 2   # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I hide the keyboard                      # features/step_definitions/calabash_steps.rb:3
        Then I wait                                   # calabash-android-0.9.8/lib/calabash-android/steps/progress_steps.rb:5
        Then I press view with id "save_btn"          # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I take a screenshot                      # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9
        Then I should see text containing "10.00 g"   # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13

    Feature: Vehicle Scenarios

    Scenario: As a valid user I can create new car                      # features/vehicle.feature:3
        When I press "Vehicles"                                           # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I press the menu key                                         # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:5
        # Then I wait
        Then I press "Add new vehicle"                                    # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I enter "Mazda3" into input field number 1                   # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "2019" into input field number 2                     # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "Japón" into input field number 3                    # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "Grand Touring" into input field number 4            # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I enter "Con tecnología SkyActive" into input field number 5 # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        # Then I press view with id "type"
        # Then I press list item number 1
        Then I scroll down                                                # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I press view with id "distance"                              # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press "Kilometers"                                         # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I scroll down                                                # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I press view with id "economy"                               # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I press "Km / Gallon"                                        # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I scroll down                                                # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I press view with id "save_btn"                              # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I take a screenshot                                          # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9
        Then I should see text containing "Mazda3"                        # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13

    Scenario: As a valid user I can edit Mazda3 car                                 # features/vehicle.feature:26
        When I press "Vehicles"                                                       # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I should see text containing "Mazda3"                                    # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13
        Then I long press "Mazda3" and select "Edit"                                  # calabash-android-0.9.8/lib/calabash-android/steps/context_menu_steps.rb:8
        Warning: This predefined step is deprecated.
        # Then I press press the "Mazda3"
        Then I clear input field number 5                                             # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:21
        Then I enter "Descripción actualizada del vehículo" into input field number 5 # calabash-android-0.9.8/lib/calabash-android/steps/enter_text_steps.rb:9
        Then I hide the keyboard                                                      # features/step_definitions/calabash_steps.rb:3
        Then I wait                                                                   # calabash-android-0.9.8/lib/calabash-android/steps/progress_steps.rb:5
        Then I scroll down                                                            # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I scroll down                                                            # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:36
        Then I press view with id "save_btn"                                          # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:13
        Then I take a screenshot                                                      # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9
        Then I should see text containing "Descripción actualizada del vehículo"      # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13

    Scenario: As a valid user I set Mazda3 has default car # features/vehicle.feature:41
        When I press "Vehicles"                              # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I should see text containing "Mazda3"           # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13
        Then I long press "Mazda3" and select item number 1  # calabash-android-0.9.8/lib/calabash-android/steps/context_menu_steps.rb:1
        Warning: This predefined step is deprecated.
        Then I take a screenshot                             # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9

    Scenario: As a valid user I can delete default car    # features/vehicle.feature:47
        When I press "Vehicles"                             # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I should see text containing "Default vehicle" # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:13
        # Then I long press "Default vehicle" and select "Delete"
        Then I long press "Default vehicle"                 # calabash-android-0.9.8/lib/calabash-android/steps/context_menu_steps.rb:15
        Then I press "Edit"                                 # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I hide the keyboard                            # features/step_definitions/calabash_steps.rb:3
        Then I wait                                         # calabash-android-0.9.8/lib/calabash-android/steps/progress_steps.rb:5
        Then I press the menu key                           # calabash-android-0.9.8/lib/calabash-android/steps/navigation_steps.rb:5
        Then I press "Delete"                               # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I press "OK"                                   # calabash-android-0.9.8/lib/calabash-android/steps/press_button_steps.rb:17
        Then I don't see "Default vehicle"                  # calabash-android-0.9.8/lib/calabash-android/steps/assert_steps.rb:27
        Then I take a screenshot                            # calabash-android-0.9.8/lib/calabash-android/steps/screenshot_steps.rb:9

    Failing Scenarios:
    cucumber features/fillup.feature:17 # Scenario: As a valid user I can edit fillup

    6 scenarios (1 failed, 5 passed)
    67 steps (1 failed, 6 skipped, 60 passed)
    1m45.554s

## VRT

![4263](src/baseline/diff/diff4263.png)