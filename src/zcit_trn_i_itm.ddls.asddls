@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Train Passenger Item - Interface View'
define view entity ZCIT_TRN_I_ITM
  as select from zcit_trn_itm
  association to parent ZCIT_TRN_I_HDR as _Booking 
    on $projection.BookingUuid = _Booking.BookingUuid
{
  key passenger_uuid as PassengerUuid,
      booking_uuid   as BookingUuid,
      passenger_name as PassengerName,
      age            as Age,
      seat_number    as SeatNumber,
      travel_class   as TravelClass,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      passenger_amount as PassengerAmount,
      currency_code    as CurrencyCode,

      /* Associations */
      _Booking // Point back to the parent
}
