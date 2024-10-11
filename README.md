# ControlDEX

**Test de aplicación móvil para ControlCar.** La aplicación móvil muestra los diversos pokemones que existen, dando la capacidad de capturar, eliminar y buscar pokemones.

## Características

- Muestra primeros 150 pokemones
- Gestión de pokemones capturados
- Búsqueda de pokemones
- Muestra de pokemones capturados

## Capturas de Pantalla
![1728678790888 (1)](https://github.com/user-attachments/assets/25f645cb-626d-4478-8040-766ccd2cb0b7)
![1728678790896 (1)](https://github.com/user-attachments/assets/a674633a-97e4-4c0e-9273-cde4a1f60570)
![1728678790875 (1)](https://github.com/user-attachments/assets/bca274bc-563d-4fd2-8b1c-e2637ee11e82)
![1728678790883 (1)](https://github.com/user-attachments/assets/70730ab5-fecd-4be4-a6fa-99a2eaa76480)

## Como usar
- Dentro de la vista principal podremos buscar pokemones por nombre y tipo
- Cada card representa un pokemon
   1. Al hacer click podremos agregar el pokemon a la lista de pokemones capturados
   2. Al hacer doble click sobre un pokemon capturado podremos eliminarlo de la lista de pokemones capturados
- En la vista de capturados podremos ver los pokemones capturados

## Requisitos

- Flutter SDK (versión 3.0.0 o superior)
- Dart SDK (versión 2.16.0 o superior)
- Xcode (para desarrollo en iOS)
- Android Studio (para desarrollo en Android)

## Instalación

Sigue estos pasos para clonar e instalar el proyecto en tu entorno local:

1. Clona el repositorio:

   ```sh
   git clone https://github.com/nicopv-dev/controlcar-app-test.git
   cd controlcar-app-test
   ```

2. Correr aplicación
   ```sh
   flutter run
   ```

## Ambiente de desarrollo

En caso de probar la aplicacion bajo el entorno local con el servidor configurar lo siguiente:
   1. Ir al archivo **constants.dart** y usar la variable API_URL con eL valor correspondiente a su IP local
   ```sh
   static const API_URL = "http://IP_LOCAL:3000"
   ```

## 📲Demo

En el siguiente [enlace](https://drive.google.com/file/d/1pTDhqHw0T8KAHOBTwGd8DvKZU8u1bsvN/view?usp=sharing) podrás descargar y probar la aplicación en un dispositivo Android.
> **Nota:** Para instalar la aplicacion es recomendable activar la configuracion que permita la instalacion de aplicaciones de una fuente desonocida

⚙️Desarrollado por [_Nicolas Pereira_](https://nicolaspereira.cl)
