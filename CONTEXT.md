# 📄 CONTEXT.md - Project Context & AI Agent Guide

> **Last Updated:** `[2026-06-28]`  
> **Project Type:** Data Analysis, Visualization Critique & Reproducible Workflow  
> **Primary Audience:** Team Members & AI Coding/Analysis Agents

---

## 🎯 1. Project Overview & Objectives

This project critiques and improves an existing visualization of Southeast Asia's energy consumption patterns. Our core objectives, per the project description, are:

1. **Apply data analysis techniques** to generate meaningful insights from structured data.
2. **Document data and code** to ensure absolute clarity, transparency, and reproducibility.
3. **Collaborate effectively** as a team to execute a complete, version-controlled data workflow.

**Deliverable:** A fully reproducible Quarto document (`index.qmd`) that documents the critique, data pipeline, improved visualizations, and analytical insights, deployed via GitHub Pages.

---

## 📊 2. Dataset & Data Context

| Attribute | Details |
|-----------|---------|
| **Filename** | `data/energy_data.csv` |
| **Nature** | **Synthetic proxy dataset** (original source is not publicly available) |
| **Scope** | 10 Southeast Asian countries, Year: 2024 |
| **Structure** | Long-format table with columns likely including: `Country`, `Fuel_Type`, `End_Use_Sector`, `Percentage`, `Panel` (`Fuels`/`Sector`) |
| **Key Constraint** | Values are normalized to 100% per country per panel. All proportional relationships and categorical mappings are preserved from the original data, but absolute values are synthetic. |

⚠️ **AI Agent Note:** Never claim this data is official or publicly verifiable. When generating analysis or visualizations, explicitly note: *"Based on a structurally faithful synthetic dataset proxying the original non-public source."*

---

##  3. Visualization Context: Original Chart

**Title:** `Total final consumption mix by fuel and end-use sector in Southeast Asia, 2024`

**Structure:**
- **Dual-panel stacked bar chart** (100% height)
- **Left Panel:** `Fuels` composition per country
- **Right Panel:** `End-Use Sectors` composition per country
- **Countries:** Indonesia, Thailand, Viet Nam, Malaysia, Philippines, Myanmar, Singapore, Cambodia, Lao DPR, Brunei Darussalam
- **Y-Axis:** Percentage (0–100%)
- **Encoding:** Color fills represent fuel types (left) and sector categories (right)

**Known Critique Points:**
- Side-by-side 100% stacked bars make cross-country and cross-panel comparisons difficult
- Color palettes may not be consistent or perceptually uniform
- Lack of interactive tooltips or clear legends hinders readability
- Title/axis labels could be more precise for accessibility
- No annotations or callouts to highlight key insights or anomalies

**Improvement Direction:**
- Consider small multiples, grouped bars, or interactive dashboards
- Standardize color mappings with accessibility in mind (colorblind-safe)
- Add data labels, clearer legends, and descriptive captions
- Implement reproducible plotting code (e.g., `ggplot2` or `plotly`)

---

## 🛠️ 4. Technical Stack & Standards

| Component | Specification |
|-----------|---------------|
| **Language** | R (primary)
| **Authoring** | Quarto (`.qmd`) |
| **Visualization** | `ggplot2`, `patchwork`, `plotly`, or equivalent |
| **Data Handling** | `tidyverse`, `readr`, `dplyr`, or `pandas`/`polars` |
| **Path Management** | `here::here()` or `pathlib` (NO hard-coded absolute paths) |
| **Version Control** | Git + GitHub (branch-based workflow) |
| **Deployment** | GitHub Pages via Quarto Actions (`quarto publish gh-pages`) |

---

##  5. Expected Project Structure

├── .github/
│   └── workflows/
│       └── publish.yml          # Quarto rendering & GH Pages deployment
├── data/
│   └── energy_data.csv          # Synthetic source data, currently the .csv is just in the root dir
├── scripts/
│   ├── 01_data_cleaning.R       # Ingestion, validation, transformation
│   ├── 02_analysis.R            # Descriptive stats, comparisons
│   └── 03_visualization.R       # Plot generation, theme customization
├── _quarto.yml                  # Global project configuration
├── proposal.qmd                    # Main reproducible report
├── CONTEXT.md                   # This file
├── README.md                    # Public-facing project overview
└── .gitignore                   # Ignore _site/, .Rhistory, .DS_Store, etc.

---

## 🔁 6. Reproducibility & Documentation Standards

1. **Deterministic Outputs:** No stochastic operations. If sampling is used, set and document `set.seed()`.
2. **Package Management:** Log all packages and versions using `sessionInfo()` or `renv`/`conda` environment files.
3. **No Magic Numbers:** Store row offsets, column indices, and thresholds as named constants in a setup chunk.
4. **Validation Assertions:** Embed `stopifnot()` or equivalent checks for:
   - Expected row/column counts
   - Zero-NA tolerance in critical columns
   - Sum-to-100% validation per country/panel
   - Plausible value ranges
5. **Code Comments:** Every function and non-obvious pipeline step must include inline documentation.
6. **AI-Generated Code Policy:** All AI-suggested code must be:
   - Tested locally before committing
   - Reviewed by at least one human team member
   - Documented with a comment noting AI assistance (e.g., `# AI-assisted refactoring: [date]`)

---

## 👥 7. Team Workflow & AI Usage Guidelines

### Git Workflow
- `main`: Protected branch, only merged via PR
- `feature/`, `fix/`, `docs/`: Branch naming convention
- PRs must include: description, screenshot/render of changes, checklist of reproducibility checks

### AI Agent Role
- ✅ **Allowed:** Code generation, debugging, documentation drafting, visualization critique, regex/transform suggestions, test writing
- ❌ **Not Allowed:** Making final analytical conclusions, altering data values, deploying code, bypassing human review
- Additional: Treat this as a living document. Update it when package versions change, data structures shift, or team workflows evolve.

### Prompting Best Practices for AI
When interacting with AI agents, always:
1. Reference this `CONTEXT.md` explicitly
2. Specify language, package constraints, and output format
3. Request step-by-step reasoning before code generation
4. Ask for validation/assertion code alongside transformations
5. Example prompt structure:
   ```
   Based on CONTEXT.md, write an R function to validate that each country's fuel percentages sum to 100% ± 0.01. 
   Include stopifnot() checks and return a tidy summary tibble. Assume input is a dataframe with columns: Country, Fuel_Type, Percentage.
   ```

---

## 📝 8. Quick Reference for AI Agents

| When asked to... | Do this... |
|------------------|------------|
| Generate plots | Use consistent themes, add captions, ensure colorblind-safe palettes, output reproducible code |
| Clean/transform data | Preserve original rows, log steps, add assertions, avoid dropping rows without justification |
| Write documentation | Follow Quarto syntax, use cross-references (`@fig-`, `@tbl-`), keep tone academic/technical |
| Debug errors | Explain root cause, provide minimal reproducible example, suggest fix with rationale |
| Suggest improvements | Reference visualization best practices (Tufte, Cairo, ColorBrewer), note trade-offs |

---

> 🔑 **Rule of Thumb for This Project:**  
> *If it can't be reproduced from a fresh clone with `quarto render index.qmd`, it doesn't belong in the main branch.*

**Maintained by:** `[Group 2]`