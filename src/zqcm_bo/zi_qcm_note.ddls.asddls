@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quality case note interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_QCM_NOTE 
        as select from zqcm_note    
        association to parent ZI_QCM_CASE as _Case on $projection.CaseId = _Case.CaseId 
{
    key note_uuid               as NoteId,
        case_uuid               as CaseId,
        note_type_code          as TypeCode,
        note_text               as Text,
        internal_flag           as InternalFlag,
        created_by              as CreatedBy,
        created_at              as CreatedAt,
        local_last_changed_by   as LocalLastChangedBy,
        local_last_changed_at   as LocalLastChangedAt,
        last_changed_at         as LastChangedAt,
        
        // Case Association
        _Case
}
