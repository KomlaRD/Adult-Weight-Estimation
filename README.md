# 🏥 Adult weight estimation in a tertiary hospital in Ghana

This repository contains code, data preprocessing steps, and model training pipelines used for estimating adult body weight in a clinical Ghanaian population. It is part of a study submitted to the Deep Learning Indaba Conference.

---

## 📌 Abstract

Accurate weight estimation is essential for estimating nutritional requirements for patients, especially among bedridden patients, where direct measurement is often not feasible due to the absence of bed scales. In such scenarios, clinicians rely on existing predictive equations, visual assessments, or patient-reported estimates. However, many existing predictive equations were developed in distinct demographic groups and may lack applicability without localised validation. This study employed a cross-sectional design involving 389 adult patients at the Cape Coast Teaching Hospital to develop and evaluate weight estimation models. Standardised protocols were followed to collect anthropometric measurements, including weight, height, mid-upper arm circumference (MUAC), and calf circumference (CC). Each variable was measured twice, and the mean of the two measurements was used for subsequent analysis. The dataset was partitioned into a training set (80%) and a testing set (20%). Automated machine learning algorithms were trained utilising the H2O.ai framework. Model performance was assessed using the mean absolute error (MAE), root mean squared error (RMSE), coefficient of determination (R2), and the proportion of predictions falling within 10% (P10) and 20% (P20) of the actual weight. Pre-existing, relevant equations were applied to predict weight on the complete dataset, and the resulting predictions were evaluated against the actual weight using MAE, RMSE, R2, P10, and P20.The average age of participants in the study was 57 years (interquartile range [IQR]: 42-66). The majority of the participants were females (66%). The average weight was 65 kg (IQR: 58-72), with the majority (46%) of participants having a normal body mass index (BMI) status. Our AutoML-derived stacked ensemble model outperformed all evaluated methods, achieving lower error rates (MAE of 3 kg and RMSE of 4kg),a high R2 of 0.9 and P10 and P20 values of 90% and 100%,respectively. While this current study highlights the importance of locally trained models, generalisability remains a limitation and warrants further validation across broader populations. Regardless, this study contributes important evidence for the development of population-specific adult weight estimation models to support clinical decision making.

---

## 📊 Dataset

- **Source**: Cape Coast Teaching Hospital (CCTH), Ghana
- **Size**: 389 adults
- **Variables**: Age, Sex, Height, Weight, Mid-upper Arm Circumference (MUAC), Calf Circumference (CC), BMI Category
- **No Missing Values**
- **Ethical Approval**: CCTHERC/EC/2024/097

---

## ⚙️ ML Pipeline

1. **Data Cleaning & Outlier Treatment**
2. **Feature Selection** (`age`, `sex`, `height`, `cc`, `muac`, `bmi_cat`)
3. **Train/Test Split (80/20)**
4. **Model Training with H2O AutoML**
5. **Stacked Ensemble Selection**
6. **Model Evaluation** (`MAE`, `RMSE`, `R²`, `P10`, `P20`)
7. **Explainability** (`Feature importance`, `SHAP`, `PDP`)
8. **Deployment**: Shiny Web Application for bedside use

---

## 🔍 Model Performance

| Model                   | MAE (kg) | RMSE (kg) | R²   | P10 (%) | P20 (%) |
|------------------------|----------|-----------|------|----------|----------|
| Kokong Equation        | 11       | 14         | -2.9   | 43       | 70    |
| Simplified MUAC        | 15       | 18         | 0.1    | 23       | 50    |
| Crandall Equation      | 23       | 25         | -2.8   | 6        | 17    |
| AutoML Ensemble        | 3        | 4          | 0.9    | 90       | 100   |

---

## 🧠 Tools & Libraries

- Python 3.11
- Pandas, Seaborn, Matplotlib
- [H2O AutoML](https://docs.h2o.ai/h2o/latest-stable/h2o-docs/automl.html)
- Shiny (R) for frontend application
- GitHub for version control and reproducibility

---

## Dataset

Anku, E. K., & Sam, M. (2025). Adult weight estimation in a tertiary hospital in Ghana [Data set]. Deep Learning Indaba (DLI). Zenodo. https://doi.org/10.5281/zenodo.16036510