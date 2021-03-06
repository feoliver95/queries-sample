/*
---------------------------------------------------------------
CÓDIGO NÃO OTIMIZADO
---------------------------------------------------------------
*/

# Cria um campo calculado.
WITH _WM_0 AS (
    SELECT SAFE.SUBSTR(series_id, 0, 3) AS code_series_id, 
    year, period, series_title 
    FROM `bigquery-public-data.bls.wm`
),
# Consome o campo calculado e adiciona uma condição.
_WM_1 AS (
    SELECT code_series_id, year, period, series_title
    FROM _WM_0
    WHERE code_series_id = "WMU"
),
# Adiciona outra condição para year.
_WM_2 AS (
    SELECT code_series_id, year, period, series_title
    FROM _WM_1
    WHERE year = 2019
    LIMIT 1000
),
# Adiciona outra condição para series_title.
_WM_3 AS (
    SELECT code_series_id, year, period, series_title
    FROM _WM_2
    WHERE _WM_2.series_title LIKE "%healthcare%"
)

# Retorna o resultado final. Neste caso usar "*"
# está ok uma vez que em certeza do resultado
SELECT * FROM _WM_3




/*
---------------------------------------------------------------
CÓDIGO OTIMIZADO
---------------------------------------------------------------
*/

# Cria tabela temporária utilizando EXPIRATION_TIMESTAMP.
CREATE OR REPLACE TABLE `interoper-dataplatform-prd.temp_treinamento.temp_table`
  OPTIONS(EXPIRATION_TIMESTAMP=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 1 DAY)) 
AS
(
    # Aplica todas as regras possíveis de uma vez só e cria a tabela.
    SELECT 
    SAFE.SUBSTR(series_id, 0, 3) AS code_series_id, 
    year, 
    period, 
    series_title 
    FROM 
        `bigquery-public-data.bls.wm`
    WHERE 
        series_title LIKE "%healthcare%" AND
        year = 2019
);

# Retorna o resultado final filtrando o campo calculado.
SELECT * 
FROM `interoper-dataplatform-prd.temp_treinamento.temp_table`
WHERE code_series_id = "WMU"
LIMIT 1000
