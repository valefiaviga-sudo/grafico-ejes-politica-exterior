# Script: Gráfico de Barras - Frecuencia de Ejes de Política Exterior
# Este script genera un gráfico de barras similar al de Indicadores Constitucionales
# utilizando datos sobre los ejes de la política exterior

# Instalar paquetes necesarios (ejecutar solo la primera vez)
# install.packages("ggplot2")
# install.packages("dplyr")

# Cargar librerías
library(ggplot2)
library(dplyr)

# Crear datos de Ejes de Política Exterior
ejes_datos <- data.frame(
  Eje = c(
    "Cooperación para el desarrollo Sostenible",
    "Comercio",
    "Relaciones Bilaterales",
    "Relaciones Multilaterales",
    "Seguridad",
    "Migración",
    "Comunicación",
    "Agenda internacional",
    "Cooperación"
  ),
  Conteo = c(45, 18, 8, 5, 3, 2, 1, 1, 1)  # Valores aproximados similares al gráfico original
)

# Ordenar los datos de mayor a menor
ejes_datos <- ejes_datos %>%
  arrange(desc(Conteo))

# Crear el gráfico de barras
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

# Mostrar el gráfico
print(grafico)

# Guardar el gráfico como archivo PNG (opcional)
ggsave("grafico_ejes_politica_exterior.png", plot = grafico, width = 12, height = 6, dpi = 300)

# Mostrar resumen de datos
print("Resumen de los datos:")
print(ejes_datos)
print(paste("Total de registros:", sum(ejes_datos$Conteo)))
