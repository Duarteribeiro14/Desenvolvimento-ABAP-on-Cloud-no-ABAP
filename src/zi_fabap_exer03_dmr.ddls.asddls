@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS 3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_EXER03_DMR
  as select from /dmo/customer as Customer

{
  key Customer.customer_id                                                                                                         as CustomerId,
      Customer.first_name                                                                                                          as CustomerFirstName,
      Customer.last_name                                                                                                           as CustomerLastName,
      Customer.city                                                                                                                as CustomerCity,
      Customer.street                                                                                                              as CustomerStreet,
      Customer.country_code                                                                                                        as CustomerCountryCode,

      concat_with_space(concat(concat_with_space(concat(Customer.street, ','), Customer.city, 1), ' -'), Customer.country_code, 1) as full_address
}
