@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quality case category interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_QCM_CATEGORY as select from zqcm_category
{
    key category_id             as CategoryId,
        category_name           as CategoryName,
        description             as Description,
        default_priority_code   as DefaultPriorityCode,
        active_flag             as ActiveFlag,
        sort_order              as SortOrder
}
