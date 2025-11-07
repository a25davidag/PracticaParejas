--------------------------------------------------------------------------------------------
--	CREACION Y USO DE LA BASE DE DATOS 'RestauranteTEIS'
--------------------------------------------------------------------------------------------
-- Nos conectamos como Administradores

-- Creamos al usuario c##RestauranteTEIS y le concedemos los permisos

-- Nos conectamos con el nombre del nuevo usuario

-- Conexión como Administradores abc123.
--CONN sys as sysdba;

-- Creación  del usuario
--DROP USER   c##RestauranteTeis;
--CREATE USER c##RestauranteTeis  IDENTIFIED BY abc   DEFAULT TABLESPACE USERS;

-- Concesión de los privilegios necesarios
--GRANT CONNECT, RESOURCE, DBA TO c##RestauranteTeis;

 --Conexón con el usuario recién creado
--CONN c##RestauranteTeis/abc;
show user;

--------------------------------------------------------------------------------------------
--	ELIMINACIÓN DE LAS TABLAS POR SI EXISTIESEN Y PUDIESEN GENERAR ERRORES
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
--	CREACIÓN DE LA TABLA Restaurante
--
--      id_restaurante          valor numérico de 4 dígitos
--      nombre        		cadena de texto de  50 caracteres, no nulo
--      direccion             	cadena de texto de 100 caracteres, no nula
--      telefono       		cadena de texto de  15 caracteres
--
--      Clave primaria          id_restaurante
--------------------------------------------------------------------------------------------
DROP TABLE Restaurante CASCADE CONSTRAINTS PURGE;
CREATE TABLE Restaurante(

     id_restaurante         NUMERIC(4),
     nombre        		    VARCHAR2(50),
     direccion             	VARCHAR2(100),
     telefono       		VARCHAR2(15)
);
--------------------------------------------------------------------------------------------
--	CREACIÓN DE LA TABLA Cliente
--
--      id_cliente          	valor numérico de 4 dígitos
--      nombre        		cadena de texto de  50 caracteres, no nulo
--      email             	cadena de texto de  50 caracteres, no nula
--      telefono       		cadena de texto de  15 caracteres
--
--      Clave primaria          id_cliente
--------------------------------------------------------------------------------------------
DROP TABLE Cliente CASCADE CONSTRAINTS PURGE;
CREATE TABLE Cliente(
    
    id_cliente          NUMERIC(4),
    nombre        		VARCHAR2(50),
    email             	VARCHAR2(50),
    telefono       		VARCHAR2(15)
);

--------------------------------------------------------------------------------------------
--	CREACIÓN DE LA TABLA Mesa
--
--      id_mesa          	valor numérico de 4 dígitos
--      capacidad      		valor numérico de 2 dígitos
--      ubicacion             	cadena de texto de  50 caracteres
--
--      Clave primaria          id_mesa
--------------------------------------------------------------------------------------------
DROP TABLE Mesa CASCADE CONSTRAINTS PURGE;
CREATE TABLE Mesa(
    
      id_mesa          	 NUMERIC(4),
      capacidad          NUMERIC(2),
      ubicacion          VARCHAR2(50)
);

--------------------------------------------------------------------------------------------
--	CREACIÓN DE LA TABLA Pedido
--
--      id_pedido          	valor numérico de 6 dígitos
--      id_cliente      	valor numérico de 4 dígitos
--      fecha_pedido           	fecha
--      estado 			cadena de texto de  20 caracteres
--
--      Clave primaria          id_pedido
--	Clave foranea		id_cliente	a Cliente( id_cliente )
--------------------------------------------------------------------------------------------
DROP TABLE Pedido CASCADE CONSTRAINTS PURGE;
CREATE TABLE Pedido(
    
     id_pedido          NUMERIC(6),
     id_cliente      	NUMERIC(4),
     fecha_pedido       DATE,
     estado 			VARCHAR(20)
);

--------------------------------------------------------------------------------------------
--	CREACIÓN DE LA TABLA DetallePedido
--
--      id_detalle          	valor numérico de 8 dígitos
--      id_pedido      		valor numérico de 6 dígitos
--      id_plato             	valor numérico de 2 dígitos
--      cantidad       		valor numérico de 3 dígitos
--
--      Clave primaria          id_detalle
--	Clave foránea		id_pedido	a Pedido( id_pedido )
--------------------------------------------------------------------------------------------
DROP TABLE DetallePedido CASCADE CONSTRAINTS PURGE;
CREATE TABLE DetallePedido(
     id_detalle          	NUMERIC(8),
     id_pedido      		NUMERIC(6),
     id_plato             	NUMERIC(2),
     cantidad       		NUMERIC(3)

);

--------------------------------------------------------------------------------------------
--	CREACIÓN DE LA TABLA Plato
--
--      id_plato          	valor numérico de 2 dígitos
--      nombre      		cadena de texto de  50 caracteres
--      tipo             	cadena de texto de  30 caracteres
--      cantidad       		valor numérico de 6 dígitos, siendo 2 la parte decimal
--
--      Clave primaria          id_plato
--------------------------------------------------------------------------------------------
DROP TABLE Plato CASCADE CONSTRAINTS PURGE;
CREATE TABLE Plato(
    
    id_plato    NUMERIC(2),
    nombre      VARCHAR2(50),
    tipo        VARCHAR2(30),
    cantidad    NUMERIC(6,2)
);

--------------------------------------------------------------------------------------------
--	CREACIÓN DE LA TABLA Reserva
--
--      id_reserva          	valor numérico de 7 dígitos
--      id_cliente      	valor numérico de 4 dígitos
--      fecha_reerva            fecha
--      cantidad_personas	valor numérico de 3 dígitos
--	mesa_preferida		valor numérico de 3 dígitos
--	observaciones		cadena de texto de 200 caracteres
--
--      Clave primaria          id_reserva
--	Clave foránea		id_pedido	a Pedido( id_pedido )
--------------------------------------------------------------------------------------------
DROP TABLE Reserva CASCADE CONSTRAINTS PURGE;
CREATE TABLE Reserva(
    
    id_reserva          NUMERIC(7),
    id_cliente          NUMERIC(4),
    fecha_reserva       DATE,
    cantidad_personas   NUMERIC(3),
    mesa_preferida      NUMERIC(3),
    observaciones       VARCHAR2(200)
);

--------------------------------------------------------------------------------------------
-- 1. Creación de las claves primarias
--------------------------------------------------------------------------------------------

ALTER TABLE Restaurante     ADD CONSTRAINT      PK_Restaurante  PRIMARY KEY (id_restaurante);
ALTER TABLE Cliente         ADD CONSTRAINT      PK_Cliente      PRIMARY KEY (id_cliente);
ALTER TABLE Mesa            ADD CONSTRAINT      PK_Mesa         PRIMARY KEY (id_mesa);
ALTER TABLE Pedido          ADD CONSTRAINT      PK_Pedido       PRIMARY KEY (id_pedido);
ALTER TABLE DetallePedido   ADD CONSTRAINT      PK_DetallePedido PRIMARY KEY (id_detalle);
ALTER TABLE Plato           ADD CONSTRAINT      PK_Plato        PRIMARY KEY (id_plato);
ALTER TABLE Reserva         ADD CONSTRAINT      PK_Reserva      PRIMARY KEY (id_reserva);


--------------------------------------------------------------------------------------------
-- 2. Creación de las claves foráneas
--------------------------------------------------------------------------------------------
ALTER TABLE Pedido          ADD CONSTRAINT fk_pedido_Cliente        FOREIGN KEY (idCliente)     REFERENCES Cliente(idCliente); 
ALTER TABLE DetallePedido   ADD CONSTRAINT fk_id_pedido_Pedido      FOREIGN KEY (id_pedido)     REFERENCES Pedido(id_pedido); 
ALTER TABLE DetallePedido   ADD CONSTRAINT fk_id_pedido_Plato       FOREIGN KEY (id_plato)      REFERENCES Plato(idPlato); 
ALTER TABLE Reserva         ADD CONSTRAINT fk_reserva_Cliente       FOREIGN KEY (id_cliente)    REFERENCES Cliente(id_cliente); 
ALTER TABLE Mesa            ADD CONSTRAINT fk_mesa_Restaurante      FOREIGN KEY (idmesa)        REFERENCES Restaurante(idRestaurante);
ALTER TABLE Cliente         ADD CONSTRAINT fk_cliente_idclientereferencia   FOREIGN KEY (idclientereferencia)   REFERENCES Cliente (idCliente);
ALTER TABLE Reserva         ADD CONSTRAINT fk_mepreferida_idmesa    FOREIGN KEY (mesa_preferida)    REFERENCES Mesa (idMesa);


--------------------------------------------------------------------------------------------
-- 3. Creación de las claves de valores únicos
--------------------------------------------------------------------------------------------
ALTER TABLE Restaurante
    MODIFY(direccion UNIQUE)
    MODIFY(telefono UNIQUE);

ALTER TABLE Cliente
    MODIFY (email UNIQUE)
    MODIFY (telefono UNIQUE);
--------------------------------------------------------------------------------------------
-- 4. Creación de restricciones de valores no nulos
--------------------------------------------------------------------------------------------
ALTER TABLE Restaurante
    MODIFY nombre NOT NULL
    MODIFY direccion NOT NULL;

ALTER TABLE Cliente
    MODIFY nombre NOT NULL
    MODIFY email NOT NULL;


--------------------------------------------------------------------------------------------
-- 5. Creación de restricicones de valores por defecto
--------------------------------------------------------------------------------------------
ALTER TABLE Restaurante
MODIFY nombre DEFAULT 'Asador Ramiro';

ALTER TABLE Cliente
MODIFY nombre DEFAULT 'Pancracio Gómez'
MODIFY email DEFAULT 'ejemplo@email.com';



--------------------------------------------------------------------------------------------
-- 6. Creación de restricciones de comparación 
--------------------------------------------------------------------------------------------
ALTER TABLE Restaurante
ADD CONSTRAINT CHK_nombre   CHECK (nombre is NOT NULL)
ADD CONSTRAINT CHK_direccion CHECK (direccion is NOT NULL);

ALTER TABLE Cliente
ADD CONSTRAINT CHK_nombre CHECK(nombre is NOT NULL)
ADD CONSTRAINT CHK_email CHECK(email is NOT NULL)
ADD CONSTRAINT CHK_telefono CHECK(telefono is NOT NULL);

ALTER TABLE Pedido
ADD CONSTRAINT CHK_fecha_pedido CHECK(fecha_pedido IS NOT NULL)
ADD CONSTRAINT CHK_estado CHECK(estado is NOT NULL);

ALTER TABLE DetallePedido
ADD CONSTRAINT CHK_cantidad CHECK(cantidad IS NOT NULL);

ALTER TABLE Plato
ADD CONSTRAINT CHK_nombre CHECK(nombre is NOT NULL)
ADD CONSTRAINT CHK_tipo CHECK(tipo is NOT NULL)
ADD CONSTRAINT CHK_cantidad CHECK(cantidad is NOT NULL);

ALTER TABLE Reserva
ADD CONSTRAINT CHK_fecha_reserva CHECK(fecha_reserva IS NOT NULL)
ADD CONSTRAINT CHK_cantidad_personas CHECK(cantidad_personas IS NOT NULL);



--------------------------------------------------------------------------------------------
-- 7. Cambio de nombres de las claves primarias (sin '_')
--------------------------------------------------------------------------------------------
ALTER TABLE Restaurante
    RENAME COLUMN idRrestaurante TO idRestaurante;

ALTER TABLE Cliente
    RENAME COLUMN id_cliente TO idCliente;
    
ALTER TABLE Mesa
    RENAME COLUMN id_mesa TO idMesa;
    
ALTER TABLE Pedido
    RENAME COLUMN id_pedido TO idPedido;

    
ALTER TABLE DetallePedido
    RENAME COLUMN id_detalle TO idDetalle;

    
ALTER TABLE Plato
    RENAME COLUMN id_plato TO idPlato;
    
ALTER TABLE Reserva
    RENAME COLUMN idRserva TO idReserva ;

    
--------------------------------------------------------------------------------------------
-- 8. Añadir un campo masInformación a las tablas Mesa y Pedido
--------------------------------------------------------------------------------------------
ALTER TABLE Cliente
    ADD idclientereferencia NUMBER(4);

ALTER TABLE Mesa
 ADD restaurante    NUMERIC (4);
 ADD masInformacion VARCHAR(100);
 
ALTER TABLE Pedido
 ADD masInformacion VARCHAR(100);