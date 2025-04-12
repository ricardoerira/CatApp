# 🐱 CatAppTest

CatAppTest es una aplicación iOS desarrollada en Swift y SwiftUI que consume información de [TheCatAPI](https://developers.thecatapi.com/). Muestra una lista de razas de gatos, permite buscarlas y ver detalles de cada una.

---

## ✅ Requisitos de la prueba técnica

1. **Consumir la API**:  
   - URL: `https://api.thecatapi.com/v1/breeds`  
   - Autenticación: se requiere `x-api-key` o el parámetro `api_key`  
   - API Key utilizada:  
     ```
     live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr
     ```

2. **Mostrar la información de la siguiente manera**:
   - Lista de razas con:
     - Nombre
     - Imagen
     - País de origen (🇺🇸)
     - Nivel de inteligencia
   - Campo de búsqueda por nombre
   - Pantalla de detalle con:
     - Descripción
     - País y origen
     - Nivel de inteligencia
     - Nivel de adaptabilidad

---

## 🚀 Cómo ejecutar el proyecto

1. Clona este repositorio:
   ```bash
   git clone https://github.com/tu_usuario/CatAppTest.git
   2. **Descarga las dependencias con SPM**:

## 📦 Dependencias

| Framework         | Uso principal                                                          |
|-------------------|------------------------------------------------------------------------|
| **SwiftUI**        | Construcción de la interfaz de usuario declarativa                    |
| **Combine**        | Programación reactiva para validación de formularios y manejo de estado |
| **Core Data**      | Persistencia local                                                    |
| *Lottie*|  Animaciones   |
---

## 🧱 Arquitectura y Principios

El proyecto fue construido siguiendo buenas prácticas de desarrollo y patrones de arquitectura modernos para mejorar la escalabilidad, testabilidad y mantenibilidad.

### 🧩 MVVM (Model-View-ViewModel)
Se utilizó el patrón MVVM para separar de forma clara la interfaz de usuario (View), la lógica de presentación (ViewModel) y los datos (Model), permitiendo una mejor organización y testabilidad.

### 🔁 Repository Pattern
La lógica de persistencia y acceso a datos se abstrae mediante un repositorio (`CatBreedRepository`) que implementa un protocolo (`CatBreedRepositoryProtocol`). Esto permite desacoplar el acceso a Core Data del resto de la app, y facilita la implementación de pruebas unitarias.

### 💉 Inyección de Dependencias
La clase `CatBreedListViewModel` recibe una instancia del repositorio mediante inyección de dependencias:

