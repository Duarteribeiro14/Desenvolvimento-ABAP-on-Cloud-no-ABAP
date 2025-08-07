CLASS zcl_fabap_jul2025_exer02_dmr3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_DMR3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA o_func1 TYPE REF TO zcl_fabap_jul2025_exer02_dmr.
    DATA o_func2 TYPE REF TO zcl_fabap_jul2025_exer02_dmr1.
    DATA o_func3 TYPE REF TO zcl_fabap_jul2025_exer02_dmr2.

    o_func2 = NEW #( v_id = '01' v_nome = 'Duarte Moreira Ribeiro' v_salario_base = '1100' v_bonus = '200' ).

    out->write( 'Salário do Funcionário Integral:' ).
    out->write( o_func2->calcular_salario(  ) ).

    out->write( 'Dados do Funcionário Integral:' ).
    out->write( o_func2->exibir_dados(  ) ).


    o_func3 = NEW #( i_id = '02' i_nome = 'Joana beatriz' i_salario_base = '940' i_horas = '5' ).


    out->write( 'Salário do Funcionário Horista:' ).
    out->write( o_func3->calcular_salario(  ) ).

    out->write( 'Dados do Funcionário Horista:' ).
    out->write( o_func3->exibir_dados(  ) ).
  ENDMETHOD.
ENDCLASS.
