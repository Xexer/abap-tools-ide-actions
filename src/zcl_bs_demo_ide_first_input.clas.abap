CLASS zcl_bs_demo_ide_first_input DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_aia_sd_action_input.

    CONSTANTS:
      BEGIN OF output_enum,
        "! <p class="shorttext">Plain text</p>
        text TYPE string VALUE 'TEXT',
        "! <p class="shorttext">HTML</p>
        html TYPE string VALUE 'HTML',
        "! <p class="shorttext">Code Change</p>
        code TYPE string VALUE 'CODE',
      END OF output_enum.

    "! $values { @link zcl_bs_demo_ide_first_input.data:output_enum }
    "! $default { @link zcl_bs_demo_ide_first_input.data:output_enum.text }
    TYPES output_format TYPE string.

    TYPES:
      "! <p class="shorttext">Out first action</p>
      BEGIN OF input,
        "! <p class="shorttext">Choose an output</p>
        output_format TYPE output_format,
      END OF input.
ENDCLASS.


CLASS zcl_bs_demo_ide_first_input IMPLEMENTATION.
  METHOD if_aia_sd_action_input~create_input_config.
    DATA input TYPE input.

    input-output_format = 'TEST'.

    RETURN ui_information_factory->for_abap_type( abap_type = input ).
  ENDMETHOD.
ENDCLASS.
