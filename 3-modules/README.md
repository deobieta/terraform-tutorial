# 3-modules

Un módulo puede agrupar multiples recursos que serán usados en conjunto o crear abstracciones de nuestra infraestructura en base a su arquitectura. Un módulo es reutilizable y ayuda a reducir la cantidad de código necesario para construir infraestructura.

En si los archivos de configuración en el directorio de este ejercicio (3-modules/) también forman un módulo llamado root. Desde el módulo root podemos conectar otros módulos, muchas veces lo hacemos pasando outputs de un modulo como input variables de otro módulo.

El concepto de módulo se puede comparar con una función en un lenguaje de programación tradicional, donde los "Input variables" son los argumentos de la función, los "Output values" son los valores que regresa una función y los "Local values" son variables temporales locales de la función. 

## Múltiples módulos

Supongamos que nuestro módulo de [S3](https://github.com/deobieta/terraform-tutorial/blob/master/modules/s3-one-level) es una abstracción compleja de nuestra infraestructura. En el archivo [main.tf](https://github.com/deobieta/terraform-tutorial/blob/master/3-modules/main.tf) viene un ejemplo de cómo llamar el mismo modulo múltiples veces para crear esa parte supuestamente "compleja". Esto es útil para reducir codigo, de igual forma reduce la complejidad de uso del código y creación de infraestructura.

    $ cd 3-modules/
    $ terraform init
    $ terraform plan
    $ terraform apply

Con unas cuantas lineas de código y variables podemos crear arquitecturas complejas y reutilizar el código dentro de un módulo.


## Loops en módulos 

Desde Terraform v0.13 podemos usar for_each y count dentro de módulos. Esto facilita aún más la repetición de  infraestructura similar. El archivo "for-each.tf.keep" no es considerado por Terraform ya que no termina con la extensión correcta (.tf). Para el siguienete ejercicio es necesario cambiar el nombre del archivo para que Terraform lo cargue duarnte el plan y apply.

    $ mv for-each.tf.keep for-each.tf
    $ terraform get # necesario para instalar módulos o también se puede utilizar init
    $ terraform plan
    module.s3_bucket_2.random_id.this: Refreshing state... [id=M-tGPnW9Nro]
    module.s3_bucket_1.random_id.this: Refreshing state... [id=n-hoXp8Dqzg]
    module.s3_bucket_1.aws_s3_bucket.this: Refreshing state... [id=uno-9fe8685e9f03ab38]
    module.s3_bucket_2.aws_s3_bucket.this: Refreshing state... [id=dos-33eb463e75bd36ba]
    ...

    Plan: 12 to add, 0 to change, 0 to destroy.

    $ terraform apply
    ...

    Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

    Outputs:

    s3_bucket_1_name = uno-9fe8685e9f03ab38
    s3_bucket_2_name = dos-33eb463e75bd36ba
    s3_bucket_ocho_name = ocho-elocho-959b875e8c9473d5
    s3_bucket_tres_name = tres-9ea73b3f789edc1f


Una vez aplicado el plan se crearon 12 recursos, si vemos el archivo [for-each.tf](https://github.com/deobieta/terraform-tutorial/blob/master/3-modules/for-each.tf.keep) hay dos ejemplos para usar for_each dentro de módulos, uno con una lista simple como variable y otro con un map como variable. Cada ejemplo crea 3 buckets y 3 recursos de random_id que se asigna como nombre en el bucket, la suma de esos recursos da 12 recursos.

En el módulo solo queremos ciertos outputs en específico pero se puede tener acceso a todos los outputs (nombres de los buckets) del módulo.

## Módulos multi nivel

El archivo main.tf tiene un ejemplo de módulo de un nivel, es decir, el módulo [s3-one-level](https://github.com/deobieta/terraform-tutorial/blob/master/modules/s3-one-level) no incluye ningún otro módulo para crear la infraestructura pero puede ser que en algún tipo de infraestructura sea necesario crear módulos multi nivel. En el archivo for-each.tf el módulo que usamos es un módulo que incluye otros dos módulos ( [random-id](https://github.com/deobieta/terraform-tutorial/blob/master/modules/random-id y [bucket](https://github.com/deobieta/terraform-tutorial/blob/master/modules/bucket)) para crear la infraestructura. Los módulos multi nivel pueden agregar complejidad al uso del mismo módulo y acceso a outputs.  
El módulo multi nivel en este ejercicio es simplemente un ejemplo normalmente su uso no es necesario.


## Limpiar 

    $ terraform destroy