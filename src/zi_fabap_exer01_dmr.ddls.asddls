@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS 1 emnerson'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_EXER01_DMR
  as select from /dmo/flight  as Flight
    inner join   /dmo/carrier as Carrier on Carrier.carrier_id = Flight.carrier_id
{
  key Flight.carrier_id                     as CarrierId,
  key Flight.connection_id                  as ConnectionId,
  key Flight.flight_date                    as FlightDate,
      Flight.seats_max                      as SeatsMax,
      Flight.seats_occupied                 as SeatsOccupied,
      Carrier.name                          as Name,
      concat( cast (
              cast( (Flight.seats_occupied / Flight.seats_max) *100 as abap.dec( 8,2 ) )
              as abap.char( 20 ) ) , ' %' ) as OccupiedPercentage
}
