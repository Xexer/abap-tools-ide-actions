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
      BEGIN OF table_line,
        "! <p class="shorttext">Key</p>
        key_field  TYPE c LENGTH 15,
        "! <p class="shorttext">Number</p>
        int_number TYPE i,
        "! <p class="shorttext">Long text</p>
        long_text  TYPE string,
      END OF table_line.
    TYPES table_body TYPE STANDARD TABLE OF table_line WITH EMPTY KEY.

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
        "! <p class="shorttext">SE: Input</p>
        se_input      TYPE string,
        "! <p class="shorttext">SE: Output</p>
        se_output     TYPE string,
        table_input   TYPE table_body,
      END OF input.
ENDCLASS.


CLASS zcl_bs_demo_ide_first_input IMPLEMENTATION.
  METHOD if_aia_sd_action_input~create_input_config.
    DATA input TYPE input.

    DATA(configuration) = ui_information_factory->get_configuration_factory( )->create_for_data( input ).
    configuration->set_layout( if_sd_config_element=>layout-grid ).

    configuration->get_element( `vh_class` )->set_types( VALUE #( ( `CLAS/OC` ) ) ).
    configuration->get_element( 'vh_method' )->set_values( if_sd_config_element=>values_kind-domain_specific_named_items ).
    configuration->get_element( 'vh_parameter' )->set_values(
        if_sd_config_element=>values_kind-domain_specific_named_items ).

    configuration->get_element( `output_format` )->set_sideeffect( after_update = abap_true ).
    configuration->get_element( `se_input` )->set_sideeffect( after_update = abap_true ).

    DATA(table) = configuration->get_structured_table( `table_input` ).
    table->set_layout( type      = if_sd_config_element=>layout-table
                       collapsed = if_sd_config_element=>true ).
    DATA(structure) = table->get_line_structure( ).
    structure->get_element( `long_text` )->set_multiline( if_sd_config_element=>height-medium ).
    structure->get_element( `int_number` )->set_read_only( ).
    structure->set_sideeffect( after_create = abap_true ).

    INSERT VALUE #( key_field = 'ABC'
                    long_text = `This is a longer text` ) INTO TABLE input-table_input.

    RETURN ui_information_factory->for_abap_type( abap_type     = input
                                                  configuration = configuration ).
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_value_help_provider.
    result = cl_sd_value_help_provider=>create( NEW zcl_bs_demo_ide_first_value( ) ).
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_side_effect_provider.
    RETURN cl_sd_sideeffect_provider=>create( determination = NEW zcl_bs_demo_ide_first_side( ) ).
  ENDMETHOD.
ENDCLASS.
