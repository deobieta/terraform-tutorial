# Terraform

**Saltar a tema:**

* [Resumen del tutorial](https://github.com/deobieta/terraform-tutorial/blob/master/README.md#resumen-del-tutorial)
* [Crear usuario administrador para el tutorial](https://github.com/deobieta/terraform-tutorial/blob/master/README.md#crear-usuario-administrador-para-el-tutorial)
* [Establece llaves de acceso en la configuracion de Terraform](https://github.com/deobieta/terraform-tutorial/blob/master/README.md#establece-llaves-de-acceso-en-la-configuracion-de-terraform)
* [Ejercicio 1. Intro](https://github.com/deobieta/terraform-tutorial/blob/master/1-intro/README.md)
* [Ejercicio 2. Variables](https://github.com/deobieta/terraform-tutorial/blob/master/2-variables/README.md)
* [Ejercicio 3. Módulos](https://github.com/deobieta/terraform-tutorial/blob/master/3-modules/README.md)
* [Ejercicio 4. Workspaces](https://github.com/deobieta/terraform-tutorial/blob/master/4-workspaces/README.md)
* [Ejercicio 5. Remote state (pendiente)](https://github.com/deobieta/terraform-tutorial/blob/master/5-remote-state/README.md)

## Resumen del tutorial

El tutorial tiene como finalidad hacer una introducción al uso de IaC (Infraestructura como código) con [Terraform](<https://www.terraform.io/>).

Antes de comenzar el tutorial es necesario completar los siguientes pasos:

* [Tener una cuenta en AWS](<https://aws.amazon.com>)
* [Instalar Terraform >= 0.13](<https://www.terraform.io/downloads.html>)

Las herramientas que utilizaremos en el tutorial son:

* [Terraform](<https://www.terraform.io/>) (Herramienta para construir, cambiar y versionar infraestructura de manera segura y eficiente.)

## Crear usuario administrador para el tutorial

Entra a la cuenta que vas a utilizar en el tutorial y navega a la consola de usuarios [IAM](https://console.aws.amazon.com/iam/home?region=us-east-2#/users).

Agrega un nuevo usuario que se llame "workshop"

![user output](/readme-images/iam/1.png)

Dar permisos de administrador al nuevo usuario (AdministratorAccess).

IMPORTANTE: Por practicidad le damos estos permisos al usuario, en el mundo real siempre es mejor dar el menor número de permisos a un usuario o rol.

![perms output](/readme-images/iam/2.png)

Descargar las llaves de acceso para hacer llamadas al API de AWS.

![keys output](/readme-images/iam/3.png)

## Establece llaves de acceso en la configuracion de Terraform

Para establecer las llaves de acceso puedes exportar las credenciales como variables de ambiente. 

    $ export AWS_ACCESS_KEY_ID="AKIAJ3RAVUDDQWJSQ"
    $ export AWS_SECRET_ACCESS_KEY="BpXA8AbiC1vgZUTVrKIe8YjP0Q9VDu"

También puedes usar el editor de tu elección, abrir el archivo provider.tf, descomentar las dos lineas de las llaves de accesso y reemplazar el texto "ACCESS_KEY_HERE" y "SECRET_KEY_HERE".

## Terraform

Terraform es una herramienta para crear, cambiar y versionar infraestructura. Terraform utiliza archivos de texto donde podemos describir la configuración de lo que queremos crear o modificar, Terraform se encarga de leer e interpretar estos archivos, crear un plan para posteriormente aplicarse con el fin de llegar al estado descrito en las configuraciones. Este proceso es de gran ayuda al crear o modificar infraestructura ya que podemos ver los pasos que se van a tomar para lograrlo, reduciendo drasticamente errores humanos que se podrían producir al hacerlo de forma manual o utilizando alguna herramienta que no lleve un estado de la infraestructura creada.

Las configuraciones de Terraform son archivos de texto de tal forma se pueden reutilizar para crear ambientes parecidos e integrar con cualquier sistema de control de versiones (git) para versionar la infraestructura.

Algunas ventjas de tener infraestructura como código (IaC)

- Documentación
- Control de Versiones
- Automatizar infraestructura
- Utilizar templetes y repetir (Múltiples ambientes)
- Minimizar error humano


## Intro

[Instrucciones](https://github.com/deobieta/terraform-tutorial/blob/master/1-intro/README.md)


## Variables

[Instrucciones](https://github.com/deobieta/terraform-tutorial/blob/master/2-variables/README.md)


## Modules

[Instrucciones](https://github.com/deobieta/terraform-tutorial/blob/master/3-modules/README.md)


## Workspaces (pendiente)

[Instrucciones](https://github.com/deobieta/terraform-tutorial/blob/master/4-workspaces/README.md)

## Remote state (pendiente)

[Instrucciones](https://github.com/deobieta/terraform-tutorial/blob/master/5-remote-state/README.md)


![user output](/readme-images/mgc.gif)
