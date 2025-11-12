CLASS zcl_bs_demo_ide_first_side DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_sd_determination.
ENDCLASS.


CLASS zcl_bs_demo_ide_first_side IMPLEMENTATION.
  METHOD if_sd_determination~run.
    DATA input TYPE zcl_bs_demo_ide_first_input=>input.

    IF determination_kind <> if_sd_determination=>kind-after_update.
      RETURN.
    ENDIF.

    model->get_as_structure( IMPORTING result = input ).

    input-se_output = |{ input-output_format }: { strlen( input-se_input ) }|.
    result = input.
  ENDMETHOD.
ENDCLASS.
