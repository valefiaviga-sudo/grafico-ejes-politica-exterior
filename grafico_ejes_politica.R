# Script: Gráfico de Barras - Frecuencia de Ejes de Política Exterior
# Lee datos directamente desde Excel y cuenta las repeticiones
# Los datos deben estar en: Libro1.xlsx, Hoja 1, columna "Axes de política exterior"

# ==========================================
# INSTALACIÓN DE PAQUETES (ejecutar solo la primera vez)
# ==========================================
# Descomenta las siguientes líneas si es la primera vez que usas estos paquetes:
# install.packages("readxl")
# install.packages("ggplot2")
# install.packages("dplyr")

# ==========================================
# CARGAR LIBRERÍAS
# ==========================================
library(readxl)
library(ggplot2)
library(dplyr)

# ==========================================
# CONFIGURACIÓN
# ==========================================
# Cambia estos valores según la ubicación de tu archivo
archivo_excel <- "Libro1.xlsx"
nombre_hoja <- 1  # O usa "Sheet1" si prefieres el nombre
nombre_columna <- "Axes de política exterior"

# ==========================================
# LEER DATOS DESDE EXCEL
# ==========================================
tryCatch({
  # Leer el archivo Excel
  datos_raw <- read_excel(archivo_excel, sheet = nombre_hoja)
  
  # Verificar que la columna existe
  if (!nombre_columna %in% names(datos_raw)) {
    stop(paste("La columna '", nombre_columna, "' no existe en el Excel"))
  }
  
  # Extraer la columna
  ejes_vector <- datos_raw[[nombre_columna]]
  
  # Eliminar valores vacíos o NA
  ejes_vector <- ejes_vector[!is.na(ejes_vector) & ejes_vector != ""]
  
  # Contar frecuencias
  ejes_frecuencias <- table(ejes_vector)
  
  # Convertir a dataframe
  ejes_datos <- data.frame(
    Eje = names(ejes_frecuencias),
    Conteo = as.numeric(ejes_frecuencias)
  )
  
  # Ordenar de mayor a menor
  ejes_datos <- ejes_datos %>%
    arrange(desc(Conteo))
  
  print("✓ Datos cargados exitosamente desde Excel")
  print(paste("Total de registros procesados:", sum(ejes_datos$Conteo)))
  
}, error = function(e) {
  stop(paste("Error al leer Excel:", e$message, 
             "\n\nAsegúrate de que:",
             "\n1. El archivo 'Libro1.xlsx' está en la carpeta de trabajo de R",
             "\n2. La hoja 1 existe",
             "\n3. La columna 'Axes de política exterior' existe con ese nombre exacto"))
})

# ==========================================
# CREAR EL GRÁFICO
# ==========================================
grafico <- ggplot(ejes_datos, aes(x = reorder(Eje, -Conteo), y = Conteo)) +
  geom_bar(stat = "identity", fill = "#4472C4", color = "#4472C4") +
  labs(
    title = "Frecuencia de Ejes de Política Exterior",
    x = "Ejes de Política Exterior",
    y = "Conteo"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 10),
    axis.text.y = element_text(size = 10),
    axis.title.x = element_text(size = 12, face = "bold"),
    axis.title.y = element_text(size = 12, face = "bold"),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    panel.grid.major = element_line(color = "#E0E0E0"),
    panel.grid.minor = element_blank()
  )

# ==========================================
# MOSTRAR EL GRÁFICO
# ==========================================
print(grafico)

# ==========================================
# GUARDAR EL GRÁFICO
# ==========================================
ggsave("grafico_ejes_politica_exterior.png", 
       plot = grafico, 
       width = 12, 
       height = 6, 
       dpi = 300)

print("✓ Gráfico guardado como 'grafico_ejes_politica_exterior.png'")

# ==========================================
# MOSTRAR RESUMEN DE DATOS
# ==========================================
print("\n========== RESUMEN DE DATOS ==========")
print(ejes_datos)
print("\n========== ESTADÍSTICAS ==========")
print(paste("Total de registros:", sum(ejes_datos$Conteo)))
print(paste("Número de ejes únicos:", nrow(ejes_datos)))
print(paste("Eje más frecuente:", ejes_datos$Eje[1], "-", ejes_datos$Conteo[1], "registros"))
