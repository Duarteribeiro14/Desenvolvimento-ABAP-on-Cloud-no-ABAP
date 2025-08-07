CLASS zcl_fabap_jul2025_exer01_dmr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  METHODS constructor
      IMPORTING
        i_CProduto       TYPE string DEFAULT 'a'
        i_NProduto    TYPE string DEFAULT 'a'
        i_Preco      TYPE decfloat16 DEFAULT '0'.

   METHODS Adiciona_Estoque
    IMPORTING i_QEstoque TYPE i
    EXPORTING e_QEstoque TYPE i.

  METHODS Remove_Estoque
    IMPORTING i_QEstoque TYPE i
    EXPORTING e_QEstoque TYPE i
    EXCEPTIONS ex_QEstoque_error.

  METHODS Calcula_valor_Estoque
  RETURNING VALUE(r_VPEsoque) TYPE decfloat16.

  METHODS GET_CProduto
      RETURNING VALUE(r_CProduto) TYPE string.


    METHODS GET_NProduto
      RETURNING VALUE(r_NProduto) TYPE string.

    METHODS GET_Preco
      RETURNING VALUE(r_Preco) TYPE decfloat16.

    METHODS GET_QEstoque
      RETURNING VALUE(r_QEstoque) TYPE i.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA gv_CProduto TYPE string.
    DATA gv_NProduto TYPE string.
    DATA gv_Preco    TYPE decfloat16.
    DATA gv_QEstoque TYPE i.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER01_DMR IMPLEMENTATION.


METHOD adiciona_estoque.

    gv_qestoque = gv_qestoque + i_QEstoque.
    IF e_QEstoque IS SUPPLIED.
        e_QEstoque = gv_QEstoque.
      ENDIF.
ENDMETHOD.


METHOD calcula_valor_estoque.

   r_VPEsoque  = gv_preco * gv_qestoque.

ENDMETHOD.


METHOD constructor.
    gv_CProduto = i_CProduto.
    gv_NProduto = i_NProduto.
    gv_Preco = i_Preco.
    gv_qestoque = 0.
ENDMETHOD.


    METHOD GET_CProduto.
        r_CProduto = gv_cproduto.
    ENDMETHOD.


    METHOD GET_NProduto.
        r_NProduto = gv_nproduto.
    ENDMETHOD.


    METHOD GET_Preco.
        r_Preco = gv_preco.
    ENDMETHOD.


    METHOD GET_QEstoque.
        r_QEstoque = gv_qestoque.
    ENDMETHOD.


METHOD if_oo_adt_classrun~main.

    DATA o_conta1 TYPE REF TO zcl_fabap_jul2025_exer01_dmr.
    DATA t_conta TYPE STANDARD TABLE OF REF TO zcl_fabap_jul2025_exer01_dmr.

    o_conta1 = NEW #( i_CProduto = '54924'
            i_NProduto = 'embraiagem'
            i_Preco   = '800').


     CALL METHOD o_conta1->adiciona_estoque

        EXPORTING
           i_QEstoque = '130'.
     out->write( 'Estoque adicionado: ' ).
    out->write( o_conta1->gv_qestoque ).

    CALL METHOD o_conta1->remove_estoque
        EXPORTING
           i_QEstoque = '1'
        EXCEPTIONS
            ex_QEstoque_error = 1
            OTHERS = 2.
    out->write( 'Estoque Removido' ).
    out->write( o_conta1->gv_qestoque ).


    out->write( 'Valor do estoque calculado' ).
    out->write( o_conta1->calcula_valor_estoque(  ) ).

     out->write( 'Valor dos Geters' ).
     out->write( o_conta1->get_cproduto( ) ).

     out->write( o_conta1->gv_nproduto ).

     out->write( o_conta1->get_preco( ) ).

     out->write( o_conta1->get_qestoque(  ) ).

    APPEND o_conta1 TO t_conta.


ENDMETHOD.


METHOD Remove_estoque.

    IF  gv_qestoque >= i_qestoque.
    gv_qestoque -= i_QEstoque.
    IF e_QEstoque IS SUPPLIED.
        e_QEstoque = gv_QEstoque.
      ENDIF.
    ELSE.
        MESSAGE s001(zfabap_jul2025_dmr)  DISPLAY LIKE 'E' RAISING ex_QEstoque_error.
    ENDIF.
ENDMETHOD.
ENDCLASS.
