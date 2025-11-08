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
        "! <p class="shorttext">VH: Class</p>
        vh_class      TYPE string,
        "! <p class="shorttext">VH: Method</p>
        vh_method     TYPE string,
        "! <p class="shorttext">VH: Parameter</p>
        vh_parameter  TYPE string,
      END OF input.
ENDCLASS.


CLASS zcl_bs_demo_ide_first_input IMPLEMENTATION.
  METHOD if_aia_sd_action_input~create_input_config.
    DATA input TYPE input.

    DATA(configuration) = ui_information_factory->get_configuration_factory( )->create_for_data( input ).

    configuration->get_element( `vh_class` )->set_types( VALUE #( ( `CLAS/OC` ) ) ).
    configuration->get_element( 'vh_method' )->set_values( if_sd_config_element=>values_kind-domain_specific_named_items ).
    configuration->get_element( 'vh_parameter' )->set_values( if_sd_config_element=>values_kind-domain_specific_named_items ).

    RETURN ui_information_factory->for_abap_type( abap_type     = input
                                                  configuration = configuration ).
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_value_help_provider.
    result = cl_sd_value_help_provider=>create( NEW zcl_bs_demo_ide_first_value( ) ).
  ENDMETHOD.
ENDCLASS.
