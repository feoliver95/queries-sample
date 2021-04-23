#sem consultar pela partição

SELECT * FROM `interoper-dataplatform-prd.temp_treinamento.motion_tb_requisicao` ;

#consultando pela particao

SELECT * FROM `interoper-dataplatform-prd.temp_treinamento.motion_tb_requisicao` 
WHERE dt = "2021-04-04" 

