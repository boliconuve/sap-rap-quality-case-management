CLASS lhc_QualityCase DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateDates FOR VALIDATE ON SAVE
       IMPORTING keys FOR QualityCase~validateDates.

ENDCLASS.

CLASS lhc_QualityCase IMPLEMENTATION.

  METHOD validateDates.
    READ ENTITIES OF zi_qcm_case IN LOCAL MODE
        ENTITY QualityCase
        FIELDS ( OccurrenceDate DueDate )
          WITH CORRESPONDING #(  keys )
        RESULT DATA(lt_cases).

    LOOP AT lt_cases INTO DATA(ls_case).

        APPEND VALUE #(
            %tky        = ls_case-%tky
            %state_area = 'VALIDATE_DATES'
        ) TO reported-qualitycase.

        IF ls_case-OccurrenceDate IS NOT INITIAL AND ls_case-DueDate IS NOT INITIAL AND ls_case-DueDate < ls_case-OccurrenceDate.

            APPEND VALUE #(
                %tky = ls_case-%tky
            ) TO failed-qualitycase.

            APPEND VALUE #(
                %tky        = ls_case-%tky
                %state_area = 'VALIDATE_DATES'
                %msg        = new_message_with_text(
                                    severity = if_abap_behv_message=>severity-error
                                    text     = 'La fecha límite no puede ser anterior a la fecha de ocurrencia.'
                                )
                %element-DueDate = if_abap_behv=>mk-on
            ) TO reported-qualitycase.

        ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
