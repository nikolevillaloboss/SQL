# SQL Audit
En la carpeta demo está el código documentado


Para la creación de una auditoría en SQL se hace uso de la base de datos Biblioteca u otra base que contenga las tablas correspondientes

Primer paso: Creación de las tablas Auditoria y Autores del archivo CrearTablas en SQL

Debido a que configurar triggers de manera manual es ineficaz a gran escala se utiliza un procedimiento almacenado encargado de generar automáticamente el script para los triggers 

Segundo paso: Abrir la carpeta de programación o programability en SQL Server, abrir un nuevo query en stored procedure o procedimiento almacenado, Crear el procedimiento almacenado mediante el script de sp

Tercer paso: Ejecutar procedimiento, obtener script

Cuarto paso: Copiar y pegar el script en los triggers de la tabla autores

Quinto paso: Insertar datos y hacer selects para probar el funcionamiento de registros tipo insert

Sexto paso: Hacer los demás triggers para los otros tipos de modificaciones en la tabla autores mediante la creación de los demás procedimientos almacenados.
