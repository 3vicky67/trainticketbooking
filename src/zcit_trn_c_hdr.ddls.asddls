@EndUserText.label: 'Train Booking - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZCIT_TRN_C_HDR
  provider contract transactional_query
  as projection on ZCIT_TRN_I_HDR
{
  key BookingUuid,
      BookingId,
      TrainNumber,
      FromLocation,
      ToLocation,
      TravelDate,
      TotalAmount,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency' } }]
      CurrencyCode,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZCIT_TRN_VH_STATUS', element: 'StatusCode' } }]
      BookingStatus,
      BookingStatusCriticality,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      _Passengers : redirected to composition child ZCIT_TRN_C_ITM
}
