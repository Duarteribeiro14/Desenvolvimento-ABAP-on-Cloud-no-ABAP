CLASS zcl_fabap_jul2025_exer13_DMR DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_fabap_jul2025_exer13_DMR IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(lv_airline_id) = 'AA'.
    out->write( |Updated Version - Airline ID: { lv_airline_id }| ).

    TYPES: BEGIN OF ty_flight_info,
             airline_id    TYPE /dmo/carrier_id,
             route_id      TYPE /dmo/connection_id,
             departure_date TYPE /dmo/flight_date,
           END OF ty_flight_info.
    DATA: lt_flight_data TYPE STANDARD TABLE OF ty_flight_info WITH EMPTY KEY.
    lt_flight_data = VALUE #( ( airline_id = 'LH' route_id = '0400' departure_date = '20250725' ) ).
    LOOP AT lt_flight_data INTO DATA(ls_flight_data).
      out->write( |Updated Version - Flight: { ls_flight_data-airline_id }-{ ls_flight_data-route_id }| ).
    ENDLOOP.

    SELECT * FROM /dmo/flight INTO TABLE @DATA(lt_selected_flights) UP TO 2 ROWS.
    out->write( |Updated Version - Flights found (SELECT): { lines( lt_selected_flights ) }| ).

    TRY.
        DATA(ls_first_flight) = lt_flight_data[ 1 ].
        out->write( |Updated Version - First Flight: { ls_first_flight-airline_id }-{ ls_first_flight-route_id }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |Updated Version - No first flight found.| ).
    ENDTRY.

    TRY.
        DATA(ls_specific_flight) = lt_flight_data[ airline_id = 'LH' route_id = '0400' ].
        out->write( |Updated Version - Flight LH-0400: { ls_specific_flight-airline_id }-{ ls_specific_flight-route_id }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |Updated Version - Flight LH-0400 not found.| ).
    ENDTRY.

    DATA(lv_char_value) = '12345'.
    DATA(lv_integer_value) = CONV i( lv_char_value ).
    out->write( |Updated Version - Converted to INT: { lv_integer_value }| ).

    TYPES tt_flight_data TYPE STANDARD TABLE OF ty_flight_info WITH EMPTY KEY.

    DATA(ls_route_info) = VALUE /dmo/connection(
      airport_from_id = 'FRA'
      airport_to_id   = 'JFK'
    ).

    out->write( |Updated Version - Route: { ls_route_info-airport_from_id }-{ ls_route_info-airport_to_id }| ).

    DATA(lt_flight_values) = VALUE tt_flight_data(
      ( airline_id = 'UA' route_id = '0001' departure_date = '20250725' )
      ( airline_id = 'DL' route_id = '0002' departure_date = '20250726' )
    ).

    out->write( |Updated Version - Flights count (VALUE): { lines( lt_flight_values ) }| ).

    DATA(lt_filtered_flights_ua) =
     VALUE tt_flight_data( FOR ls_flight IN lt_flight_values WHERE ( airline_id = 'UA' )
                         ( airline_id = ls_flight-airline_id route_id = ls_flight-route_id ) ).

    out->write( |Updated Version - Flights for UA (FOR): { lines( lt_filtered_flights_ua ) }| ).

    TYPES tt_numbers TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    DATA(lt_numbers) = VALUE tt_numbers( ( 1 ) ( 2 ) ( 3 ) ).

    DATA(lv_total_sum) = REDUCE i( INIT lv_sum = 0 FOR lv_num IN lt_numbers NEXT lv_sum = lv_sum + lv_num ).

    out->write( |Updated Version - Sum: { lv_total_sum }| ).

    DATA(lv_status_code) = 1.
    DATA(lv_status_text) = COND string(
      WHEN lv_status_code = 1 THEN 'Success'
      WHEN lv_status_code = 2 THEN 'Warning'
      ELSE 'Error'
    ).
    out->write( |Updated Version - Status (COND): { lv_status_text }| ).

    DATA(lv_switch_code) = 2.
    DATA(lv_switch_status) = SWITCH string( lv_switch_code
      WHEN 1 THEN 'Success'
      WHEN 2 THEN 'Warning'
      ELSE 'Error'
    ).
    out->write( |Updated Version - Status (SWITCH): { lv_switch_status }| ).

    TYPES: BEGIN OF ty_struct1,
             field_a TYPE string,
             field_b TYPE string,
           END OF ty_struct1.

    TYPES: BEGIN OF ty_struct2,
             field_a TYPE string,
             field_c TYPE string,
           END OF ty_struct2.

    DATA: ls_struct1 TYPE ty_struct1.

    ls_struct1-field_a = 'Value1'.
    ls_struct1-field_b = 'Value2'.

    DATA(ls_struct2) = CORRESPONDING ty_struct2( ls_struct1 ).

    out->write( |Updated Version - Struct2 Field1 (CORRESPONDING): { ls_struct2-field_a }| ).

    DATA(lv_greeting) = 'Hello'.
    DATA(lv_target) = 'World'.
    DATA(lv_combined_string) = lv_greeting && ' ' && lv_target.
    out->write( |Updated Version - Chaining Operator (Strings): { lv_combined_string }| ).

    DATA(lv_language) = 'ABAP'.
    DATA(lv_version) = '7.40'.
    DATA(lv_welcome_message) = |Welcome to { lv_language } { lv_version }!|.
    out->write( |Updated Version - String Template (Strings): { lv_welcome_message }| ).

    DATA(lv_delivery_num) = '0080003371'.
    DATA(lv_formatted_delivery_num) = |{ lv_delivery_num ALPHA = OUT }|.
    out->write( |Updated Version - Embedded Expression (ALPHA) (Strings): { lv_formatted_delivery_num }| ).

    TYPES: BEGIN OF ty_flight_group_info,
             airline_id    TYPE /dmo/carrier_id,
             route_id      TYPE /dmo/connection_id,
             ticket_price  TYPE /dmo/flight_price,
           END OF ty_flight_group_info.

    DATA: lt_flight_groups TYPE STANDARD TABLE OF ty_flight_group_info WITH EMPTY KEY.

    lt_flight_groups = VALUE #( ( airline_id = 'LH' route_id = '0400' ticket_price = '100' )
                               ( airline_id = 'LH' route_id = '0401' ticket_price = '150' )
                               ( airline_id = 'UA' route_id = '0001' ticket_price = '200' ) ).

    LOOP AT lt_flight_groups INTO DATA(ls_flight_group) GROUP BY ls_flight_group-airline_id.
      DATA(lv_total_price) = REDUCE /dmo/flight_price( INIT lv_sum = 0 FOR member IN GROUP ls_flight_group NEXT lv_sum = lv_sum + member-ticket_price ).
      out->write( |Updated Version - Airline { ls_flight_group-airline_id } Total Price (Group By): { lv_total_price }| ).
    ENDLOOP.

    DATA lt_sorted_flights TYPE SORTED TABLE OF ty_flight_info WITH UNIQUE KEY airline_id route_id.

    " Preenchendo a tabela lt_sorted_flights com dados
    lt_sorted_flights = VALUE #( ( airline_id = 'AA ' route_id = '0003' departure_date = '20250727' )
                                 ( airline_id = 'AA ' route_id = '0004' departure_date = '20250728' )
                                 ( airline_id = 'LH ' route_id = '0402' departure_date = '20250729' ) ).

    DATA(lt_filtered_flights_aa) = FILTER #( lt_sorted_flights WHERE airline_id = 'AA ' ).

    out->write( |Updated Version - Filtered flights (AA): { lines( lt_filtered_flights_aa ) }| ).

  ENDMETHOD.
ENDCLASS.

