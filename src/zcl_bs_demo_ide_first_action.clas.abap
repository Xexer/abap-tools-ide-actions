CLASS zcl_bs_demo_ide_first_action DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_aia_action.

  PRIVATE SECTION.
    CLASS-METHODS output_text
      RETURNING VALUE(result) TYPE REF TO if_aia_action_result.

    METHODS output_html
      RETURNING VALUE(result) TYPE REF TO if_aia_action_result.

    METHODS output_code_change
      IMPORTING !context      TYPE REF TO if_aia_action_context
      RETURNING VALUE(result) TYPE REF TO if_aia_action_result.

    METHODS demo_method_with_code.
ENDCLASS.


CLASS zcl_bs_demo_ide_first_action IMPLEMENTATION.
  METHOD if_aia_action~run.
    DATA input TYPE zcl_bs_demo_ide_first_input=>input.

    TRY.
        context->get_input_config_content( )->get_as_structure( IMPORTING result = input ).
      CATCH cx_sd_invalid_data.
    ENDTRY.

    CASE input-output_format.
      WHEN zcl_bs_demo_ide_first_input=>output_enum-text.
        result = output_text( ).

      WHEN zcl_bs_demo_ide_first_input=>output_enum-html.
        result = output_html( ).

      WHEN zcl_bs_demo_ide_first_input=>output_enum-code.
        result = output_code_change( context ).
    ENDCASE.
  ENDMETHOD.


  METHOD output_text.
    DATA(text) = cl_aia_result_factory=>create_text_popup_result( ).
    text->set_content( `Here is my text output ...` ).

    result = text.
  ENDMETHOD.


  METHOD output_html.
    DATA(html_document) = `<html><head></head><body><h1 style="color:blue;">Big Heading</h1><p>A text in a paragraph</p><body></html>`.

    DATA(html) = cl_aia_result_factory=>create_html_popup_result( ).
    html->set_content( html_document ).

    result = html.
  ENDMETHOD.


  METHOD output_code_change.
    DATA(resource) = CAST if_adt_context_src_based_obj( context->get_focused_resource( ) ).
    DATA(position) = resource->get_position( ).

    DATA(change) = cl_aia_result_factory=>create_source_change_result( ).

*    change->add_code_insertion_delta( content         = `" [INSERT]`
*                                      cursor_position = position ).

*    change->add_code_removal_delta( selection_position = position ).

    change->add_code_replacement_delta( content            = `" [REPLACE]`
                                        selection_position = position ).

    result = change.
  ENDMETHOD.


  METHOD demo_method_with_code.
    " Dummy comment
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(dummy) = `Some Dummy Code`.
  ENDMETHOD.
ENDCLASS.
