-- USO DE FUNCIONES SQL
-- FUNCIONES DE UNA SOLA FILA Y FUNCIONES DE GRUPO
-- FUNCIONES DE UNA SOLA FILA
-- SINTAXIS
-- nombre_funcion ( [argumento_1, argumento_2, argumento_N] )

-- FUNCIONES DE CARACTERES (FUNCIONES DE CONVERSION)
-- LOWER - UPPER - INITCAP
-- OBTENER EL NOMBRE COMPLETO DE LOS EMPLEADOS EN MINUSCULAS,
-- EN MAYUSCULAS Y CAPITALIZADO
SELECT paterno || ' ' || materno || ' ' || nombre nombre_empleado,
       LOWER(paterno || ' ' || materno || ' ' || nombre) minusculas,
       INITCAP(paterno || ' ' || materno || ' ' || nombre) capitalizado,      
       UPPER(INITCAP(paterno || ' ' || materno || ' ' || nombre)) mayusculas
from empleado;

-- CONCAT CONCATENAR O UNIR CADENAS
-- SOLO ACEPTA DOS ARGUMENTOS
-- PREFERIR EL OPERADOR DE CONCATENACION ( || )
SELECT CONCAT(paterno, materno) concat_1,
       CONCAT(paterno, concat(' ', materno)) concat_2, 
       CONCAT(paterno, concat(' ', concat(materno, concat(' ', nombre)))) concat_3
from empleado;

-- FUNCIONES DE MANIPULACION DE CADENAS
-- SUBSTR EXTRAE UNA SUCADENA DE UNA CADENA
--     SUBSTR(cadena_por_evaluar, posicion_inicial, nro_de_caracteres)
-- length DEVUELVE el largo de una cadena 
-- INSTR  DEVUELVE EL ENTERO CON LA POSICION DE UNA CADENA DENTRO DE OTRA
-- REPLACE PERMITE REEMPLAZAR UNA CADENA POR OTRA

SELECT paterno || ' ' || materno || ' ' || nombre nombre_empleado,
       SUBSTR(paterno || ' ' || materno || ' ' || nombre, 1, 5) EXT1,
       SUBSTR(paterno || ' ' || materno || ' ' || nombre, -5) EXT2,
       SUBSTR(paterno || ' ' || materno || ' ' || nombre, -10, 4) EXT3,
       LENGTH(paterno || ' ' || materno || ' ' || nombre) LARGO_NOMBRE
from empleado;

SELECT rutemp, substr(rutemp, 1, length(rutemp) - 1) run_emp,  
       SUBSTR(rutemp, -1) dv_emp,
       SUBSTR(rutemp, 1, length(rutemp) -1) || '-' || SUBSTR(rutemp, -1) completo,
       TO_CHAR(SUBSTR(rutemp, 1, length(rutemp) -1), '99g999g999') 
           || '-' || SUBSTR(rutemp, -1) formeateado
from empleado
ORDER BY rutemp;

-- SE REQUIERE ASIGNAR UNA NUEVA CONTRASEÑA A LOS EMPLEADOS
-- LA CONTRASEÑA DEBE CONSTAR DE LOS TRES PRIMEROS CARACTERES
-- DEL APELLIDO PATERNO, LOS DOS PRIMEROS CARACTERES DE LA FECHA DE 
-- INGRESO, SEGUIDOS DE UN PUNTO, LOS CUATRO ULTIMOS CARACTERES DEL
-- NOMBRE EN MINUSCULAS Y LOS DOS ULTIMOS DIGITOS DEL SUELDO MENOS 2.
-- ELABORE EL INFORME QUE MUESTRE EL NOMBRE COMPLETO
-- DEL EMPLEADO Y SU CONTRASEÑA

SELECT paterno || ' ' || materno || ' ' || nombre nombre_empleado,
       SUBSTR(paterno, 1, 3) || SUBSTR(fecing, 1, 2) 
           || '.' || LOWER(SUBSTR(nombre, -4))
           || ltrim(to_char(SUBSTR(to_char(sueldo),-3)-2,'099')) contrasena
FROM empleado;

-- instr permite localizar una cadena en otra, devuelve la posicion de la cadena buscada
SELECT paterno || ' ' || materno || ' ' || nombre nombre_empleado,
       INSTR(paterno || ' ' || materno || ' ' || nombre, 'E', 1) BUSCA_E,
       INSTR(paterno || ' ' || materno || ' ' || nombre, 'E',INSTR(paterno || ' ' || materno || ' ' || nombre, 'E') + 1) "ENCONTRAR LA SEGUNDA E",       
       REPLACE(paterno || ' ' || materno || ' ' || nombre, ' ', '*') REEMPLAZO,
       direccion,
       replace(direccion, 'D/', 'DEPTO. ') direccion_2             
FROM empleado;

-- LTRIM - RTRIM - TRIM permite quitar los espacios de una cadena 
SELECT '     ALVAREZ MADARIAGA CARLOTA   '
FROM DUAL;

--  LPAD -- RPAD PERMITEN RELLENAR UNA CAMPO|EXPRESION CON EL CARACTER QUE SE ESPECIFIQUE
--  FUNCION(CADENA_POR_RELLENAR, NRO_CARACTERES_A_COMPLETAR, CARACTER_DE_RELLENO)
SELECT PATERNO,
       LPAD(paterno, 10, '*') relleno_izq,   
       RPAD(paterno, 10, '*') relleno_der,
       LPAD(sueldo, 10, 0) relleno_izq,   
       RPAD(sueldo, 10, 0) relleno_der,
       RPAD(sueldo, 10, 0) + 5000 suma_5000       
FROM EMPLEADO;

-- FUNCIONES NUMERICAS
-- TRUNC CORTAR UN NUMERO EN LA POSICION ESPECIFICADA
-- ROUND REDONDEAR UN NUMERO EN LA POSICION ESPECIFICADA
-- MOD DEVUELVE EL RESTO DE LA DIVISION
-- ROUND(numero, [cant_decimales]) 
-- TRUNC(numero, [cant_decimales])

SELECT 8798455.78 CIFRA_ORIGINAL
FROM DUAL;

SELECT 8798455.78 CIFRA_ORIGINAL,
       trunc(8798455.78) truncado_sin_d,
       round(8798455.78) redondeado_sin_d,
       trunc(8798455.78,1) truncado_1_dec,
       round(8798455.78,1) redondeado_1_d,
       mod(8798455,2) resto_division
FROM dual;

SELECT 8798455.78 CIFRA_ORIGINAL,
       trunc(8798455,-1) truncado_decena,
       round(8798455,-1) redondeado_decena,
       trunc(8798455,-2) truncado_centena,
       round(8798455,-2) redondeado_centena,
       trunc(8798455,-3) truncado_u_mil,
       round(8798455,-3) redondeado_u_mil
from dual;

-- FUNCIONES DE FECHA
/*
SYSDATE  devuelve la fecha del sistema. No requiere argumentos
MONTHS_BETWEEN devuelve un entero con el numero de meses entre dos fechas
ADD_MONTHS permite agregar o quitar meses a una fecha. Devuelve la fecha respectiva
NEXT_DAY Devuelve la fecha del primer día de la semana que es mayor que la fecha ingresada.
LAST_DAY devuelve el ultimo dia del mes
EXTRACT devuelve un entero con el componente de la fecha extraido
TRUNC/ROUND(FECHA, ['formato']) TRUNCA/REDONDEA UNA FECHA AL ELEMENTO ESPECIFICADO
*/

-- mostrar la fecha del sistema
-- operatoria con fechas
-- EXCEL 01/01/1900 (1) 
-- ORACLE 01/01/4712 A.C (1) 31/12/9999 

SELECT SYSDATE,
       SYSDATE + 30,
       SYSDATE - 30
FROM dual;

-- averiguar la fecha que representa un numero 
-- o el numero que corresponde a una fecha
SELECT TO_CHAR(TO_DATE(1, 'J'), 'DD/MM/YYYY') FROM dual;

-- averiguar cual es el numero que representa una fecha
SELECT TO_CHAR(SYSDATE, 'J') FROM DUAL;


-- MONTHS_BETWEEN
-- months_between(fecha_1, fecha_2) numero de meses entre dos fechas
SELECT MONTHS_BETWEEN(SYSDATE, '30041920'),
       round(MONTHS_BETWEEN(SYSDATE, '30041920') / 12)
FROM DUAL;

-- ADD_MONTHS 
-- ADD_MONTHS(fecha, nro_meses)
-- agregar o quitar meses a una fecha
SELECT SYSDATE,
       add_months(sysdate, 3) mas_3_meses,
       add_months(sysdate, -3) menos_3_meses
FROM DUAL;
    
-- next_day
-- next_day(fecha, dia)
-- dia puede ser el dia en castellano o inglés 
-- según el motor o el dia de la semana
select sysdate,
       next_day(sysdate, 'VIERNES'),  
       next_day(sysdate, 'SÁBADO'),  
       next_day(sysdate, 6)  
from dual;

-- LAST_DAY
-- LAST_DAY(fecha) ULTIMO DIA DEL MES 
SELECT  LAST_DAY('03031980') FROM DUAL;


-- EXTRACT 
SELECT sysdate,
       EXTRACT(YEAR FROM SYSDATE) AÑO,
       EXTRACT(MONTH FROM SYSDATE) MES,
       EXTRACT(DAY FROM SYSDATE) DIA,
       EXTRACT(DAY FROM SYSDATE) || ' del '
         || EXTRACT(MONTH FROM sysdate) || ' de '  
         || EXTRACT(YEAR FROM sysdate) fecha
FROM dual;


-- formato de la fecha por omision en oracle
SELECT SYSDATE FROM DUAL;

-- ALTERAR EL FORMATO DE LA FECHA
ALTER SESSION SET nls_date_format='dd/MON/yyyy';

ALTER SESSION SET nls_date_format='dd/mm/yyyy';


-- date
-- timestamp

-- EXTRAER LOS COMPONENTES DE LA FECHA (HORA - MINUTO - SEGUNDO)
SELECT sysdate,
       EXTRACT(YEAR FROM SYSDATE) AÑO,   
       EXTRACT(month FROM SYSDATE) MES,   
       EXTRACT(day FROM SYSDATE) DIA,
       EXTRACT(HOUR FROM CAST(SYSDATE AS TIMESTAMP)) HORA, 
       EXTRACT(MINUTE FROM CAST(SYSDATE AS TIMESTAMP)) MINUTOS, 
       EXTRACT(SECOND FROM CAST(SYSDATE AS TIMESTAMP)) SEGUNDOS
FROM DUAL;


--- OPERATORIA CON HORAS
-- operatoria con horas
-- agregar 3 horas a la hora actual
-- la hora es la porcion de un dia de 24 horas en el sistema
-- entero,decimal

SELECT SYSDATE,
       SYSDATE + 3/24 "+ 3 HORAS",
       SYSDATE + 20/24/60,
       sysdate + 20/1440,
       sysdate + 20/24/60/60,
       sysdate + 20/86400
FROM DUAL;

         
-- TRUNC/ROUND
select sysdate,
       Trunc(sysdate),
       Trunc(sysdate, 'month'),
       round(sysdate, 'month'),
       Trunc(sysdate, 'year'),
       round(sysdate, 'year')
from dual;

-- funciones de conversion, funciones de tratamiento de nulos
-- expresiones condicionales
-- CONVERSIONES EN ORACLE
-- conversion implicita
SELECT 400000 + SUBSTR('400A', 1, 3) "CONVERSION IMPLICITA"
FROM DUAL;

SELECT *
from visita
where fecha >= '15052020';

-- conversion explicita
-- TO_CHAR
-- TO_DATE
-- TO_NUMBER

SELECT *
from visita
where fecha >= '05152020';

SELECT *
from visita
where fecha >= TO_DATE('05152020', 'MMDDYYYY');

-- TO_CHAR convierte numeros y fechas a cadenas de texto


-- USO DE TO_CHAR CON HORAS
SELECT sysdate,
       TO_CHAR(SYSDATE, 'HH24:MI:SS') HORA_FMTO24,
       TO_CHAR(SYSDATE, 'HH:MI:SS') HORA_FMTO12,
       TO_CHAR(SYSDATE, 'HH') HORA,
       TO_CHAR(SYSDATE, 'MI') minutos,
       TO_CHAR(SYSDATE, 'SS') segundos       
from dual;

-- USO DE TO_CHAR CON NUMEROS
SELECT 8393934943.78,
       TO_CHAR(8393934943.78),
       TO_CHAR(8393934943.48, '9G999g999g999') SEPARACION_MILES,
       TO_CHAR(8393934943.78, '9,999,999,999') SEPARACION_MILES,
       TO_CHAR(8393934943.78, '9g999g999g999d9999') SEPARACION_MILES_Y_DECIMALES,     
       TO_CHAR(8393934943.78, '$9g999g999g999d99999') formato_monetario     
FROM dual;

-- FUNCIONES PARA EL TRATAMIENTO DE NULOS
-- NVL permite reemplazar un valor nulo por un valor del mismo tipo de datos que 
-- acepta la columna o campo
-- NVL2 es una especie de if - else
-- nullif devuelve nulo si dos expresiones son identicas, si no lo son devuelve la
-- primera expresion
-- COALESCE devuelve la primera expresion no nula de una lista
SELECT rutemp "RUN EMPLEADO",
       paterno || ' ' || materno ||  ' ' || nombre "NOMBRE EMPLEADO",
       sueldo,
       numoficina ofici,
       NVL(numoficina, 0) oficina,
       NVL(TO_CHAR(numoficina), 'SIN OFICINA ASIGNADA') OFICINA2
FROM empleado
where numoficina is null or numoficina > 140;

-- mostrar rut. nombre completo
-- y rut del supervisor de cada empleado
-- si el empleado no tiene supervisor mostrar el texto
-- NO POSEE JEFE
SELECT RUTEMP run,
       paterno||' '||materno||' '||nombre nombre_empleado,
       NVL(rutsup, 'NO POSEE JEFE') SUPERVISOR
from empleado;       


-- USO DE NVL2
SELECT numpropiedad,
       superficie,
       renta,
       gastocomun,
       renta + gastocomun total_pago,
       renta + NVL(gastocomun, 0) total_NVL,
       NVL2(gastocomun, renta + gastocomun, renta) TOTAL_NVL2
from propiedad;

-- USO DE NULLIF
SELECT paterno, materno,
       NULLIF(paterno, materno) uso_nullif
from cliente
where paterno = materno;       

-- USO DE COALESCE
SELECT dormitorios, banos, gastocomun,
       COALESCE( dormitorios, banos, gastocomun) uso_coalesce
FROM PROPIEDAD;

-- EXPRESIONES CONDICIONALES
-- SINTAXIS DE LA INSTRUCCION CASE
/*
CASE expresion_evaluada
     WHEN valor_1 THEN expresion_resultado_1
     WHEN valor_2 THEN expresion_resultado_2
     WHEN valor_3 THEN expresion_resultado_3
     WHEN valor_4 THEN expresion_resultado_4
     ELSE expresion_resultado_5
END

CASE 
     WHEN expresion_evaluada_1 THEN expresion_resultado_1
     WHEN expresion_evaluada_2 THEN expresion_resultado_2
     WHEN expresion_evaluada_3 THEN expresion_resultado_3
     WHEN expresion_evaluada_4 THEN expresion_resultado_4
     ELSE expresion_resultado_5
END
*/

-- la empresa, dada la situación actual, desea otorgar un bono covid a sus empleados,
-- el bono dependerá de la oficina en la cual trabaje el empleado. Si el empleado
-- se desempeña en la oficina 100, 20% de bono respecto del sueldo; si trabaja en la
-- 110, 30% del sueldo, si trabaja en la 120, 50% del sueldo, no hay bono para los 
-- demas

-- la empresa, dada la situación actual, desea otorgar un bono covid a sus empleados,
-- el bono dependerá del sueldo del empleado. Si el sueldo es mayor a 2000000
-- 20% de bono respecto del sueldo; si sueldo esta entre 1500001 y 2000000
-- entonces 30% del sueldo, si el sueldo oscila entre 1000000 y 1500000, entonces 
-- 50% del sueldo, 80% del sueldo en todos los demas casos

-- expresion condicional DECODE

