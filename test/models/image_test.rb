# typed: strict
# frozen_string_literal: true

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  extend T::Sig

  test '#listing exists' do
    assert_not_nil create(:image).listing
  end
end
