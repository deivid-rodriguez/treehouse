# frozen_string_literal: true

json.array! @listings, partial: 'listings/listing', as: :listing
