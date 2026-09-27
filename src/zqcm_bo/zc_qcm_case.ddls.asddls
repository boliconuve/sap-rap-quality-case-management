@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Quality Cases'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_QCM_CASE 
       as projection on ZI_QCM_CASE
       association [0..1] to ZC_QCM_CATEGORY as _Category on $projection.CategoryId = _Category.CategoryId
{
    key CaseId,
        CaseNumber,
        Title,
        Description,
        CategoryId,
        PriorityCode,
        StatusCode,
        PlantId,
        ReporterId,
        InvestigatorId,
        OccurrenceDate,
        DueDate,
        Resolution,
        CreatedBy,
        CreatedAt,
        LocalLastChangedBy,
        LocalLastChangedAt,
        LastChangedAt,
        
        _Notes:     redirected to composition child ZC_QCM_NOTE,
        _Approvals: redirected to composition child ZC_QCM_APPROVAL,
        _History:   redirected to composition child ZC_QCM_HISTORY,
        _Category

}
