@EndUserText.label: 'Train Passenger - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZCIT_TRN_C_ITM
  as projection on ZCIT_TRN_I_ITM
{
  key PassengerUuid,
      BookingUuid,
      PassengerName,
      Age,
      SeatNumber,
      TravelClass,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      PassengerAmount,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency' } }]
      CurrencyCode,

      /* Associations */
      _Booking : redirected to parent ZCIT_TRN_C_HDR
}
