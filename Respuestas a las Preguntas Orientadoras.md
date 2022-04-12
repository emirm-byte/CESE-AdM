# Arquitectura de microprocesadores

### Emiliano Eduardo Rodriguez --- CESE16Co.

### 1. Describa brevemente los diferentes perfiles de familias de microprocesadores/microcontroladores de ARM. Explique alguna de sus diferencias características.

En la familia de microprocesadores y microcontroladores ARM existen 3 perfiles principales:

* Cortex-A: Este perfil está diseñado para aplicaciones de alto rendimiento y para ejecutar sistemas operativos de proposíto general como Linux, Android, etc. Son microprocesadores pensados para el consumo masivo como su aplicación en telefonos móviles, tablets, etc.
* Cortex-R: Este perfil está diseñado para aplicaciones de tiempo real y aplicaciones de tiempo crítico. Estas aplicaciones pueden ser procesamiento de señales, de audio y video. Aplicaciones donde la velocidad de ejecución y la previsibilidad en el tiempo de ejecución son muy importantes. 
* Cortex-M: Este perfil está diseñado para aplicaciones de microcontroladores, haciendo foco en el bajo costo y en la eficiencia energética. Su objetivo es reemplazar a los microcontroladores de 8 y 16bits.

## Cortex M

### 1. Describa brevemente las diferencias entre las familias de procesadores Cortex M0, M3 y M4.

* ARM Cortex M0: Es uno de los microprocesadores ARM más pequeño disponible actualmente. Ocupan un muy pequeña área de silicio y están pensados para aplicaciones de muy bajo consumo y poco uso de memoria, teniendo un microprocesador de 32 bits al precio de uno de 8 y 16 bits.
* ARM Cortex M3: Es un microprocesador especificamente diseñando para alto rendimiento (Mayor que el M0) en plataformas de bajo costo para una amplia gama de dispositivos tales como microcontroladores, sistmes de control industrial y automotriz y redes de sensores inalambricos.
* ARM Cortex M4: Es un microprocesador diseñado para muy alta eficiencia, incluye instrucciones para procesamiento digital de señales (DSP) y aritmética saturada. Se utiliza en controles de motores, manejo de potencia, audio embebido y automatización industrial.  

### 2. ¿Por qué se dice que el set de instrucciones Thumb permite mayor densidad de código? Explique.

Se dice que Thumb permite mayor densidad de código porque implementa instrucciones de 16 Bits que ocupan menos memoria que las instrucciones de 32 Bits.

### 3. ¿Qué entiende por arquitectura load-store? ¿Qué tipo de instrucciones no posee este tipo de arquitectura?

En la arquitectura load-store, las instrucciones no pueden operar directamente a memoria, es decir para poder operar deben cargar y copiar los datos en registros del microprocesador y luego operar con ellos. Este tipo de arquitectura tiene instrucciones para obtener datos desde la memoria pero no tiene instrucciones para operar directamente con ellos en la memoria.

### 4. ¿Cómo es el mapa de memoria de la familia?

El mapa de memoria de la familia ARM Cortex M4 es un mapa de memoria plano de 4GB.

### 5. ¿Qué ventajas presenta el uso de los “shadowed pointers” del PSP (Process Stack Pointer) y el MSP (Main Stack Pointer)?

Los shadow stack pointers son útiles en sistemas críticos donde la seguridad es muy importante. La separación de stacks (PSP y MSP) puede ayudar en algunos casos al debugging de fallas en el stack y permite que los manejadores de exepciones funcionen normalmente incluso si el stack pointer de la tarea actual es corrupto y apunta a una zona invalida de la memoria.

### 6. Describa los diferentes modos de privilegio y operación del Cortex M, sus relaciones y como se conmuta de uno al otro. Describa un ejemplo en el que se pasa del modo privilegiado a no priviligiado y nuevamente a privilegiado.

Los procesadores Cortex M3/M4 tiene dos niveles de privilegio y dos modos de operación:

* Los modos de operación Thread y Handler determinan si el procesador ejecuta un programa normal o un manejador de excepciones tal como un manejador de interrupción o de excepciones del sistema.
* Los niveles de privilegio Privileged y User proporcionan un mecanismo para protejer los accesos a regiones críticas de memoria brindando un modelo de seguridad básico.

Cuando el procesador ejecuta el programa principal (modo Thread), puede hacerlo en estado privilegiado o usuario, pero los manejadores de excepciones sólo pueden hacerlo en estado privilegiado.
Para pasar de privilegiado a no privilegiado se modifica por software el Control Register.
No es posible regresar al modo privilegiado por software. Es el Handler de una interrupción quién puede regresar al modo privilegiado.
Un ejemplo de pasar desde modo privilegiado a no privilegiado y de regreso es el usado por las llamadas al sistema de un Sistema Operativo.

### 7. ¿Qué se entiende por modelo de registros ortogonal? Dé un ejemplo

Se dice que un modelo de registros es ortogonal cuando las instrucciones pueden usar cualquier registro con cualquier modo de direccionamiento. La búsqueda de la ortogonalidad hace que el diseño de la unidad central de procesamiento sea más complejo pero aporta una mayor facilidad de programación.


### 8. ¿Qué ventajas presenta el uso de intrucciones de ejecución condicional (IT)? Dé un ejemplo

Los procesadores Cortex M3/M4 soportan ramificación condicional como así también ejecución condicional de instrucciones colocando las instrucciones condicionales en un bloque de instrucción IF-THEN (IT). 
En muchos casos las instrucciones IT pueden ayudar a mejorar la performance de un programa porque se evita cierta penalidad de saltos como también se reducen el número de intrucciones de salto. Por ejemplo una corta secuencia de programa IF-THEN-ELSE que normalmente requiere un salto condicional y un salto incondicional puede ser reemplazado por una única instrucción IT.

### 9. Describa brevemente las excepciones más prioritarias (reset, NMI, Hardfault).

* Reset: En los Cortex-M existen 3 tipos de reset, Power on reset(resetea todo el microcontrolador), System reset(resetea procesador y perifericos pero no el componenente de debug), Processor reset(solo resetea el procesador). Prioridad -3 la más alta.
* NMI(Non-Maskable interrupt): Es una excepción o interrupción de hardware que las técnicas estándar de enmascaramiento de interrupciones en el sistema no pueden ignorar. las NMI pueden ser usadas para el Watchdog timer or el brownout detector(voltage monitor). Prioridad -2.
* Hardfault: De forma predeterminada, el error de bus, el error de uso y el error de administración de memoria están deshabilitados y todos los eventos de falla activan la excepción HardFault. Prioridad -1.

### 10. Describa las funciones principales de la pila. ¿Cómo resuelve la arquitectura el llamado a funciones y su retorno?

Una pila o stack es una lista ordenada o estructura de datos que permite almacenar y recuperar datos, siendo el modo de acceso a sus elementos de tipo LIFO (Last In First Out). 
El stack pueder ser usado para:
* Almacenamiento temporal de datos cuando se llama a una función, esto es para recuperar el hilo de la ejecución del programa.
* Paso de información a funciones o subrutinas.
* Para almacenar variables locales.
* Para mantener el estado del procesador y valores de registro en caso de excepciones (interrupciones).
En el llamado a funciones, el llamado se realiza colocando el valor de los registro y la dirección de retorno en el stack y luego al retornar de la función, se sacan los valores del stack y se colancan nuevamente en los registros.

### 11. Describa la secuencia de reset del microprocesador.

Después de producido el Reset y antes de que el procesador inicie la ejecución del programa, el Cortex-M lee las dos primeras palabras de la memoria. El inicio del espacio de memoria contiene la tabla de vectores
y las primeras palabras de la tabla de vectores son los valores inciales del Main Stack Pointer(MSP) y el vector de reset que es la dirección de inicio del manejador de reset. Luego de que estas dos palabraas son 
leidas por el procesador setea el MPS y el Program Counter (PC) con estos valores. Luego de que se obtiene el vector de reset, el Cortex-M puede entonces empezar con la ejecución del programa desde la dirección del vector de reset y iniciar las operaciones normales.  

### 12. ¿Qué entiende por “core peripherals”? ¿Qué diferencia existe entre estos y el resto de los periféricos?

Se entiende por core peripherals a aquellos periféricos relacionados con el nucleo del procesador, es decir aquellos periféricos diseñados por ARM y que definien la arquitectura del procesador a diferencia del resto de los periféricos que están definidos por cada dispositivo en particular. 

### 13. ¿Cómo se implementan las prioridades de las interrupciones? Dé un ejemplo.

Si un periferico en particular se usa con operaciones de interrupción es necesario programar el controlador de interrupciones en los Cortex M3/M4 (NVIC) para habilitar la interrupción y configurar el nivel de prioridad de la interrupción. Por ejemplo las interrupciones IRQ tienen un nivel de prioridad configurable 0–239.

### 14. ¿Qué es el CMSIS? ¿Qué función cumple? ¿Quién lo provee? ¿Qué ventajas aporta?

CMSIS (Cortex microcontroller software interface stardard) es una capa de abstracción de software que provee ARM y que permite a los proveedores de microcontroladores y software tener una infraestructura consistente para desarrollar soluciones para los microcontroladores Cortex M.

### 15. Cuando ocurre una interrupción, asumiendo que está habilitada ¿Cómo opera el microprocesador para atender a la subrutina correspondiente? Explique con un ejemplo.

Cuando el hardware o un periférico necesita ser atendido por el procesador, la secuencia que ocurre es:

* El periférico hace una solicitud de interrupción al procesador a través del NVIC (por ejemplo una GPIO interrupt) 
* El procesador suspende la tarea que se está ejecutando actualmente y almacena el contexto en el stack. (En baremetal se suspendería la ejecución del programa principal dentro del main).
* El procesador ejecuta una rutina de servicio de interrupción (ISR) para dar servicio al periférico y, opcionalmente, borra la solicitud de interrupción por software si es necesario. (Ejecuta la tarea asignada a la interrupción de es GPIO particular).
* El procesador reanuda la tarea suspendida previamente restableciendo el contexto almacenado en el stack. (El procesador regresa al programa y al bucle principal).

### 16. ¿Cómo cambia la operación de stacking al utilizar la unidad de punto flotante?

Al utilizar la unidad de punto flotante (FPU) en los Cortex hay registros en el banco de registros de la FPU que tienen datos que pueden ser necesarios de almacenar. Si necesitamos almacenar en el stack los registros de la FPU se incrementará la latencia de 12 a 29 ciclos.
Para reducir la latencia los Cortex tiene lo que se llama Lazy Stacking.....continuar

### 17. Explique las características avanzadas de atención a interrupciones: tail chaining y late arrival. 
* Tail chaining: Cuando se produce una interrupción pero el procesador está manejando otra interrupción de la misma o mayor prioridad, la interrupción entrará en estado de espera. Cuando el procesador termine 
la ejecución de la interrupción actual, el procesador puede comenzar a atender la interrupción pendiente. En vez de recuperar los registros desde el stack (unstacking) y ponerlos de nuevo en el stack (stacking),
el procesador salta los pasos de unstacking y stacking y entra en la ejecución de la interrupción pendiendte los antes posible. De esta forma se reduce considerablemente el tiempo entre ejecuciones de interrupciones.  

* Late arrival: cuando una interrupción toma lugar, el procesador acepta el pedido de atención de la interrupción y comienza el proceso de stacking. Si durante la operación de stacking otra interrupción de mayor
prioridad toma lugar, la interrupción de prioridad más alta que llega más tarde (late arrival) será atendida primero.

### 18. ¿Qué es el systick? ¿Por qué puede afirmarse que su implementación favorece la portabilidad de los sistemas operativos embebidos?

Los procesadores Cortex-M tienen un pequeño timer integrado llamado Systick (System Tick) Timer. Es integrado como parte del NVIC y puede generar una interrupciones. El SysTick timer es un timer decremental de 24 bit
y puede funcionar la frecuencia de clock del procesador o desde una frecuencia de clock de referencia. En sistemas operativos modernos una interrupción periódica es necesaria para asegurar la invocación del kernel de forma regular,
por ejemplo para el manejo de tareas y el cambio de contexto.
La razón para tener un timer dentro del procesador es para ayudar a la portabilidad de software. Desde que todos los procesadores Cortex-M tienen el mismo Systick timer, la escritura de un OS puede ser reutilizable en otros
procesadores Cortex-M3/M4.

### 19. ¿Qué funciones cumple la unidad de protección de memoria (MPU)?

La MPU (unidad de protección de memoria) es un dispositivo programable que puede ser usado para definir permisos de acceso a memoria (acceso privilegiado o acceso completo) y atributos de memoria (cacheable, buffer, etc)
para diferentes regiones de memoria. La MPU puede hacer de una sistema embebido más robusto y en algunos casos puede hacer del sistema más seguro a través de:

* Evitando que las tareas de la aplicación modifiquen la pila o la memoria de datos utilizada por otras tareas y el kernel del sistema operativo.
* Evitando que las tareas sin privilegios accedan a ciertos periféricos que pueden ser críticos para la confiabilidad o seguridad del sistema.
* Definiendo SRAM o espacio RAM como no ejecutable (eXecute Never, XN) para prevenir ataques de inyección de código.

### 20. ¿Cuántas regiones pueden configurarse como máximo? ¿Qué ocurre en caso de haber solapamientos de las regiones? ¿Qué ocurre con las zonas de memoria no cubiertas por las regiones definidas?

La MPU del Cortex-M3/M4 puede soportar hasta 8 regiones programables de memoria, cada una con su propia dirección de inicio, tamaño y configuración.
Si un acceso a la memoria viola los permisos de acceso definidos por la MPU o accede a una ubicación de memoria que no está definida en las regiones programadas de la MPU, la transferencia se bloquearía y se dispararía una excepción de falla. El manejador de excepciones de fallas podría ser la falla MemManage o la excepción HardFault. 

### 21. ¿Para qué se suele utilizar la excepción PendSV? ¿Cómo se relaciona su uso con el resto de las excepciones? Dé un ejemplo.

PendSV (Pended Service Call) es otro tipo excepción que es importante para el soporte de Sistemas Operativos. Tiene un nivel de prioridad programable. 
La excepción PendSV es disparada seteando su estado pendiente escribiendo el registro ICSR (Interrupt Control and State Register).
A diferencia de la excepción SVC no es precisa. Por lo tanto su estado pendiente puede ser seteado dentro de un manejador(handler) de excepción de más alta prioridad y ejecutado cuando el manejador de más alta prioridad finalice.
Utilizando esta característica, podemos programar el controlador de excepciones PendSV para que sea ejecutado después de que se hayan realizado todas las demás tareas de procesamiento de interrupciones, asegurándose de que
el PendSV tiene el nivel de prioridad de excepción más bajo. Esto es muy útil para la operación de cambio de contexto, que es una operación clave en varios diseños de sistemas operativos. Esto evita que suceda el cambio de contexto en medio de la ejecución de un controlador de interrupciones.

### 22. ¿Para qué se suele utilizar la excepción SVC? Expliquelo dentro de un marco de un sistema operativo embebido.

El SVC (Supervisor Call) es importante en diseño de Sistemas Operativos.
La excepción SVC es disparada por la instrucción SVC. Aunque es posible disparar la interrupción usando software escribiendo en el NVIC (Software Trigger Interrupt Register, NVIC->STIR),
el comportamiento es un poco diferente: las interrupciones son imprecisas. Esto significa que un número de  instrucciones puede ser ejecutado despues de setear el estado pendiente pero antes de que la interrupción actual tome lugar. 
Por otro lado, SVC es preciso. El controlador SVC debe ejecutarse después de la instrucción SVC, excepto cuando llega otra excepción de mayor prioridad al mismo tiempo. 
En muchos sistemas, el mecanismo SVC se puede usar como una API para permitir que las tareas de la aplicación accedan a los recursos del sistema.

## ISA (Intruction Set Architecture).

### 1. ¿Qué son los sufijos y para qué se los utiliza? Dé un ejemplo.

En assembler para los procesadores ARM Cortex, algunas instrucciones pueden estar seguidas por sufijos. Los sufijos amplian la funcionalidad de las instrucciones. 
Una instrucción de procesamiento de datos puede actualizar opcionalmente el APSR (flags). Si usamos la sintaxis del Lenguaje ensamblador unificado (UAL), podemos especificar si se debe realizar la actualización del APSR o no.

Por ejemplo:

* MOVS R0, R1 ; Mover R1 a R0 y actualizar APSR.

* MOV R0, R1 ; Mover R1 a R0 y NO actualizar APSR.

### 2. ¿Para qué se utiliza el sufijo ‘s’? Dé un ejemplo.

El sufijo 's' se utiliza para actualizar el registro APSR(Application Program Status Register), tales como los flags Carry, Overflow, Zero y Negative. 
Por ejemplo: 

* ADDS R0, R1 ; Esta operación de suma actualizará el APSR.

### 3. ¿Qué utilidad tiene la implementación de instrucciones de aritmética saturada? Dé un ejemplo con operaciones con datos de 8 bits.

La aritmetica saturada es util para el procesamiento digital de señales. En algunos casos le registro de destino usado para mantener el resultado de un cálculo podría no tener el ancho de bits suficiente y 
como resultado un overflow o unferflow ocurre. Si son usadas instrucciones aritméticas normales, el MSB(Bit más significativo) del resultado podría perderse y provocar serias distorisiones en la salida.
En vez de descartar el MSB, la aritmética saturada fuerza el resultado al máximo valor posible (en caso de overflow) o al mínimo (en caso de underflow) para reducir el impacto de la distorisión en la señal.
Por ejemplo si tenemos un registro de 8bits y tenemos almacenado el número 11111111 si se procede a sumar con instrucciones normales 00000001, el resutado sería:

* 11111111  \+  00000001  =  1 00000000
Como se observa del resultado se debería descartar el MSB y el número quedaría en 0 produciendo una gran distorsión en la señal. Si utlizamos aritmética saturada, el resultado de esa suma sería:

* 11111111  \+  00000001  =  11111111  --> Satura y queda el valor máximo posible almacedado en el registro.
 
### 4. Describa brevemente la interfaz entre assembler y C ¿Cómo se reciben los argumentos de las funciones? ¿Cómo se devuelve el resultado? ¿Qué registros deben guardarse en la pila antes de ser modificados?

#### Interfaz C y Assembler:
* Primero se definen los prototipos de las funciones en un archivo .h como puede ser asm_func.h.
* Luego en un archivo como asm_func.S se declaran las mismas funciones que en el .h pero con el simbolo .globlal adelante.
* Si la función va a tener retorno, este retorna por el registro r0.
* En los registros r0 r1 r2 r3 se pasan los argumentos definidos por la función. Si la función requiere más de 4 parámetros, deben pasarse al stack. 
* El resto de los registros r4-r12 deben salvarse en el stack al comienzo de la función en asm (push {r4-rx}) y recuperarse al finalizar la función (pop {r4-r6}). Esto se debe a que esos registro pueden ser usados en otro contexto y al modificarse hacer fallar el programa.

### 5. ¿Qué es una instrucción SIMD? ¿En qué se aplican y que ventajas reporta su uso? Dé un ejemplo.

* Single Instruction, Multiple Data (SIMD). Estas instrucciones le permiten al Cortex-M4 manejar tareas de procesamiento de señales digitales en tiempo real de forma más eficiente. Estas instrucciones permiten multiples operaciones de datos que se ejecutan en paralelo. la mayor aplicación de las intrucciones SIMD es el procesamiento de audio, donde los cálculos del canal izquierdo y derecho pueden realizarse al mismo tiempo.
Tambìen estas instrucciones pueden ser usadas en procesamiento de imágenes, donde los elementos R-G-B o C-M-Y-K de los pixeles de la imagen pueden ser representadas como un set de datos SIMD de 8-bit procesados en paralelo.

