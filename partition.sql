#sem consultar pela partição

SELECT * FROM `interoper-dataplatform-prd.raw_motion.motion_tb_requisicao` ;

#consultando pela particao

SELECT * FROM `interoper-dataplatform-prd.raw_motion.motion_tb_requisicao` 
WHERE dt = "2021-04-04" 

