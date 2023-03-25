#| Script to install r packages on fresh install ----
#| Author: Mike Carter

##| install {pak} for package management
install.packages("pak")

##| user packages
pkgs <- c(
  #> RCRAN packages
  "tidyverse",
  "easystats",
  "afex",
  "compute.es",
  "emmeans",
  "devtools",
  "fontawesome",
  "ggfortify",
  "ggpath",
  "ggpmisc",
  "ggpp",
  "ggprism",
  "ggpubr",
  "googledrive",
  "gt",
  "here",
  "Hmisc",
  "hrbrthemes",
  "kableExtra",
  "knitr",
  "languageserver",
  "linl",
  "markdown",
  "metafor",
  "miniUI",
  "pagedown",
  "patchwork",
  "preregr",
  "prismatic",
  "qqplotr",
  "quarto",
  "remotes",
  "renv",
  "ggResidpanel",
  "reticulate",
  "rmarkdown",
  "robust",
  "Routliers",
  "scales",
  "styler",
  "sysfonts",
  "TOSTER",
  "trackdown",
  "usethis",
  "vitae",
  "workflowr",
  "WRS2",
  "yaml",
  #> Github or development versions
  "cran/retimes@0.1-2", # archived package workaround
  "crsh/citr",
  "crsh/papaja@devel",
  "debruine/faux",
  "gadenbuie/rsthemes",
  "GRousselet/rogme",
  "hrbrmstr/hrbragg",
  "hrbrmstr/waffle",
  "paleolimbot/rbbt",
  # "paezha/macdown",
  "profandyfield/discovr"
)
pak::pkg_install(pkgs)
