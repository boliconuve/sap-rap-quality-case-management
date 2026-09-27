@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quality case history interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_QCM_HISTORY 
        as select from zqcm_history
        association to parent ZI_QCM_CASE as _Case on $projection.CaseId = _Case.CaseId
{
    key history_uuid            as HistoryId,
        case_uuid               as CaseId,
        event_code              as EventCode,
        previous_status_code    as PreviousStatusCode,
        new_status_code         as NewStatusCode,
        actor_id                as ActorId,
        event_text              as EventText,
        created_by              as CreatedBy,
        created_at              as CreatedAt,
        
        // CASE ASSOCIATION
        _Case
}
