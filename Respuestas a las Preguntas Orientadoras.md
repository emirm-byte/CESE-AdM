# Arquitectura de microprocesadores

Emiliano Eduardo Rodriguez --- CESE16Co.

### 1. Describa brevemente los diferentes perfiles de familias de microprocesadores/microcontroladores de ARM. Explique alguna de sus diferencias características.

En la familia de microprocesadores y microcontroladores ARM existen 3 perfiles principales:

* Cortex-A: Este perfil está diseñado para aplicaciones de alto rendimiento y para ejecutar sistemas operativos de proposíto general como Linux, Android, etc. Son microprocesadores pensados para el consumo masivo como su aplicación en telefonos móviles, tablets, etc.
* Cortex-R: Este perfil está diseñado para aplicaciones de tiempo real y aplicaciones de tiempo crítico. Estas aplicaciones pueden ser procesamiento de señales, de audio y video. Aplicaciones donde la velocidad de ejecución y la previsibilidad en el tiempo de ejecución son muy importantes. 
* Cortex-M: Este perfil está diseñado para aplicaciones de microcontroladores, haciendo foco en el bajo costo y en la eficiencia energética. Su objetivo es reemplazar a los microcontroladores de 8 y 16bits.

## Cortex M

### 1. Describa brevemente las diferencias entre las familias de procesadores Cortex M0, M3 y M4.

* ARM Cortex M0: Es uno de los microprocesadores ARM más pequeño que disponen actualmente. Ocupan un muy pequeña área de silicio y están pensados para aplicaciones de muy bajo consumo y poco uso de memoria, teniendo un microprocesador de 32 bits al precio de uno de 8 y 16 bits.