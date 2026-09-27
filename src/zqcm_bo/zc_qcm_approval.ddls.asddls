@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Quality Cases Approval'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_QCM_APPROVAL as projection on ZI_QCM_APPROVAL
{
    key ApprovalId,
        CaseId,
        ApprovalStep,
        DecisionCode,
        ApproverId,
        RequestedBy,
        RequestedAt,
        DecidedAt,
        DecisionReason,
        CreatedBy,
        CreatedAt,
        LocalLastChangedBy,
        LocalLastChangedAt,
        LastChangedAt,
        
        _Case: redirected to parent ZC_QCM_CASE
}
