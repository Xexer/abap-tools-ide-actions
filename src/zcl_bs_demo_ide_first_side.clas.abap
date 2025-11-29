CLASS zcl_bs_demo_ide_first_side DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_sd_determination.
ENDCLASS.


CLASS zcl_bs_demo_ide_first_side IMPLEMENTATION.
  METHOD if_sd_determination~run.
    DATA input TYPE zcl_bs_demo_ide_first_input=>input.

    model->get_as_structure( IMPORTING result = input ).

    CASE determination_kind.
      WHEN if_sd_determination=>kind-after_update.
        input-se_output = |{ input-output_format }: { strlen( input-se_input ) }|.

      WHEN if_sd_determination=>kind-after_create.
        DATA(actual_index) = lines( input-table_input ).
        LOOP AT input-table_input REFERENCE INTO DATA(line).
          line->int_number = actual_index.
          actual_index -= 1.
        ENDLOOP.

    ENDCASE.

    result = input.
  ENDMETHOD.
ENDCLASS.
