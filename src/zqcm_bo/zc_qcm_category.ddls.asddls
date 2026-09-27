@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Read only view for QCM Categories'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_QCM_CATEGORY as select from ZI_QCM_CATEGORY
{
    
    key CategoryId,
        CategoryName,
        Description,
        DefaultPriorityCode,
        ActiveFlag,
        SortOrder
}
