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
*    result = output_text( ).
*    result = output_html( ).
    result = output_code_change( context ).
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
    DATA(dummy) = `Some Dummy Code`.
  ENDMETHOD.
ENDCLASS.
