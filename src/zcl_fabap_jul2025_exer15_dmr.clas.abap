CLASS zcl_fabap_jul2025_exer15_dmr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_fabap_jul2025_exer15_dmr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Definição do tipo para armazenar dados do voo
    TYPES: BEGIN OF ty_voo_detalhes,
             carrier_id    TYPE /dmo/carrier_id,
             connection_id TYPE /dmo/connection_id,
             price         TYPE /dmo/flight_price,
             distance      TYPE /dmo/flight_distance,
           END OF ty_voo_detalhes.

    " Declaração da tabela interna ordenada
    DATA lt_voo_detalhes TYPE SORTED TABLE OF ty_voo_detalhes
      WITH NON-UNIQUE KEY carrier_id connection_id.

    " Seleção dos dados com JOIN e filtros
    SELECT a~carrier_id,
           a~connection_id,
           a~price,
           b~distance
      FROM /dmo/flight AS a
      INNER JOIN /dmo/connection AS b
        ON a~carrier_id = b~carrier_id
       AND a~connection_id = b~connection_id
      WHERE b~distance > 1000
        AND a~carrier_id = 'UA'
        AND a~connection_id IN ('0058', '0059', '1537')
      INTO TABLE @lt_voo_detalhes.

    " Atualização dos preços e escrita no output
    LOOP AT lt_voo_detalhes ASSIGNING FIELD-SYMBOL(<voo_info>).
      <voo_info>-price = <voo_info>-price * '1.10'.
      out->write( |Preço atualizado para voo { <voo_info>-carrier_id }-{ <voo_info>-connection_id }| ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

