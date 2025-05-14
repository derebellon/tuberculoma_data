# Cargar librerías necesarias
library(ggplot2)
library(tidyr)
library(gridExtra)

# Preparación de datos con todos los papers y sus valoraciones
data <- data.frame(
  Study = c(
    "Capon 1975",    "Centeno 1982",  "Ahmadi 2009",   "Alkan 2003",
    "Liu 2007",      "Pandole 2001",  "Wong 2001",     "Yeh 2009",
    "Saini 2007",    "Elwatidy 2011", "Muin 2015",     "Barragan 2017",
    "Namani 2017",   "Sorbye 2018",   "Yadav 2019",    "Varela 2020",
    "Blessy 2022",   "Malhotra 2016", "Arumugan 2016", "Sujithra 2023",
    "Vempati 2022",  "Li 2023",       "Gakidi 2025",   "Vinueza 2025",
    "Gasparetto 2003","Mazodier 2003","Cvetkovic 2025"
  ),
  Selection     = c("?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?", "?"),
  Ascertainment = c("+", "?", "+", "+", "+", "?", "+", "+", "+", "-", "+", "+", "+", "+", "-", "+", "+", "+", "-", "+", "+", "+", "-", "+", "+", "+", "+", "+"),
  Causality     = c("+", "?", "+", "+", "+", "?", "+", "+", "+", "-", "+", "?", "+", "+", "-", "+", "?", "+", "-", "+", "+", "+", "+", "+", "+", "+", "+"),
  Reporting     = c("+", "?", "+", "+", "+", "?", "+", "+", "+", "-", "+", "?", "+", "+", "-", "+", "+", "+", "+", "+", "+", "+", "+", "+", "+", "+", "+")
)

# Extraer año y reordenar data.frame
data$Year <- as.numeric(sub(".* (\\d{4})$", "\\1", data$Study))
data <- data[order(data$Year), ]

# Convertir a formato largo para ggplot
data_long <- pivot_longer(
  data,
  cols = c("Selection","Ascertainment","Causality","Reporting"),
  names_to  = "Category",
  values_to = "Assessment"
)

# Fijar niveles según orden por año
data_long$Study <- factor(data_long$Study, levels = unique(data$Study))
data_long$Category <- factor(data_long$Category, levels = c("Selection","Ascertainment","Causality","Reporting"))

# Definir paleta y formas
colors <- c("+"="#66c2a5","-"="#fc8d62","?"="#ffd92f")
shapes <- c("+"=3,"-"=4,"?"=63)

# Gráfico
p <- ggplot(data_long, aes(x = Category, y = Study, fill = Assessment)) +
  geom_tile(color = "black", size = 0.5) +
  geom_point(aes(shape = Assessment), size = 5, color = "black") +
  scale_fill_manual(
    name   = "Verdict",
    breaks = c("+","?","-"),
    labels = c("Low risk", "Unclear risk", "High risk"),
    values = c("+" = "#66c2a5",  # verde = bajo riesgo
               "?" = "#ffd92f",  # amarillo = riesgo incierto
               "-" = "#fc8d62")  # rojo = alto riesgo
  ) +
  scale_shape_manual(
    name   = "Verdict",
    breaks = c("+","?","-"),
    labels = c("Low risk", "Unclear risk", "High risk"),
    values = c("+" = 3,   # “+” para bajo riesgo
               "?" = 63,  # “?” para incierto
               "-" = 4)   # “×” para alto riesgo
  )+
  theme_minimal()+
  theme(
    axis.text.x=element_text(angle=45,hjust=1,face="bold"),
    axis.text=element_text(size=12),
    plot.title=element_text(size=16,face="bold"),
    panel.grid=element_blank(),
    axis.ticks=element_blank(),
    legend.title=element_text(size=12,face="bold"),
    legend.text=element_text(size=12)
  )+
  labs(title="Study Quality Assessment", fill="Verdict", shape="Verdict")

# Guardar y mostrar
ggsave("figures/study_quality_assessment.tiff", plot=p, device="tiff", width=12, height=12, dpi=300)
print(p)


