# typed: strict
# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :domain_query, class: 'Queries::DomainQuery' do
    # doesn't have any attributes other than timestamps
  end

  factory :overpass_query, class: 'Queries::OverpassQuery' do
    facility_type { 'TODO' }
  end

  factory :query do
    sequence(:name) { |n| "Query #{n}" }
    description { "#{defined? query_type ? "#{query_type} " : ''} Query: #{Faker::Lorem.sentence}" }

    trait :domain do
      queryable factory: :domain_query
      transient do
        query_type { 'Domain' }

        listing_type { 'Rent' }
        property_types { %w[House ApartmentUnitFlat] }
        property_established_type { 'Any' }
        max_bedrooms { nil }
        min_bedrooms { 2 }
        max_bathrooms { nil }
        min_bathrooms { nil }
        max_carspaces { nil }
        min_carspaces { nil }
        min_price { 400 }
        max_price { 650 }
        exclude_deposit_taken { true }

        locations do
          [
            {
              'state' => 'VIC',
              'region' => 'Melbourne Region',
            },
          ]
        end
      end

      body do
        {
          'listingType' => listing_type,
          'propertyTypes' => property_types,
          'propertyEstablishedType' => property_established_type,
          'maxBedrooms' => max_bedrooms,
          'minBedrooms' => min_bedrooms,
          'minBathrooms' => min_bathrooms,
          'minCarspaces' => min_carspaces,
          'minPrice' => min_price,
          'maxPrice' => max_price,
          'locations' => locations,
          'excludeDepositTaken' => exclude_deposit_taken,
        }.compact.to_json
      end
    end

    trait :overpass do
      queryable factory: :overpass_query
      body { body_lines.join("\n") }

      transient do
        query_type { 'Overpass' }

        body_lines { [area_line, node_line, way_line] }

        area_line { %(area#{area_filter_string} -> .#{area_name};) }
        node_line { %(node#{node_filter_string}(area.#{area_name}); out body qt;) }
        way_line { %(way#{way_filter_string}(area.#{area_name}); out center tags qt;) }

        area_filter_string { area_filters.map { |k, v| %(["#{k}"="#{v}"]) }.join }
        node_filter_string { node_filters.map { |k, v| %(["#{k}"="#{v}"]) }.join }
        way_filter_string { way_filters.map { |k, v| %(["#{k}"="#{v}"]) }.join }

        area_filters do
          {
            place: area_place_type,
            name: area_name,
            wikidata: area_wikidata_id,
          }
        end

        area_place_type { 'city' }
        area_name { 'Melbourne' }
        area_wikidata_id { 'Q3141' }

        node_filters do
          {
            shop: node_shop,
            brand: node_brand,
          }
        end

        node_shop { 'supermarket' }
        node_brand { 'Coles' }

        way_filters { node_filters }
      end
    end
  end
end
