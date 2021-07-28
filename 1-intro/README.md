# 1-intro

En este ejercicio vamos a crear un bucket de S3 con Terraform. El objetivo del ejercicio es entender el proceso básico Terraform para crear infraestructura.

## terrafom init

El comando ["init"](https://www.terraform.io/docs/commands/init.html) lee las configuraciones presentes en el directorio donde estamos parados actualmente y si encuentra una configuración de Terraform válida, prepará el directorio para ejecutar comandos de Terraform. Entre otras funciones el comando init checa la versión instalada de Terraform y versiones de módulos a usar, inicializa un [backend](https://www.terraform.io/docs/backends/config.html) para guardar el estado (terraform.tfstate) de nuestra infraestructura, instalación de [providers](https://www.terraform.io/docs/providers/index.html) (plugins) definidos en la configuración de Terraform.

     cd 1-intro/
     terraform init

Existen plugins de proveedores de servicios como "hashicorp/aws" o plugins que proveen alguna funcionalidad local como lo hace "hashicorp/random" que se encarga de crear un valor aleatorio que será parte del nombre de un bucket de S3.
Una vez inicializado nuestro directorio de trabajo podemos ejectuar otros comandos de Terraform.

## terrafom plan

Antes de crear infraestructura debemos crear un ["plan"](https://www.terraform.io/docs/commands/plan.html), el proceso normal de un plan es ejecutar un ["refresh"](https://www.terraform.io/docs/commands/refresh.html) que es el proceso que reconcilia el mundo real con nuestro estado de Terraform (terraform.tfstate). Si existe alguna diferencia entre el estado y el mundo real, los cambios se verán reflejados en el plan, de esta forma tenemos opción de analizar que el plan sea realmente el estado deseado.

    terraform plan
    # aws_s3_bucket.intro will be created
    + resource "aws_s3_bucket" "intro" {
        + acceleration_status         = (known after apply)
        + acl                         = "private"
        + arn                         = (known after apply)
        + bucket                      = (known after apply)
        + bucket_domain_name          = (known after apply)
        + bucket_regional_domain_name = (known after apply)
        + force_destroy               = true
        + hosted_zone_id              = (known after apply)
        + id                          = (known after apply)
        + region                      = (known after apply)
        + request_payer               = (known after apply)
        + website_domain              = (known after apply)
        + website_endpoint            = (known after apply)

        + versioning {
            + enabled    = (known after apply)
            + mfa_delete = (known after apply)
            }
        }

    # random_id.intro will be created
    + resource "random_id" "intro" {
        + b64         = (known after apply)
        + b64_std     = (known after apply)
        + b64_url     = (known after apply)
        + byte_length = 8
        + dec         = (known after apply)
        + hex         = (known after apply)
        + id          = (known after apply)
        }

    Plan: 2 to add, 0 to change, 0 to destroy.


Terraform planea la manera más rápida de crear recursos de forma paralela y resuelve dependencias entre recursos de ser necesario. En nuestro ejercicio el nombre del bucket de S3 depende de la generación de un ID aleatorio generado por el recurso "random_id.intro" para posteriormente crear el recurso del bucket de S3 "aws_s3_bucket.intro".


## terrafom apply

Un vez generado el plan y este indica los movimientos correctos podemos correr el comando de ["apply"](https://www.terraform.io/docs/commands/apply.html) que es el que se va a encargar de crear o modificar nuestros recursos de acuerdo al plan. 

    terraform apply
    random_id.intro: Creating...
    random_id.intro: Creation complete after 0s [id=b68rke_OFEY]
    aws_s3_bucket.intro: Creating...
    aws_s3_bucket.intro: Creation complete after 5s [id=terraform-tutorial-6faf2b91efce1446]

    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

<b>IMPORTANTE:</b> Que un plan se ejecute de forma correcta no garantiza que aplicarlo ocurra de la misma forma ya que algunos cambios se validan solo a la hora de ser aplicados contra las APIs de los proveedores que se están usando en las configuraciónes de Terraform. Ej. El nombre único global de bucket de S3 se valida solo en "apply", esto quiere decir que si el nombre del bucket definido en la configuarción de Terraform está ocupado por otro bucket existente el comando "apply" va a fallar con el error correspondiente del API de AWS.

Si nuestro plan se aplicó de forma exitosa, al correr un nuevo plan no debería haber cambios por realizar ya que no hay diferencias entre el estado (terraform.tfstate) y el mundo real.

## Best practice

Una buena práctica al crear y aplicar planes es generar un archivo que contenga el plan de ejecución. 

    terraform plan -out=miplan
    terraform apply miplan


### ¿Por qué necesito generar un archivo que contenga mi plan?

Normalmente la infraestructura es manejada por un equipo de personas que modifican el mismo set de recursos, si ocurren cambios en el mundo real entre el momento que generas un plan y que lo aplicas los cambios podrían ser diferente al planeado en un principio y otros recursos podrían verse afectados. Por esta razón es una buena práctica siempre guradar el plan a ejecutarse, así estaremos 100% seguros que solo se van a realizar los cambios que deseamos.

## Limpiar 

    terraform destroy