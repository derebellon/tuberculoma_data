# Limpio el entorno
rm(list=ls())

## Carga de librerias
library(dplyr)
library(gtsummary)
library(readxl)
library(ggplot2)
library(openxlsx)

## data
df_symptoms <- read_excel("data/df2.xlsx",
                 sheet = "symptoms",
                 na = "888")

df_clinical <- read_excel("data/df2.xlsx",
                          sheet = "clinical findings",
                          na = "888")

df_diagnosis <- read_excel("data/df2.xlsx",
                          sheet = "diagnosis",
                          na = "888")

df_treatment <- read_excel("data/df2.xlsx",
                          sheet = "treatment",
                          na = "888")

## resumiendo nombres de las variables
names(df_symptoms)
names(df_clinical)
names(df_diagnosis)
names(df_treatment)

## arreglando el nombre de las variables


# Renombrar las variables del dataframe df_symptoms
names(df_symptoms) <- c("Author", "Year", "Age", "MomentDiagnosis", 
                        "GestAge", "PastTbHistory", "ContactTbPlus", 
                        "IVF", "Fatigue", "Fever", "Headache", 
                        "LowBackPain", "VisualDisturb", "Diplopia", 
                        "Auras", "Nausea", "Emesis", "Diarrhea", 
                        "LossAppetite", "UrineRetention", "Seizures", 
                        "StrengthReduction", "Vertigo", "MentalFuncAlter", 
                        "NightSweats", "RespSymptoms", "LossWeight", "Malaise")

# Lista de variables que necesitan los labels "No" y "Yes"
variables_labels <- c("PastTbHistory", "ContactTbPlus", "IVF", 
                      "Fatigue", "Fever", "Headache", "LowBackPain", 
                      "VisualDisturb", "Diplopia", "Auras", "Nausea", "Emesis", 
                      "Diarrhea", "LossAppetite", "UrineRetention", "Seizures", 
                      "StrengthReduction", "Vertigo", "MentalFuncAlter", 
                      "NightSweats", "RespSymptoms", "LossWeight", "Malaise")

# Asignar labels "No" y "Yes" a las variables seleccionadas
for (variable in variables_labels) {
  df_symptoms[[variable]] <- factor(df_symptoms[[variable]], 
                                    levels = c(0, 1), 
                                    labels = c("No", "Yes"))
}

df_symptoms$MomentDiagnosis <- factor(df_symptoms$MomentDiagnosis, 
                                  levels = c(0, 1), 
                                  labels = c("Pregnancy", "Postpartum/Post-abort"))

# Verificación
str(df_symptoms)


# Renombrar las variables del dataframe df_clinical
names(df_clinical) <- c("Author", "DiminConsLevel", "ObjSMFAlter", "CranNerveComp", 
                        "FacialPalsy", "EyeMoveParesis", "AlteredFundoscopy", 
                        "PapillaryEdema", "PupilAlteration", "DeepTendReflexes", 
                        "MeningealSigns", "Paresia", "CerebellarSigns", 
                        "Lymphadenopathy", "RespSigns")

# Lista de variables con opciones de respuesta "No=0, Yes=1"
variables_sino <- c("DiminConsLevel", "ObjSMFAlter", "CranNerveComp", "FacialPalsy", 
                    "EyeMoveParesis", "AlteredFundoscopy", "PapillaryEdema", 
                    "PupilAlteration", "MeningealSigns", "Paresia", "CerebellarSigns", 
                    "Lymphadenopathy", "RespSigns")

# Asignar labels "No" y "Yes" a las variables seleccionadas
for (variable in variables_sino) {
  df_clinical[[variable]] <- factor(df_clinical[[variable]], 
                                    levels = c(0, 1), 
                                    labels = c("No", "Yes"))
}

# Variable 'DeepTendReflexes' tiene múltiples opciones de respuesta
# Asignar labels específicos para esta variable
df_clinical$DeepTendReflexes <- factor(df_clinical$DeepTendReflexes, 
                                       levels = c(0, 1, 2, 3), 
                                       labels = c("Normal", "Diminished", "Abolished", "Augmented"))

# Verificación
str(df_clinical)


# Renombrar las variables del dataframe df_diagnosis
names(df_diagnosis) <- c("Author", "SkinTubTest", "SputumStain", "SputumCulture",
                         "MTBPCR", "MTBCultures", "MTBUrineCulture", "TubercAntigen",
                         "IgMA60", "TSpotTb", "LPOpPressure", "CSFProteins",
                         "CSFLeucocytes", "CSFLeucocyteType", "CSFLactate", 
                         "CSFGlucose", "CSFAFBStain", "CSFMycobCult", "CSFPCRMBT",
                         "CSFADATest", "TbIGRA", "ImageType", "LesionShape",
                         "LesionNumber", "LesionLocation", "CTLesionDensity",
                         "T1LesionSignal", "T2LesionSignal", "FLAIRLesionSignal",
                         "LesionEnhContrast", "MeningealEnh", "Hydrocephalus",
                         "MidlineShift", "VentricleDilation", "IschemiaSigns",
                         "PerilesionalEdema", "AbdImaging", "LungImaging",
                         "CerebBiopsy", "GranulomInflam", "CaseousNecrosis",
                         "IschemicNecrosis", "FibrinoidExudates", "VascularOcclus",
                         "LanghansGiantCells", "LymphInfiltrates", "BiopsyAFStain")

# Asignar labels "Negative" y "Positive" a las variables seleccionadas
negative_positive_vars <- c("SkinTubTest", "SputumStain", "SputumCulture", 
                            "MTBPCR", "MTBCultures", "MTBUrineCulture", "TubercAntigen",
                            "IgMA60", "TSpotTb", "CSFAFBStain", "CSFMycobCult", 
                            "CSFPCRMBT", "TbIGRA", "BiopsyAFStain")

for (variable in negative_positive_vars) {
  df_diagnosis[[variable]] <- factor(df_diagnosis[[variable]], 
                                     levels = c(0, 1), 
                                     labels = c("Negative", "Positive"))
}


# Hay una variable problema que podia tener mas de una opcion de respuesta, las siguientes lineas arreglan eso generando una nueva columna segun cada opcion de respuesta

# Asegurarse de que los datos estén como caracteres para facilitar la manipulación
df_diagnosis$LesionLocation <- as.character(df_diagnosis$LesionLocation)

# Nombres para las nuevas columnas basados en el diccionario
locations <- c("Locali_FrontalLobe", "Locali_ParietotemporalLobes", "Locali_OccipitalLobe", 
               "Locali_Cerebellum", "Locali_Brainstem", "Locali_Medulla", "Locali_BasalGanglia", 
               "Locali_ThalamusHypothalamus", "Locali_Other")

# Crear las nuevas columnas y asignar NA como valor predeterminado
for (loc in locations) {
  if (!loc %in% names(df_diagnosis)) {
    df_diagnosis[[loc]] <- NA
  }
}

# Rellenar las nuevas columnas
for (i in 1:nrow(df_diagnosis)) {
  if (!is.na(df_diagnosis$LesionLocation[i]) && df_diagnosis$LesionLocation[i] != "") {
    # Separar las ubicaciones de lesión para cada paciente
    lesion_locations <- strsplit(df_diagnosis$LesionLocation[i], ",")[[1]]
    # Eliminar espacios y convertir a números
    lesion_locations <- as.numeric(gsub(" ", "", lesion_locations))
    
    for (loc_index in 0:8) {
      col_name <- locations[loc_index + 1]
      if (loc_index %in% lesion_locations) {
        df_diagnosis[i, col_name] <- 1
      } else {
        df_diagnosis[i, col_name] <- 0
      }
    }
  }
}



# Asignar labels para variables con opciones "No" y "Yes"
no_yes_vars <- c("LesionEnhContrast", "MeningealEnh", "Hydrocephalus", "MidlineShift",
                 "VentricleDilation", "IschemiaSigns", "PerilesionalEdema", "AbdImaging", 
                 "LungImaging", "CerebBiopsy", "GranulomInflam", "CaseousNecrosis", 
                 "IschemicNecrosis", "FibrinoidExudates", "VascularOcclus", 
                 "LanghansGiantCells", "LymphInfiltrates", "Locali_FrontalLobe", "Locali_ParietotemporalLobes", "Locali_OccipitalLobe", 
                 "Locali_Cerebellum", "Locali_Brainstem", "Locali_Medulla", "Locali_BasalGanglia", 
                 "Locali_ThalamusHypothalamus", "Locali_Other")

for (variable in no_yes_vars) {
  df_diagnosis[[variable]] <- factor(df_diagnosis[[variable]], 
                                     levels = c(0, 1), 
                                     labels = c("No", "Yes"))
}

# Asignar labels para variables con múltiples categorías

df_diagnosis$CSFLeucocytes <- factor(df_diagnosis$CSFLeucocytes, 
                                  levels = c(0, 1), 
                                  labels = c("Normal", "Elevated"))


df_diagnosis$CSFLeucocyteType <- factor(df_diagnosis$CSFLeucocyteType, 
                                        levels = c(0, 1, 2, 3), 
                                        labels = c("Monocyte/Lymphocyte", "Neutrophils", "Neutrophils/Monocytes", "Not apply"))

df_diagnosis$CSFLactate <- factor(df_diagnosis$CSFLactate, 
                                     levels = c(0, 1), 
                                     labels = c("Normal", "Elevated"))


df_diagnosis$CSFGlucose <- factor(df_diagnosis$CSFGlucose, 
                                  levels = c(0, 1, 2), 
                                  labels = c("Normal", "Low", "Elevated"))

df_diagnosis$CSFADATest <- factor(df_diagnosis$CSFADATest, 
                                  levels = c(0, 1), 
                                  labels = c("Normal", "Elevated"))

df_diagnosis$ImageType <- factor(df_diagnosis$ImageType, 
                                 levels = c(0, 1), 
                                 labels = c("CT", "MRI"))

df_diagnosis$LesionShape <- factor(df_diagnosis$LesionShape, 
                                   levels = c(0, 1, 2, 3), 
                                   labels = c("Oval/Rounded", "Ring-like/Anular", "Nodular", "Irregular"))

df_diagnosis$LesionNumber <- factor(df_diagnosis$LesionNumber, 
                                    levels = c(0, 1), 
                                    labels = c("Unique", "Multiple"))

# Convertir CT Lesion Density en factor con etiquetas correspondientes
df_diagnosis$CTLesionDensity <- factor(df_diagnosis$CTLesionDensity, 
                                       levels = c(0, 1, 2), 
                                       labels = c("Hypodense", "Isodense", "Hyperdense"))

# Convertir T1 Lesion Signal en factor con etiquetas correspondientes
df_diagnosis$T1LesionSignal <- factor(df_diagnosis$T1LesionSignal, 
                                      levels = c(0, 1, 2, 3, 4), 
                                      labels = c("Hypointense", "Isointense", "Isointense/hyperintense", "Isointense/hypointense", "Hyperintense"))

# Convertir T2 Lesion Signal en factor con etiquetas correspondientes
df_diagnosis$T2LesionSignal <- factor(df_diagnosis$T2LesionSignal, 
                                      levels = c(0, 1, 2, 3, 4), 
                                      labels = c("Hypointense", "Isointense", "Isointense/hyperintense", "Hyperintense", "Hypointese/Hyperintese"))

# Convertir FLAIR Lesion Signal en factor con etiquetas correspondientes
df_diagnosis$FLAIRLesionSignal <- factor(df_diagnosis$FLAIRLesionSignal, 
                                         levels = c(0, 1, 3), 
                                         labels = c("Hypointense", "Isointense", "Hyperintense"))




# Renombrar las variables del dataframe df_treatment
names(df_treatment) <- c("Author", "AntiTB_Treatment", "Isoniazid", "Rifampicin",
                         "Pyrazinamide", "Ethambutol", "Streptomycin", "Quinolone",
                         "TreatmentDuration", "IntensivePhaseDuration", "ContinuationPhaseDuration",
                         "SteroidUse", "SteroidRoute", "AntiepilepticTreatment",
                         "AntiedematousTreatment", "SurgicalTreatment", "SurgicalPurpose",
                         "ICURequirement", "Mortality", "NeuroSeqFollowUp",
                         "ImagingFollowUp", "NewbornComplications", "TypeNewbornComplication", "PretermDelivery")

# Asignar labels "No" y "Yes" a las variables seleccionadas
yes_no_vars <- c("AntiTB_Treatment", "Isoniazid", "Rifampicin", "Pyrazinamide", 
                 "Ethambutol", "Streptomycin", "Quinolone", "SteroidUse", 
                 "AntiepilepticTreatment", "AntiedematousTreatment", "SurgicalTreatment", 
                 "ICURequirement", "Mortality", "NeuroSeqFollowUp", 
                 "NewbornComplications")

for (variable in yes_no_vars) {
  df_treatment[[variable]] <- factor(df_treatment[[variable]], 
                                     levels = c(0, 1), 
                                     labels = c("No", "Yes"))
}

# Asignar labels para variables con múltiples categorías
df_treatment$TreatmentDuration <- factor(df_treatment$TreatmentDuration, 
                                         levels = c(0, 1, 2), 
                                         labels = c("≤ 9 months", ">9 to ≤12 months", ">12 months"))

df_treatment$IntensivePhaseDuration <- factor(df_treatment$IntensivePhaseDuration, 
                                              levels = c(0, 1, 2), 
                                              labels = c("2 months", "3 months", ">3 months"))

df_treatment$ContinuationPhaseDuration <- factor(df_treatment$ContinuationPhaseDuration, 
                                                 levels = c(0, 1, 2, 3), 
                                                 labels = c(">9 but ≤ 12 months", ">12 but ≤ 15 months", ">15 months", "<9 months"))

df_treatment$SteroidRoute <- factor(df_treatment$SteroidRoute, 
                                    levels = c(0, 1, 2), 
                                    labels = c("Oral", "IV", "Both"))

df_treatment$SurgicalPurpose <- factor(df_treatment$SurgicalPurpose, 
                                       levels = c(0, 1, 2, 3), 
                                       labels = c("Surgical resection", "Biopsy", "Exploration", "Decompression"))

df_treatment$ImagingFollowUp <- factor(df_treatment$ImagingFollowUp, 
                                       levels = c(1, 2, 3), 
                                       labels = c("Persistent lesions", "Improved", "Didn't change"))

df_treatment$TypeNewbornComplication <- factor(df_treatment$TypeNewbornComplication, 
                                       levels = c(0, 1, 2, 3, 4, 5, 6), 
                                       labels = c("Newborn death", "Abortion", "Fetal loss", "Neonatal Tb", "SGA", "Neonatal Tb and Newborn death" , "Other"))

df_treatment$PretermDelivery <- factor(df_treatment$PretermDelivery, 
                                       levels = c(0, 1, 2), 
                                       labels = c("No", "Yes", "Abortion"))


# Identificar todas las variables que no son dataframes
non_df_vars <- names(which(sapply(ls(), function(x) !is.data.frame(get(x)))))

# Eliminar estas variables
rm(list = non_df_vars)
rm(non_df_vars)


# Exportar cada dataframe como un archivo Excel
write.xlsx(df_symptoms, file.path("data/df_symptoms.xlsx"))
write.xlsx(df_clinical, file.path("data/df_clinical.xlsx"))
write.xlsx(df_diagnosis, file.path("data/df_diagnosis.xlsx"))
write.xlsx(df_treatment, file.path("data/df_treatment.xlsx"))



# Guardar cada dataframe como un archivo RDS
saveRDS(df_symptoms, file.path("data", "df_symptoms.rds"))
saveRDS(df_clinical, file.path("data", "df_clinical.rds"))
saveRDS(df_diagnosis, file.path("data", "df_diagnosis.rds"))
saveRDS(df_treatment, file.path("data", "df_treatment.rds"))
