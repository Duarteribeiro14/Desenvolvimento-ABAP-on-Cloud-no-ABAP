CLASS zcl_fabap_jul2025_exer02_dmr2 DEFINITION
  PUBLIC
  INHERITING FROM zcl_fabap_jul2025_exer02_dmr
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_nome         TYPE string
        i_id           TYPE string
        i_salario_base TYPE decfloat16
        i_horas        TYPE i
      .

    METHODS calcular_salario REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: gv_horas TYPE i.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_DMR2 IMPLEMENTATION.


  METHOD calcular_salario.

    rv_salario = pv_salario_base * gv_horas.

  ENDMETHOD.


  METHOD constructor.

    super->constructor( v_nome = i_nome
                        v_id = i_id
                        v_salario_base = i_salario_base ).
    gv_horas = i_horas.

  ENDMETHOD.
ENDCLASS.
