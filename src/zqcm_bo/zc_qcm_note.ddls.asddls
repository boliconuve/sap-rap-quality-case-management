@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Quality Cases Notes'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_QCM_NOTE 
  as projection on ZI_QCM_NOTE
{
    key NoteId,
        CaseId,
        TypeCode,
        Text,
        InternalFlag,
        CreatedBy,
        CreatedAt,
        LocalLastChangedBy,
        LocalLastChangedAt,
        LastChangedAt,
        
        _Case: redirected to parent ZC_QCM_CASE
}
