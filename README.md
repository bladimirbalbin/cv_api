# README

CV REST API
Una API RESTful robusta y escalable diseñada para demostrar mejores prácticas de desarrollo backend, enfocada en seguridad, estabilidad y despliegue continuo.

Características (Puntos Clave)
*   Seguridad: Autenticación JWT (JSON Web Token) y encriptación de contraseñas con Bcrypt.
*   Escalabilidad: Arquitectura en modo API (Rails API Mode) y base de datos PostgreSQL.
*   Estabilidad: Integración Continua (CI) con GitHub Actions y validación de código con RuboCop.
*   Documentación: Documentación interactiva automática generada con Swagger UI.

Stack Tecnológico
*   Ruby 3.3.7 & Rails 8.1.2
*   PostgreSQL (Base de datos)
*   RSpec (Testing & Documentación)
*   Rswag (Documentación Swagger)
*   RuboCop (Linter de código)
*   Render (Hosting en producción)

Despliegue en Producción
La API está desplegada y disponible en: https://cv-api-xpe1.onrender.com/api-docs

Guía de Uso Rápida (Local)
1. Instalación:
git clone https://github.com/bladimirbalbin/cv_api.gitcd cv_apibundle installrails db:create db:migraterails s
2. Acceder a Documentación:Abre http://localhost:3000/api-docs
3. Flujo de Prueba:
    1. Usa POST /auth/register para crear un usuario.
    2. Usa POST /auth/login para obtener el Token JWT.
    3. Clic en el botón Authorize (🔒) arriba a la derecha y pega el Token.
    4. Usa GET /users/profile para ver tus datos protegidos.
Estructura del Proyecto
*   app/services/: Lógica de negocio reutilizable (JWT).
*   app/controllers/concerns/authenticable.rb: Middleware de autorización personalizado.
*   spec/requests/: Pruebas de integración y definición de documentación OpenAPI.