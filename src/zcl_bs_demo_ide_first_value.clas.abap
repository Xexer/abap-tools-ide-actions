CLASS zcl_bs_demo_ide_first_value DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_sd_value_help_dsni.

  PRIVATE SECTION.
    TYPES items TYPE STANDARD TABLE OF if_sd_value_help_dsni=>ty_named_item WITH EMPTY KEY.

    METHODS get_methods
      IMPORTING !input        TYPE zcl_bs_demo_ide_first_input=>input
      RETURNING VALUE(result) TYPE items.

    METHODS get_parameters
      IMPORTING !input        TYPE zcl_bs_demo_ide_first_input=>input
      RETURNING VALUE(result) TYPE items.
ENDCLASS.


CLASS zcl_bs_demo_ide_first_value IMPLEMENTATION.
  METHOD if_sd_value_help_dsni~get_value_help_items.
    DATA input TYPE zcl_bs_demo_ide_first_input=>input.
    DATA items TYPE items.

    model->get_as_structure( IMPORTING result = input ).

    CASE value_help_id.
      WHEN 'VH_METHOD'.
        items = get_methods( input ).
      WHEN 'VH_PARAMETER'.
        items = get_parameters( input ).
    ENDCASE.

    result = VALUE #( items            = items
                      total_item_count = lines( items ) ).
  ENDMETHOD.


  METHOD get_methods.
    IF input-vh_class IS INITIAL.
      RETURN.
    ENDIF.

    DATA(class) = xco_cp_abap=>class( CONV #( input-vh_class ) ).

    DATA(public_methods) = class->definition->section-public->components->method->all->get( ).
    LOOP AT public_methods INTO DATA(method).
      INSERT VALUE #( ) INTO TABLE result REFERENCE INTO DATA(result_entry).
      result_entry->name        = method->name.
      result_entry->description = method->content( )->get( )-short_description.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_parameters.
    IF input-vh_class IS INITIAL OR input-vh_method IS INITIAL.
      RETURN.
    ENDIF.

    DATA(class) = xco_cp_abap=>class( CONV #( input-vh_class ) ).

    DATA(method) = class->definition->section-public->component->method( CONV #( input-vh_method ) ).
    LOOP AT method->importing_parameters->all->get( ) INTO DATA(importing).
      INSERT VALUE #( ) INTO TABLE result REFERENCE INTO DATA(result_entry).
      result_entry->name        = importing->name.
      result_entry->description = importing->content( )->get( )-typing_definition->get_value( ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
