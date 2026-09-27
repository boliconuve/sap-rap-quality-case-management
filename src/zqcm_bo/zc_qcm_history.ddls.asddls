@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Quality Cases History'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_QCM_HISTORY as projection on ZI_QCM_HISTORY
{
    key HistoryId,
        CaseId,
        EventCode,
        PreviousStatusCode,
        NewStatusCode,
        ActorId,
        EventText,
        CreatedBy,
        CreatedAt,
        
        _Case: redirected to parent ZC_QCM_CASE
}
