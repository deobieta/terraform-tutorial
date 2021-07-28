# 2-variables

En este ejercicio vamos a ver el uso de "Input Variables". Las configuraciones de Terraform pueden recibir variables como parametros, esto es útil si es que queremos reusar cierto código y solo cambiar valores en estas variables.

## Prompt variable

Cuando una variable es declarada, Terraform exigirá la entrada para poder ejecutar el "plan" y "apply".
Las variables declaradas para este ejercicio están en el archivo [variables.tf](https://github.com/deobieta/terraform-tutorial/blob/master/2-variables/variables.tf). Las configuraciones de Terraform pueden estar en archivos separados para una mejor organización del código siempre y cuando los archivos estén dentro del mismo directorio de trabajo donde Terraform se ejecuta.

    cd 2-variables/
    terraform init
    terraform plan

Nuestra variable no tiene un valor definido a la hora de ejecutar el plan, es por eso que Terraform pregunta el valor antes de proceder a ejecutar el plan. Para seguir puedes poner cualquier valor en el prompt.


## Valor default de una variable

Meter todos los valores de todas nuestras variables cada que queremos generar un plan no es una forma óptima de crear infraestructura, este proceso seguramente nos llevaría a tener errores humanos y dificilmente se podría automatizar. Existen varias formas de pasar los valores  de las variables a Terraform sin tener que proporcionarlos manualmente. Una forma es poner un valor "default" al declarar la variable. Para probar esta modalidad podemos descomentar la linea 4 en el archivo de [variables.tf](https://github.com/deobieta/terraform-tutorial/blob/master/2-variables/variables.tf) y volver a corre el plan. Nota que Terraform no pregunta el valor de la variable "bucket_name", eso es porque está tomando el valor por defecto de la configuración.

## Opciónes -var y -var-file

Los valores default de las variables se pueden sobrescribir a la hora de ejecutar un "plan" o "apply" utilizando las opciones "-var" y "-var-file".

    terraform plan -var 'bucket_name=bar'

Una vez mas poner multiples veces la opción "-var" por cada variable declarada puede ser propenso a errores. Aunque en algunos casos esta opción puede ser útil existe otra que nos permite pasar varios valores en conjunto y esa opción es "-var-file" que es un archivo donde definimos todos los valores de todas nuestras variables.

    echo 'bucket_name="bar"' > default.tfvars
    terraform plan -var-file=default.tfvars
    terraform apply -var-file=default.tfvars

El archivo de variables "default.tfvars" puede ser versionado de igual forma que las configuraciones de Terraform (siempre y cuando no contenga información sensible como contraseñas). La opción de "-var-file" también se puede declarar varias veces, esto es útil en el caso que quieras combinar varios sets de valores de variables.

## Outputs

Las configuraciones de Terraform así como aceptan entradas en variables también pueden tener salidas que se declaran como un "output". Estas salidas pueden ser útiles ya que se pueden usar como mera información de los recursos creados o como entradas de otros recursos dependientes de estas salidas. En este caso usamos el output "s3_bucket" para saber el nombre del bucket simplemente. 

Nota que el nombre aparece al final del comando apply.

    Outputs:

    s3_bucket_name = bar-6c6bbd42872ab01c

## Limpiar 

    terraform destroy -var-file=default.tfvars