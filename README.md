# Cerebral Tuberculoma in Pregnancy (1975 – 2025)

### Systematic Review & Descriptive Analysis of 33 Reported Cases

---

**Pre‑print:** https://www.researchsquare.com/article/rs-4349914/v1
**Last update:** 13 May 2025

---

## 1 · Project Scope

This repository contains the fully reproducible workflow for the systematic review **“Cerebral Tuberculoma in Pregnant Women: A 50‑Year Synthesis of the Literature.”** We harmonised every individual‑level case published between January 1975 and March 2025 to describe presentation, diagnostics, treatment and maternal–fetal outcomes.

---

## 2 · Repository Structure

| Path / File              | Purpose                                      |
| ------------------------ | -------------------------------------------- |
| `data/`                  | Curated datasets (Excel + RDS)               |
|  ├── `df_symptoms.*`     | Maternal symptoms *(n = 33)*                 |
|  ├── `df_clinical.*`     | Objective clinical findings                  |
|  ├── `df_diagnosis.*`    | Laboratory, CSF & neuro‑imaging data         |
|  └── `df_treatment.*`    | Management and outcomes                      |
| `scripts/`               | Executable R pipelines                       |
|  ├── `Script_limpieza.R` | Data cleaning & export                       |
|  └── `Script_analisis.R` | Descriptive analysis (gtsummary)             |
| `figures/`               | Static figures (e.g. **Figure 1** BioRender) |
| `README.md`              | This file                                    |
| `LICENSE`                | MIT Licence                                  |

---

## 3 · Quick Start

### 3.1 Prerequisites

| Software | Tested version                                        |
| -------- | ----------------------------------------------------- |
| R        | ≥ 4.3                                                 |
| RStudio  | ≥ 2023.12                                             |
| Packages | `dplyr`, `gtsummary`, `readxl`, `ggplot2`, `openxlsx` |

### 3.2 Reproduce analysis

```bash
# Clone repository
git clone https://github.com/derebellon/tuberculoma_data.git
cd tuberculoma_data

# Generate cleaned datasets
Rscript scripts/Script_limpieza.R

# Produce summary tables
Rscript scripts/Script_analisis.R
```

Tables print to console; redirect output if persistent files are required.

---

## 4 · Key Findings (snapshot)

| Domain                     | Principal result (n = 33)                                      |
| -------------------------- | -------------------------------------------------------------- |
| **Median maternal age**    | 26 y (IQR 23–29)                                               |
| **Diagnosis timing**       | 45 % ante‑partum · 55 % post‑partum                            |
| **Dominant symptoms**      | Headache 59 % · Fever 56 % · Seizures 48 %                     |
| **Neuro‑imaging**          | 70 % supratentorial · 30 % infratentorial; 58 % ring‑enhancing |
| **Treatment**              | 97 % four‑drug anti‑TB + steroids; 60 % biopsy/resection       |
| **Maternal mortality**     | 4.5 %                                                          |
| **Live births**            | 26 / 33 pregnancies (79 %); 72 % pre‑term                      |
| **Neonatal complications** | 50 % overall; congenital TB 17 %                               |

*See **Figure 1** in `figures/` for the symptom‑to‑outcome cascade.*

---

## 5 · Citation

> Rebellón‑Sánchez DE, Vinueza D, Castro Restrepo DE, Llanos JA, Rosso F.
> *Cerebral Tuberculoma in Pregnancy (1975–2025): Systematic Review & Descriptive Analysis of 33 Cases* \[dataset and code]. GitHub. 2025.
> URL: [https://github.com/derebellon/tuberculoma\_data](https://github.com/derebellon/tuberculoma_data)

Please cite the pre‑print once available for full methodological details.

---

## 6 · Contributing

Pull requests improving documentation, reproducibility or extending analyses are welcome. For data or code queries contact **David E. Rebellón‑Sánchez**:

* ✉️ david.rebellon‑[sanchez@lshtm.ac.uk](mailto:sanchez@lshtm.ac.uk) │ [derebellons@gmail.com](mailto:derebellons@gmail.com)

---

## 7 · Disclaimer

Materials are provided **for research and educational purposes only** and do **not** replace professional medical guidance.

---

© 2025 David E. Rebellón‑Sánchez et al. · MIT License
