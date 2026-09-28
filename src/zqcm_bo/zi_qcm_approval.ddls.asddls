@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quality case approvals interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_QCM_APPROVAL 
      as select from zqcm_approval
      association to parent ZI_QCM_CASE as _Case on $projection.CaseId = _Case.CaseId
{
    key approval_uuid           as ApprovalId,
        case_uuid               as CaseId,
        approval_step           as ApprovalStep,
        decision_code           as DecisionCode,
        approver_id             as ApproverId,
        requested_by            as RequestedBy,
        requested_at            as RequestedAt,
        decided_at              as DecidedAt,
        decision_reason         as DecisionReason,
        @Semantics.user.createdBy: true
        created_by              as CreatedBy,
        
        @Semantics.systemDateTime.createdAt: true
        created_at              as CreatedAt,
        
        @Semantics.user.localInstanceLastChangedBy: true
        local_last_changed_by   as LocalLastChangedBy,
        
        @Semantics.systemDateTime.localInstanceLastChangedAt: true
        local_last_changed_at   as LocalLastChangedAt,
        
        @Semantics.systemDateTime.lastChangedAt: true
        last_changed_at         as LastChangedAt,
        // Case Association
        _Case
}
