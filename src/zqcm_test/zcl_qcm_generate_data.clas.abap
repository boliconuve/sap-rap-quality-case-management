CLASS zcl_qcm_generate_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_qcm_generate_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lv_timestamp TYPE timestampl.

    GET TIME STAMP FIELD lv_timestamp.

    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).
    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).
    DATA(lv_utclong) = utclong_current( ).

    TRY.

        DATA(lv_case_draft) =
          cl_system_uuid=>create_uuid_x16_static( ).

        DATA(lv_case_investigation) =
          cl_system_uuid=>create_uuid_x16_static( ).

        DATA(lv_case_approval) =
          cl_system_uuid=>create_uuid_x16_static( ).


        DATA lt_categories
          TYPE STANDARD TABLE OF zqcm_category
          WITH EMPTY KEY.

        lt_categories = VALUE #(
          (
            category_id           = 'PRODUCT'
            category_name         = 'Product Quality'
            description           = 'Quality issue affecting a product'
            default_priority_code = 'H'
            active_flag           = 'X'
            sort_order            = 10
          )
          (
            category_id           = 'DELIVERY'
            category_name         = 'Delivery Issue'
            description           = 'Incorrect, incomplete or delayed delivery'
            default_priority_code = 'M'
            active_flag           = 'X'
            sort_order            = 20
          )
          (
            category_id           = 'SERVICE'
            category_name         = 'Service Complaint'
            description           = 'Complaint related to a provided service'
            default_priority_code = 'M'
            active_flag           = 'X'
            sort_order            = 30
          )
          (
            category_id           = 'BILLING'
            category_name         = 'Billing Issue'
            description           = 'Invoice or billing discrepancy'
            default_priority_code = 'L'
            active_flag           = 'X'
            sort_order            = 40
          )
          (
            category_id           = 'OTHER'
            category_name         = 'Other'
            description           = 'Quality case without a specific category'
            default_priority_code = 'L'
            active_flag           = 'X'
            sort_order            = 50
          )
        ).


        DATA lt_cases
          TYPE STANDARD TABLE OF zqcm_case
          WITH EMPTY KEY.

        lt_cases = VALUE #(
          (
            case_uuid            = lv_case_draft
            case_number          = 'QCM-2026-000001'
            title                = 'Damaged product packaging'
            description          = 'Packaging was damaged when the product was received.'
            category_id          = 'PRODUCT'
            priority_code        = 'H'
            status_code          = 'DR'
            plant_id             = '1000'
            reporter_id          = lv_user
            occurrence_date      = lv_today - 2
            due_date             = lv_today + 7
            created_by           = lv_user
            created_at           = lv_timestamp
            local_last_changed_by = lv_user
            local_last_changed_at = lv_timestamp
            last_changed_at      = lv_timestamp
          )
          (
            case_uuid            = lv_case_investigation
            case_number          = 'QCM-2026-000002'
            title                = 'Incomplete delivery'
            description          = 'The received delivery is missing one material.'
            category_id          = 'DELIVERY'
            priority_code        = 'M'
            status_code          = 'IN'
            plant_id             = '1100'
            reporter_id          = lv_user
            investigator_id      = lv_user
            occurrence_date      = lv_today - 5
            due_date             = lv_today + 4
            created_by           = lv_user
            created_at           = lv_timestamp
            local_last_changed_by = lv_user
            local_last_changed_at = lv_timestamp
            last_changed_at      = lv_timestamp
          )
          (
            case_uuid            = lv_case_approval
            case_number          = 'QCM-2026-000003'
            title                = 'Recurring service interruption'
            description          = 'A recurring interruption requires corrective action.'
            category_id          = 'SERVICE'
            priority_code        = 'H'
            status_code          = 'PA'
            plant_id             = '1200'
            reporter_id          = lv_user
            investigator_id      = lv_user
            occurrence_date      = lv_today - 10
            due_date             = lv_today + 2
            resolution           = 'Apply the proposed corrective action.'
            created_by           = lv_user
            created_at           = lv_timestamp
            local_last_changed_by = lv_user
            local_last_changed_at = lv_timestamp
            last_changed_at      = lv_timestamp
          )
        ).


        DATA lt_notes
          TYPE STANDARD TABLE OF zqcm_note
          WITH EMPTY KEY.

        lt_notes = VALUE #(
          (
            note_uuid            =
              cl_system_uuid=>create_uuid_x16_static( )
            case_uuid            = lv_case_draft
            note_type_code       = 'GE'
            note_text            = 'Initial complaint registered.'
            internal_flag        = ''
            created_by           = lv_user
            created_at           = lv_timestamp
            local_last_changed_by = lv_user
            local_last_changed_at = lv_timestamp
            last_changed_at      = lv_timestamp
          )
          (
            note_uuid            =
              cl_system_uuid=>create_uuid_x16_static( )
            case_uuid            = lv_case_investigation
            note_type_code       = 'IN'
            note_text            = 'Warehouse verification has started.'
            internal_flag        = 'X'
            created_by           = lv_user
            created_at           = lv_timestamp
            local_last_changed_by = lv_user
            local_last_changed_at = lv_timestamp
            last_changed_at      = lv_timestamp
          )
          (
            note_uuid            =
              cl_system_uuid=>create_uuid_x16_static( )
            case_uuid            = lv_case_approval
            note_type_code       = 'RE'
            note_text            = 'Corrective action prepared for approval.'
            internal_flag        = 'X'
            created_by           = lv_user
            created_at           = lv_timestamp
            local_last_changed_by = lv_user
            local_last_changed_at = lv_timestamp
            last_changed_at      = lv_timestamp
          )
        ).


        DATA lt_approvals
          TYPE STANDARD TABLE OF zqcm_approval
          WITH EMPTY KEY.

        lt_approvals = VALUE #(
          (
            approval_uuid        =
              cl_system_uuid=>create_uuid_x16_static( )
            case_uuid            = lv_case_approval
            approval_step        = 1
            decision_code        = 'PE'
            approver_id          = lv_user
            requested_by         = lv_user
            requested_at         = lv_utclong
            created_by           = lv_user
            created_at           = lv_timestamp
            local_last_changed_by = lv_user
            local_last_changed_at = lv_timestamp
            last_changed_at      = lv_timestamp
          )
        ).


        DATA lt_history
          TYPE STANDARD TABLE OF zqcm_history
          WITH EMPTY KEY.

        lt_history = VALUE #(
          (
            history_uuid        =
              cl_system_uuid=>create_uuid_x16_static( )
            case_uuid           = lv_case_draft
            event_code          = 'CREATED'
            new_status_code     = 'DR'
            actor_id            = lv_user
            event_text          = 'Quality case created'
            created_by          = lv_user
            created_at          = lv_timestamp
          )
          (
            history_uuid        =
              cl_system_uuid=>create_uuid_x16_static( )
            case_uuid           = lv_case_investigation
            event_code          = 'STARTED'
            previous_status_code = 'SU'
            new_status_code     = 'IN'
            actor_id            = lv_user
            event_text          = 'Investigation started'
            created_by          = lv_user
            created_at          = lv_timestamp
          )
          (
            history_uuid        =
              cl_system_uuid=>create_uuid_x16_static( )
            case_uuid           = lv_case_approval
            event_code          = 'REQUESTED'
            previous_status_code = 'IN'
            new_status_code     = 'PA'
            actor_id            = lv_user
            event_text          = 'Approval requested'
            created_by          = lv_user
            created_at          = lv_timestamp
          )
        ).


        DELETE FROM zqcm_history.
        DELETE FROM zqcm_approval.
        DELETE FROM zqcm_note.
        DELETE FROM zqcm_case.
        DELETE FROM zqcm_category.

        INSERT zqcm_category FROM TABLE @lt_categories.
        INSERT zqcm_case FROM TABLE @lt_cases.
        INSERT zqcm_note FROM TABLE @lt_notes.
        INSERT zqcm_approval FROM TABLE @lt_approvals.
        INSERT zqcm_history FROM TABLE @lt_history.

        out->write( 'QCM demo data generated successfully.' ).
        out->write( |Categories: { lines( lt_categories ) }| ).
        out->write( |Cases: { lines( lt_cases ) }| ).
        out->write( |Notes: { lines( lt_notes ) }| ).
        out->write( |Approvals: { lines( lt_approvals ) }| ).
        out->write( |History entries: { lines( lt_history ) }| ).

      CATCH cx_uuid_error INTO DATA(lx_uuid).
        out->write(
          |Error generating UUIDs: { lx_uuid->get_text( ) }|
        ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
