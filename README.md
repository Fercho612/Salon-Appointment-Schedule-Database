# Sistema de Turnos para Peluquería

Programa de línea de comandos en Bash que agenda turnos de una peluquería y los guarda en una base de datos PostgreSQL.

Proyecto de la certificación **Relational Database** de [freeCodeCamp](https://www.freecodecamp.org/).

## Qué hace

1. Muestra la lista de servicios disponibles y valida que el elegido exista.
2. Pide el teléfono: si el cliente es nuevo, le pide el nombre y lo registra.
3. Pide el horario y guarda el turno.
4. Confirma el turno con el servicio, el horario y el nombre del cliente.

## Tecnologías

Bash · PostgreSQL · SQL

## Modelo de datos

| Tabla | Columnas principales |
| --- | --- |
| `customers` | `customer_id`, `phone` (único), `name` |
| `services` | `service_id`, `name` |
| `appointments` | `appointment_id`, `customer_id` → `customers`, `service_id` → `services`, `time` |

## Cómo ejecutarlo

Requisitos: PostgreSQL y una terminal Bash.

```bash
psql -U postgres < salon.sql
chmod +x salon.sh
./salon.sh
```

El script se conecta con el usuario `freecodecamp`; si usás otro, cambiá la variable `PSQL` al comienzo de `salon.sh`.

## Lo que aprendí

- Modelar una relación muchos a muchos (clientes y servicios) con una tabla intermedia.
- Leer datos del usuario en Bash y validarlos contra la base.
- Combinar `SELECT` e `INSERT` desde un script para un flujo completo de alta.
