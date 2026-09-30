CLASS lhc_QualityCase DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.
     DATA lv_error_message TYPE STRING.

  PRIVATE SECTION.

    METHODS validateDates FOR VALIDATE ON SAVE
       IMPORTING keys FOR QualityCase~validateDates.
    METHODS validateCategory FOR VALIDATE ON SAVE
      keys FOR QualityCase~validateCategory.

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

  METHOD validateCategory.

    READ ENTITIES OF zi_qcm_case IN LOCAL MODE
        ENTITY QualityCase
        FIELDS ( CategoryId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_categories).


    LOOP AT lt_categories INTO DATA(ls_categories).

        CLEAR lv_error_message.

        APPEND VALUE #(
            %tky        = ls_categories-%tky
            %state_area = 'VALIDATE_CATEGORY'
        ) TO reported-qualitycase.

        IF ls_categories-CategoryId IS INITIAL.
            lv_error_message = 'Es necesario una Categoría.'.
        ELSE.

            SELECT SINGLE
                     FROM zi_qcm_category
                   FIELDS ActiveFlag
                    WHERE CategoryId EQ @ls_categories-CategoryId
                     INTO @DATA(lv_active_cat).

            IF sy-subrc IS NOT INITIAL.
                lv_error_message = 'Categoría no existe.'.
            ELSEIF lv_active_cat <> 'X'.
                lv_error_message = 'Categoría está inactiva'.
            ENDIF.

        ENDIF.

        IF lv_error_message IS NOT INITIAL.

            APPEND VALUE #(
                    %tky = ls_categories-%tky
                ) TO failed-qualitycase.

                APPEND VALUE #(
                    %tky        = ls_categories-%tky
                    %state_area = 'VALIDATE_CATEGORY'
                    %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = lv_error_message
                                    )
                    %element-CategoryId = if_abap_behv=>mk-on
                ) TO reported-qualitycase.
        ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
