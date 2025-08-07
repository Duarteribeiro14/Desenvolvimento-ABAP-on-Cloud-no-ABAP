CLASS zcl_fabap_jul2025_exer02_dmr1 DEFINITION
  PUBLIC
  INHERITING FROM zcl_fabap_jul2025_exer02_dmr
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
        IMPORTING
        v_nome TYPE string
        v_id TYPE string
        v_salario_base TYPE decfloat16
        v_bonus TYPE decfloat16 OPTIONAL.


    METHODS calcular_salario REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_bonus TYPE decfloat16.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_DMR1 IMPLEMENTATION.


  METHOD calcular_salario.

    rv_salario = pv_salario_base + mv_bonus.

  ENDMETHOD.


  METHOD constructor.

    super->constructor( v_nome = v_nome
                        v_id = v_id
                        v_salario_base = v_salario_base ).
    mv_bonus = v_bonus.

  ENDMETHOD.
ENDCLASS.
