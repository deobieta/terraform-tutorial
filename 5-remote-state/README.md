# 5-remote-state

A lo largo de los ejercicios de este tutorial el estado de la infraestructura (state) se ha estado creando de forma local en un archivo llamado terraform.tfstate. Normalmente una colección de infraestructura es mantenida por un equipo de tal forma que todos los integrantes del equipo deben tener acceso a este archivo para modificar el estado de la infraestructura. El problema de tener el archivo de estado de forma local o en un sistema de control de versiones dificulta la modificación de infraestructura ya que todos los involucrados deben tener la última versión del estado y deben evitar aplicar cambios al mismo tiempo. 

Configurar un estado remoto permite que Terraform escriba el archivo  terraform.tfstate en un lugar remoto compartido con todos los miembros del equipo con opción de configurar un candado para no permitir modificaciones de infraestructura al mismo tiempo.

En este ejercicio vamos a configurar el estado remoto utilizando un bucket de AWS S3.


    cd 5-remote-state/
    terraform init
    
    terraform plan
    Refreshing Terraform state in-memory prior to plan...
    The refreshed state will be used to calculate this plan, but will not be
    persisted to local or remote state storage.


    ------------------------------------------------------------------------

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # aws_s3_bucket.remote_state will be created...

    terraform apply
    ...

    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

    Outputs:

    remote_state_bucket = terraform-tutorial-remote-state-330b3fc56a336563


Para configurar el estado remoto mueve el archivo backend.tf.keep > backend.tf. Copia y pega el output remote_state_bucket en el atributo "bucket" en el archivo backend.tf.


    mv backend.tf.keep backend.tf
    
Edita backend.tf con cualquier editor de texto.


    terraform {
      backend "s3" {
        bucket         = "terraform-tutorial-remote-state-330b3fc56a336563"
        key            = "terraform.tfstate"
        region         = "us-east-2"
      }
    }

Reinicializa el backend de la configuración de Terraform.

    terraform init

    Initializing the backend...
    Do you want to copy existing state to the new backend?
    Pre-existing state was found while migrating the previous "local" backend to the
    newly configured "s3" backend. No existing state was found in the newly
    configured "s3" backend. Do you want to copy this state to the new "s3"
    backend? Enter "yes" to copy and "no" to start with an empty state.

    Enter a value: yes


    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.


Para probar que a partir de este momento no vamos a utilizar el estado local podemos borrarlo y crear un plan para asegurarnos que Terraform está usando el estado remoto de S3.

    rm terraform.tfstate
    terraform plan


Ahora podemos compartir esta configuración con nuestro equipo para todos puedan tener acceso a la última versión del estado remoto.


Para borrar este ejercicio es preferible borrar el bucket de S3 desde la consola de AWS, también puedes aplicar un "terraform destroy" y el bucket efectivamente se borrará pero Terraform acabará la aplicación con un error dado que el bucket donde guarda el estado remoto dejará de existir.

