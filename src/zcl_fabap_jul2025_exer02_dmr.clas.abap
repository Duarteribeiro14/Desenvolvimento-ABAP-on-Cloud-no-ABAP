CLASS zcl_fabap_jul2025_exer02_dmr DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
    IMPORTING
        v_nome TYPE string
        v_id TYPE string
        v_salario_base TYPE decfloat16.

    METHODS calcular_salario
    RETURNING VALUE(rv_salario) TYPE decfloat16.

    METHODS exibir_dados
    RETURNING VALUE(rv_dados) TYPE string.

  PROTECTED SECTION.
    DATA: pv_nome         TYPE string,
          pv_id           TYPE string,
          pv_salario_base TYPE decfloat16.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_DMR IMPLEMENTATION.


  METHOD calcular_salario.
    rv_salario = pv_salario_base.
  ENDMETHOD.


  METHOD constructor.
    pv_nome = v_nome.
    pv_id = v_id.
    pv_salario_base = v_salario_base.
  ENDMETHOD.


  METHOD exibir_dados.
    rv_dados = |ID: { pv_id }, Nome: { pv_nome }, Salário Base: { pv_salario_base }|.
  ENDMETHOD.
ENDCLASS.
