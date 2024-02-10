# typed: strict
# frozen_string_literal: true

# Interface for viewing Domain listings
class ListingsController < ApplicationController
  extend T::Sig
  before_action :set_listing, only: %i[show destroy]

  # GET /listings or /listings.json
  sig { void }
  def index
    @listings = T.let(Listing.all, T.nilable(ActiveRecord::Relation))
  end

  # GET /listings/1 or /listings/1.json
  sig { void }
  def show; end

  # DELETE /listings/1 or /listings/1.json
  sig { void }
  def destroy
    T.must(@listing).destroy!

    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  sig { void }
  def set_listing
    @listing = T.let(Listing.find(params[:id]), T.nilable(Listing))
  end
end
