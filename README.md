
<!-- README.md is generated from README.Rmd. Please edit that file -->

# acss.sdm

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of `{acss.sdm}` is to provide some basic web scraping routines
for extraction of information from Sistema de Dados Mestre (SDM):
<https://sdm.min-saude.pt>.

The SDM is a service by the Portuguese Central Administration of the
Health System (ACSS).

## Installation

You can install the current version of `{acss.sdm}` with:

``` r
# install.packages("remotes")
remotes::install_github("nhs-pt/acss.sdm")
```

## Usage

### Get a concept

Get information on a SDM concept:

``` r
library(acss.sdm)

# https://sdm.min-saude.pt/bi.aspx?id_con=1
get_concepts(1)
#> # A tibble: 2 x 3
#>   id    key                     value                      
#>   <chr> <chr>                   <chr>                      
#> 1 001   Acrónimo ou Abreviatura €/UTI                      
#> 2 001   Descrição               Euros por utente utilizador
```

The function `get_concepts` is vectorised over the concept identifiers
`id`:

``` r
get_concepts(1:3)
#> # A tibble: 6 x 3
#>   id    key                 value                                               
#>   <chr> <chr>               <chr>                                               
#> 1 001   Acrónimo ou Abrevi… €/UTI                                               
#> 2 001   Descrição           Euros por utente utilizador                         
#> 3 002   Acrónimo ou Abrevi… ACES                                                
#> 4 002   Descrição           Agrupamento de Centros de Saúde                     
#> 5 003   Acrónimo ou Abrevi… ADSE                                                
#> 6 003   Descrição           Direção-Geral de Proteção Social aos Trabalhadores …
```

### Get an indicator

``` r
get_indicators(1:3)
#> # A tibble: 65 x 3
#>    id    key                 value                                              
#>    <chr> <chr>               <chr>                                              
#>  1 001   Código              "3.12.01"                                          
#>  2 001   Código SIARS        "2013.001.01"                                      
#>  3 001   Nome abreviado      "Proporção de consultas realizadas pelo MF"        
#>  4 001   Designação          "Proporção de consultas realizadas pelo respetivo …
#>  5 001   Objetivo            "Monitorizar o acesso dos utentes ao seu próprio m…
#>  6 001   Descrição do Indic… "Indicador que exprime a proporção de consultas qu…
#>  7 001   Regras de cálculo   "NUMERADOR (AA):\n\r Contagem de contactos em que …
#>  8 001   Observações Gerais  "A. Tanto no numerador como no denominador, apenas…
#>  9 001   Observações Sobre … "MEDICINEONE:\n\r A. Para que as consultas dos int…
#> 10 001   Período em Análise  "INDICADOR CALCULADO PELO MÉTODO DE \"PERÍODO EM A…
#> # … with 55 more rows
```

### Wide format

By default the information is retrieved in long format. You can make it
wider with `make_wide`:

``` r
get_concepts(1:10) %>%
  make_wide()
#> # A tibble: 10 x 3
#>    id    `Acrónimo ou Abreviat… Descrição                                       
#>    <chr> <chr>                  <chr>                                           
#>  1 001   €/UTI                  "Euros por utente utilizador"                   
#>  2 002   ACES                   "Agrupamento de Centros de Saúde"               
#>  3 003   ADSE                   "Direção-Geral de Proteção Social aos Trabalhad…
#>  4 004   ARA II                 "Antagonistas dos Recetores da Angiotensina, ti…
#>  5 005   ARS                    "Administração Regional de Saúde"               
#>  6 006   ATC                    "Classificação \"Anatomical Therapeutic Chemica…
#>  7 007   AVC                    "Acidente Vascular Cerebral"                    
#>  8 008   BI                     "Business Intelligence"                         
#>  9 009   CCF                    "Centro de Conferencia de Faturas"              
#> 10 010   CFT                    "Classificação Farmacoterapêutica de Medicament…
```

``` r
get_indicators(1:10) %>%
  make_wide()
#> # A tibble: 10 x 23
#>    id    Código  `Código SIARS` `Nome abreviado`   Designação      Objetivo     
#>    <chr> <chr>   <chr>          <chr>              <chr>           <chr>        
#>  1 001   3.12.01 2013.001.01    Proporção de cons… Proporção de c… Monitorizar …
#>  2 002   3.15.01 2013.002.01    Taxa de utilizaçã… Taxa de utiliz… Avaliar o ac…
#>  3 003   4.18.01 2013.003.01    Taxa de domicílio… Taxa de consul… Permite moni…
#>  4 004   4.30.01 2013.004.01    Taxa de domicílio… Taxa de consul… Permite moni…
#>  5 005   3.12.02 2013.005.01    Proporção de cons… Proporção de c… Monitorizar …
#>  6 006   3.15.02 2013.006.01    Taxa de utilizaçã… Taxa de utiliz… Avaliar o ac…
#>  7 007   7.10    2013.007.01    Proporção utiliz.… Proporção de u… Monitorizar …
#>  8 008   3.22.01 2013.008.01    Taxa de utilizaçã… Taxa de utiliz… Monitorizar …
#>  9 009   3.22.02 2013.009.01    Taxa de utilizaçã… Taxa de utiliz… Monitorizar …
#> 10 010   3.22.03 2013.010.01    Taxa de utilizaçã… Taxa de utiliz… Monitorizar …
#> # … with 17 more variables: Descrição do Indicador <chr>,
#> #   Regras de cálculo <chr>, Observações Gerais <chr>,
#> #   Observações Sobre Software <chr>, Período em Análise <chr>, Fórmula <chr>,
#> #   Unidade de medida <chr>, Output <chr>, Estado do indicador <chr>,
#> #   Área | Subárea | Dimensão <chr>, Intervalo Esperado <chr>,
#> #   Variação Aceitável <chr>, Tipo de Indicador <chr>, Área clínica <chr>,
#> #   Inclusão de utentes no indicador <chr>, Prazo para Registos <chr>,
#> #   Legenda <chr>
```

## TODO

-   Check the extra info coming with the flag `clusters=S` in
    `https://sdm.min-saude.pt/bi.aspx?id=368&clusters=S`, and see if
    it’s parsable.
