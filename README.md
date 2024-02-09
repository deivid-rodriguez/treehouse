# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## Notes

### Execute Domain search
```
fig run --rm -e 'DOMAIN_API_KEY=key_219ebd48b03175453be6690187de3a85' -e RAILS_LOG_TO_STDOUT=true web bin/rails runner 'body = {"listingType" => "Rent", "propertyTypes" => %w[NewHomeDesigns House NewHouseLand SemiDetached Studio Terrace Townhouse Villa], "propertyEstablishedType" => "Any", "maxBedrooms" => 2, "minBedrooms" => 2, "minBathrooms" => 2, "minCarspaces" => 1, "minPrice" => 400, "maxPrice" => 650, "locations" => [{"state" => "VIC", "region" => "Melbourne Region"}], "excludeDepositTaken" => true}; query = Queries::DomainQuery.create!(query_attributes: {name: "test 1", description: "testing 1", body:}); FetchQueryJob.perform_now(query: query.query).inspect'
```

### Parse response

```
fig run --rm web bin/rails runner 'ParseResponseJob.perform_now(response: Response.last)'

# or:
fig run --rm web bin/rails runner 'Responses::DomainResponse.last.parse!'
```
