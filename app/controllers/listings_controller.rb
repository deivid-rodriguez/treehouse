# typed: strict
# frozen_string_literal: true

# Interface for viewing Domain listings
class ListingsController < ApplicationController
  extend T::Sig
  before_action :set_listing, only: %i[show edit update destroy]

  # GET /listings or /listings.json
  sig { void }
  def index
    @listings = T.let(Listing.all, T.nilable(ActiveRecord::Relation))
  end

  # GET /listings/1 or /listings/1.json
  sig { void }
  def show; end

  # GET /listings/new
  sig { void }
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  sig { void }
  def edit; end

  # POST /listings or /listings.json
  sig { void }
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listing_url(@listing), notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  sig { void }
  def update
    @listing = T.must(@listing)
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to listing_url(@listing), notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

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

  # Only allow a list of trusted parameters through.
  sig { returns(ActionController::Parameters) }
  def listing_params
    params.fetch(:listing, {})
  end
end
