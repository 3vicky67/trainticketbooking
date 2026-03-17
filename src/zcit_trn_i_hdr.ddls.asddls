@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Train Booking Header - Interface View'
define root view entity ZCIT_TRN_I_HDR
  as select from zcit_trn_hdr
  composition [0..*] of ZCIT_TRN_I_ITM as _Passengers
{
  key booking_uuid    as BookingUuid,
      booking_id      as BookingId,
      train_number    as TrainNumber,
      travel_date     as TravelDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_amount    as TotalAmount,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      case booking_status
        when 'BOOKED'     then 3
        when 'UNRESERVED' then 1
        when 'RESERVED'   then 2
        else 0
      end             as BookingStatusCriticality,
      from_location   as FromLocation,
      to_location     as ToLocation,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      _Passengers
}
