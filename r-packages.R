#> Script to install r packages on fresh install ---
#> Author: Mike Carter

#> install pak for package management rather than default
install.packages("pak")

#> user packages
pkgs <- c(
  # RCRAN packages
  "tidyverse",
  "easystats",
  "afex",
  "compute.es",
  "emmeans",
  "devtools",
  "faux",
  "fontawesome",
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
  "crsh/citr",
  "crsh/papaja@devel",
  "gadenbuie/rsthemes",
  "GRousselet/rogme",
  "hrbrmstr/hrbragg",
  "hrbrmstr/waffle",
  "paleolimbot/rbbt",
  # "paezha/macdown",
  "profandyfield/discovr"
)
pak::pkg_install(pkgs)
