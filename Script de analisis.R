# Limpio el entorno
rm(list=ls())

## Carga de librerias
library(dplyr)
library(gtsummary)
library(readxl)
library(ggplot2)
library(openxlsx)


# Leer los archivos RDS y cargarlos como dataframes
df_symptoms <- readRDS(file.path("data", "df_symptoms.rds"))
df_clinical <- readRDS(file.path("data", "df_clinical.rds"))
df_diagnosis <- readRDS(file.path("data", "df_diagnosis.rds"))
df_treatment <- readRDS(file.path("data", "df_treatment.rds"))


# Elimino columna que estorba en las tablas
df_symptoms <- subset(df_symptoms, select = -c(Author))
df_clinical <- subset(df_clinical, select = -c(Author))
df_diagnosis <- subset(df_diagnosis, select = -c(Author))
df_treatment <- subset(df_treatment, select = -c(Author))
df_symptoms <- subset(df_symptoms, select = -c(Year))


# Describiendo df_symptoms
tbl_symptoms <- tbl_summary(df_symptoms, digits = everything() ~ 2)

# Describiendo df_clinical
tbl_clinical <- tbl_summary(df_clinical, digits = everything() ~ 2)

# Describiendo df_diagnosis
tbl_diagnosis <- tbl_summary(df_diagnosis, digits = everything() ~ 2)

# Describiendo df_treatment
tbl_treatment <- tbl_summary(df_treatment, digits = everything() ~ 2)


#Print de las tablas
tbl_symptoms
tbl_clinical
tbl_diagnosis
tbl_treatment

