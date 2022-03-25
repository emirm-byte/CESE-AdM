# Arquitectura de microprocesadores

Emiliano Eduardo Rodriguez --- CESE16Co.

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

Los shadow stack pointers son útiles en sistemas críticos donde la segurida es muy importante. La separación de stacks (PSP y MSP) puede ayudar en algunos casos al debugging de fallas en el stack y permite que los manejadores de exepciones funcionen normalmente incluso si el stack pointer de la tarea actual es corrupto y apunta a una zona invalida de la memoria.





