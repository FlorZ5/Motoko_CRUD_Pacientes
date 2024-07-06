# CRUD para la gestión de pacientes
El presente proyecto desarrollado en motoko, consiste en un CRUD para la gestión y manejo de pacientes en consultorios médicos y servicios de salud. Pensado en agilizar dicho proceso, sus funciones permiten realizar las acciones necesarias para una correcta administración, sin procesos tediosos o repetitivos.  
Siendo el objetivo del mismo, facilitar la gestión de altas, bajas, cambios y consultas de los pacientes que acudan a algún servicio de salud.  
Al ser una aplicación backend facilitará la implementación del frontend en cualquier lenguaje. Cabe mencionar, que para garantizar la integridad de los datos se han impelementado diversas validaciones que permiten que los datos obtenidos sean consistentes.

# Funciones del CRUD
Como se mencionó, el presente proyecto contiene diversas funciones que componen cada una de las acciones del CRUD, es por ello que a continuación se expone cada una de ellas, en el orden que se deberán usar para obtener el mejor provecho del programa.

## Función crearRegistro
Trata de una función publica que ayuda a crear el registro de un nuevo paciente, siendo lo equivalente a una alta dentro del CRUD; devolviendo como resultado en consola un mensaje confirmante y el ID del paciente, mientras que en Candid UI un mensaje de true y la información del registro recientemente creado.  
Así mismo, dentro de ella se manda a llamar la función publica generaID, misma que genera de forma automatica el ID para el paciente a registrar, usandose el ID para la creación del registro.  
Realiza la creación mediante un hasmap que recibe como parametros el ID del paciente y su información.  
Cabe mencionar que de forma general se cuenta con una validación que evita que los campos envien valores vacios, notificandolo con un mensaje en consola y devolviendo un false en Candid UI. 
Contemplando los siguientes valores y validaciones para su creación:    
- Nombre
  - Descipción: deberá de recibir el nombre/s del paciente, siento del tipo text.
  - Validaciones: verifica que la cantidad de caracteres que contiene el texto se encuentre entre 3 y 50. De no cumplir con ello envia el siguiente mensaje en consola: El nombre debe tener entre 3 y 50 caracteres y en Candid UI devuelve un false.
- Apellido paterno
  - Descripción: recibe el apellido paterno del paciente, su tipo de dato es text.
  - Validaciones: comprueba que la cantidad de caracteres en el texto se encuentre entre 3 y 50. En caso contrario se enviará el siguiente mensaje en consola: El apellido paterno debe tener entre 3 y 50 caracteres, mientras que en Candid UI devuelve un false.
- Apellido materno
  - Descripción: almacena el apellido materno del paiciente, cuyo tipo de dato es text.
  - Validaciones: asegura que la cantidad de caracteres en el texto se encuentre entre 3 y 50. Si la condición no se cumple devuelve el mensaje: El apellido materno debe tener entre 3 y 50 caracteres, en Candid UI retorna un false.
- Edad
  - Descripción: recibirá la edad del paciente, siendo su tipo de dato Nat8.
  - Validaciones: verifica que la edad se encuentre en un rango de entre 0 y 120. Si no se cumple en consola se imprime el siguiente mensaje: La edad debe estar entre 0 y 110, mientras que en Candid UI devuelve un false.
- Dirección
  - Descipción: debe de recibir la dirección completa del paciente, siento del tipo text.
  - Validaciones: valida que la cantidad de caracteres que contiene el texto de la dirección se encuentre entre 10 y 100. De no cumplir con ello envia el siguiente mensaje en consola: La dirección debe tener entre 10 y 100 caracteres caracteres y en Candid UI devuelve un false.
- Teléfono:
  - Descripción: recibe el número de teléfono del paciente, su tipo de dato es Nat64.
  - Validaciones: comprueba que la extensión del número telefónico contenga 10 dígitos. Si no se cumple con dicha condición, en consola se mostrará el siguiente mensaje: El teléfono debe ser un número de 10 dígitos y en Cnadid UI se mostrará un false.
- Correo
  - Descripción: deberá recibir el correo electrónico del paciente, su tipo de dato es text.
  - Validaciones: asegura que la extensión del correo electrónico se encuentre entre los 13 y 100 caracteres, además de contener un punto y arroba. En caso de que la condicional no se cumpla se enviará el siguiente mensaje a la consola El formato para el correo debe contener los simbolos '@' y '.' y tener entre 13 y 100 caracteres y en Candid UI se devolverá un false.
## Función getID
Es una función publica de lecuta, misma que devuelve como resultado en Candid UI el número de ID generado para el paciente registrado. Equivaliendo a una consulta en el CRUD.
## Función getPacientes
Trata de una función pública de lectura que trae toda la información de todos los pacientes registrados, los cuales son almacenados en el hashmap. Misma que se realiza haciendo uso de Iter para obtener el contenido del hasmap llamado IDGenerate, su contenido a su vez se almacena en un array, la información contenida en este ultimo es mostrada como resultado de la consulta. Esta forma parte de las consultas del CRUD.
## Función getPaciente
Función pública para obtener un paciente mediante su ID, para ello es necesario introducir dicho parámetro en Candid UI, el cuál será tomado para realizar la busqueda en los datos contenidos en el hashmap. Si no se encuentra ninguna coincidencia con dicho ID, en Candi UI se enviará un null, indicando que el ID no es valido o no se ha encontrado. En caso contrario, en Candid UI se mostrará la información del paciente con dicho ID. Dicha función tambien forma parte de las consultas en el CRUD.
## Función updatePaciente
Trata de una función pública para la actualización de un paciente, dicha función recibe como parámetro el ID del paciente, así como la información de todos los campos que se contemplan en el registro, en ellos, si se desea cambiar algo se expresará en su correspondiente espacio en Candid UI, de caso contrario se expresará de la misma forma en como se realizó el registro. Cabe mencionar que este función es parte de las actualización del CRUD.  
Sus validaciones son las mismas que en el registro. Mientras que para el ID, si este no coincide con ningun paciente devolverá un mensaje en consola, expresando que no se ha encontrado, mientras que en Candid UI, se enviará un false. En caso de encontrar un paciente con el ID indicado, se realizará la actualización al hasmap en el ID correspondiente; devolviendo en consola un mensaje de exito y en Candid UI un true.
## Función deletePaciente
Es una función publica que ayuda con la eliminación del registro de un paciente contenido en el hashmap, formando parte de la eliminación en el CRUD. Para ello, tambien es necesario indicar el ID del paciente que se desea eliminar, si este no coincide con el de ningún paciente se devolverá el siguiente mensaje en la consola: El paciente con el ID: " # id # " no se ha encontrado y en Cnadid UI se devolverá un false. De encontrar coincidencias se eliminará el paciente con dicho ID, luego se enviará el siguiente texo a la consola: "Paciente con ID: " # id # " eliminado correctamente.", mientras que en Camdid UI se mostrará un true.  
  
El CRUD de pacientes anteriormente descrito, como se observa contiene diversas funciones que contribuyen con su buen funcionamiento y agilidad en los procesos de administración de pacientes en servicios y consultorios médicos. 
