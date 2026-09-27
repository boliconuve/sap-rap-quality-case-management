@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quality case interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_QCM_CASE 
      as select from zqcm_case
      composition [0..*] of ZI_QCM_NOTE     as _Notes
      composition [0..*] of ZI_QCM_APPROVAL as _Approvals
      composition [0..*] of ZI_QCM_HISTORY  as _History
      association [0..1] to ZI_QCM_CATEGORY as _Category on $projection.CategoryId = _Category.CategoryId
{
    key case_uuid               as CaseId,
        case_number             as CaseNumber,
        title                   as Title,
        description             as Description,
        category_id             as CategoryId,
        priority_code           as PriorityCode,
        status_code             as StatusCode,
        plant_id                as PlantId,
        reporter_id             as ReporterId,
        investigator_id         as InvestigatorId,
        occurrence_date         as OccurrenceDate,
        due_date                as DueDate,
        resolution              as Resolution,
        created_by              as CreatedBy,
        created_at              as CreatedAt,
        local_last_changed_by   as LocalLastChangedBy,
        local_last_changed_at   as LocalLastChangedAt,
        last_changed_at         as LastChangedAt,
        
        // Navigations
        _Notes,
        _Approvals,
        _History,
        _Category
}
