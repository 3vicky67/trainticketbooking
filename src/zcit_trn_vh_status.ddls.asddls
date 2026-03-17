@EndUserText.label: 'Value Help for Booking Status'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.resultSet.sizeCategory: #XS
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZCIT_TRN_VH_STATUS
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'Z_BKG_STATUS_DOM' )
{
  key value_low as StatusCode,
      text      as StatusText
}
where language = $session.system_language
