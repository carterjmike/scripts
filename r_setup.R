#---------------------------------------------------------------
#-- [ R PACKAGE INSTALL SCRIPT ]
#-- Author: Mike Carter
#---------------------------------------------------------------

install.packages("pak")

cran <- c(
  # meta-packages
  "tidyverse",
  "easystats",
  "tidymodels",
  # packages
  "afex",
  "BUCSS",
  "emmeans",
  "devtools",
  "discovr",
  "faux",
  "fontawesome",
  "GGally",
  "ggdist",
  "ggpmisc",
  "ggpp",
  "ggprism",
  "ggResidpanel",
  "grateful",
  "here",
  "Hmisc",
  "kableExtra",
  "knitr",
  "languageserver",
  "lme4",  
  "markdown",
  "marginaleffects",
  "marquee",  
  "MBESS",
  "metafor",  
  "MKinfer",
  "MKpower",
  "modelsummary",  
  "MOTE",
  "patchwork",
  "psych",
  "psychmeta",
  "psychTools",
  "puniform",  
  "pwr",
  "pwr2",
  "pwr4exp",
  "pwranova",
  "pwrss",
  "qqplotr",
  "quarto",
  "readODS",
  "renv",
  "rmarkdown",
  "robust",
  "robustlmm",
  "Routliers",
  "scales",
  "styler",
  "superb",
  "Superpower",
  "tinyplot",
  "tinytable",
  "tost.suite",
  "TOSTER",
  "usethis",
  "WRS2",
  "yaml"
)
pak::pkg_install(cran)

repos <- c(
  "cran/retimes@0.1-2", # archived package workaround
  "giocomai/ganttrify",
  "GRousselet/rogme",
  "JLSteenwyk/ggpubfigs",
  "liamgilbey/ggwaffle",
  "scienceverse/metacheck",
  "scienceverse/scienceverse"
)
pak::pkg_install(repos)


# to explore
#NeuroDataSets