CLASS lhc_Passenger DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS calculateTotal FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Passenger~calculateTotal.
ENDCLASS.

CLASS lhc_Passenger IMPLEMENTATION.
  METHOD calculateTotal.

    " ═════════════════════════════════════════════════════════════════════
    " 1. READ PASSENGERS FIRST TO FIND THEIR PARENT BOOKING UUID
    " ═════════════════════════════════════════════════════════════════════
    READ ENTITIES OF zcit_trn_i_hdr IN LOCAL MODE
      ENTITY Passenger
      FIELDS ( BookingUuid )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_modified_passengers).

    " ═════════════════════════════════════════════════════════════════════
    " 2. COLLECT UNIQUE BOOKING UUIDS (In case multiple passengers changed)
    " ═════════════════════════════════════════════════════════════════════
    DATA lt_booking_keys TYPE TABLE FOR READ IMPORT zcit_trn_i_hdr.

    LOOP AT lt_modified_passengers INTO DATA(ls_mod_pass).
      APPEND VALUE #( %tky-BookingUuid = ls_mod_pass-BookingUuid
                      %tky-%is_draft   = ls_mod_pass-%is_draft ) TO lt_booking_keys.
    ENDLOOP.

    SORT lt_booking_keys BY %tky.
    DELETE ADJACENT DUPLICATES FROM lt_booking_keys COMPARING %tky.

    " ═════════════════════════════════════════════════════════════════════
    " 3. CALCULATE THE NEW TOTAL FOR EACH BOOKING
    " ═════════════════════════════════════════════════════════════════════
    LOOP AT lt_booking_keys INTO DATA(ls_booking_key).

      " Read ALL passengers belonging to this specific booking
      READ ENTITIES OF zcit_trn_i_hdr IN LOCAL MODE
        ENTITY TrainBooking BY \_Passengers
        FIELDS ( PassengerAmount )
        WITH VALUE #( ( %tky = ls_booking_key-%tky ) )
        RESULT DATA(lt_all_passengers).

      " Variable to hold our running total
      DATA lv_total TYPE p LENGTH 15 DECIMALS 2.
      CLEAR lv_total.

      " Add up the amounts
      LOOP AT lt_all_passengers INTO DATA(ls_passenger).
        lv_total = lv_total + ls_passenger-PassengerAmount.
      ENDLOOP.

      " ═════════════════════════════════════════════════════════════════════
      " 4. WRITE THE GRAND TOTAL BACK TO THE HEADER
      " ═════════════════════════════════════════════════════════════════════
      MODIFY ENTITIES OF zcit_trn_i_hdr IN LOCAL MODE
        ENTITY TrainBooking
        UPDATE FIELDS ( TotalAmount )
        WITH VALUE #( ( %tky = ls_booking_key-%tky
                        TotalAmount = lv_total ) ).

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
