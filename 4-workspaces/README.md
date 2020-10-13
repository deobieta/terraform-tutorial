# 4-workspaces

Terraform nos ayuda a manejar una colección de recursos dentro del directorio donde están definidas las configuraciones de esos recursos, el estado de la infraestructura y variables. Cada "workspace" comparte las configuraciones de Terraform pero puede tener diferentes variables (tfvars) y debe tener un estado (terrafom.tfstate) diferente. De esta forma se puede crear diferentes ambientes de la misma colección de recursos. 

Al inicializar un directorio de Terraform lo que realmente está pasando es que estamos inicializando un workspace, en específico el workspace "default". Depende de nuestra forma de administrar los recursos si es que realmente queremos usar el workspace "default" o crear otros workspaces con nombres mas significativos.

## Nuevo workspace 

    $ cd 4-workspaces/
    $ terraform init
    $ terraform workspace list
    * default

    $ terraform workspace new dev 
    Created and switched to workspace "dev"!

    $ terraform workspace new prod
    Created and switched to workspace "prod"!

    $ terraform workspace list
    default
    dev
    * prod


## Diferentes ambientes y mismas configuraciones

Vamos a utilizar nuestro workspace "dev" primero para crear infraestructura, antes que nada debemos saber qué workspace estamos usando actualmente.

    $ terraform workspace show
    prod

Para cambiar de workspace lo podemos hacer de la siguiente forma.

    $ terraform workspace select dev
    $ terraform workspace select dev
    Switched to workspace "dev".


En este ejercicio vamos a ver cómo pasar un archivo de variables al "plan" y "apply" de tal forma que las configuraciones de Terraform no contengan alguna refrencia directa con el workspace en si y la creación de recursos entre workspaces sea transparente.


    terraform plan -var-file=dev.tfvars
    Plan: 4 to add, 0 to change, 0 to destroy.

    $ terraform apply -var-file=dev.tfvars
    module.s3_bucket_1[0].random_id.this: Creating...
    module.s3_bucket_2.random_id.this: Creating...
    module.s3_bucket_2.random_id.this: Creation complete after 0s [id=v5TAGJPUkqw]
    module.s3_bucket_1[0].random_id.this: Creation complete after 0s [id=fURvH9pMZqI]
    module.s3_bucket_1[0].aws_s3_bucket.this: Creating...
    module.s3_bucket_2.aws_s3_bucket.this: Creating...
    module.s3_bucket_2.aws_s3_bucket.this: Creation complete after 5s [id=dev-foo-dos-bf94c01893d492ac]
    module.s3_bucket_1[0].aws_s3_bucket.this: Creation complete after 5s [id=dev-foo-dos-7d446f1fda4c66a2]

    Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

    Outputs:

    s3_bucket_1_name = [
    "dev-foo-uno-7d446f1fda4c66a2",
    ]
    s3_bucket_2_name = [
    "dev-foo-dos-bf94c01893d492ac",
    ]


Creamos dos buckets en el workspace "dev", el nombre de los buckets sale de 3 lugares diferentes. Ver el archivo (main.tf)

"dev" viene de la variable "terraform.workspace" esta variable siempre está disponible en un workspace.

"foo-uno" y "foo-dos" viene del archivo "dev.tfvars" donde definimos las variables de nuestro workspace "dev".

"7d446f1fda4c66a2" y "bf94c01893d492ac" viene del módulo que estamos usando para crear los buckets donde existe un recurso que genera un random_id y lo pega al final del nombre del bucket.


## Condicionales

Digamos que en dev queremos crear dos buckets pero en prod solo uno. Sí corremos nuestra configuración tal cual está en el workspace prod se crearían los dos buckets. Podemos usar un tipo de de condicional que lo que hace es poner la cuenta del recurso en 0 y de esta forma no se crea el recurso en cierta condición. Todo recurso de Terraform tiene un atributo "count" que se puede manipular en ciertas situaciones.

En la linea 4 del archivo main.tf podemos leer la condición. La condición es que el recurso solo se va a crear si el workspace se llama "dev".

    $ terraform workspace select prod
    Switched to workspace "prod".
    
    $ terraform plan -var-file=prod.tfvars
    Plan: 2 to add, 0 to change, 0 to destroy

    $ terraform apply -var-file=prod.tfvars
    module.s3_bucket_2.random_id.this: Creating...
    module.s3_bucket_2.random_id.this: Creation complete after 0s [id=mJ_kIZDJBq4]
    module.s3_bucket_2.aws_s3_bucket.this: Creating...
    module.s3_bucket_2.aws_s3_bucket.this: Creation complete after 5s [id=prod-bar-dos-989fe42190c906ae]

    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

    Outputs:

    s3_bucket_1_name = []
    s3_bucket_2_name = [
    "prod-bar-dos-989fe42190c906ae",
    ]

El plan muestra que solo se van a crear dos recursos, el bucket y el random_id para el nombre del bucket_2.
El nombre del bucket sale de las mismas partes que los recursos de dev solamente utilizamos otro archivo de variables (prod.tfvars).


## Limpiar 

    $ terraform workspace select dev
    Switched to workspace "dev".

    $ terraform destroy -var-file=dev.tfvars

    $ terraform workspace select prod
    Switched to workspace "prod".

    $ terraform destroy -var-file=prod.tfvars