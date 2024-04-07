# typed: strict
# frozen_string_literal: true

# Interface for creating and managing Query models
class QueriesController < ApplicationController
  extend T::Sig
  before_action :set_query, only: %i[show edit update destroy]

  # GET /queries or /queries.json
  sig { void }
  def index
    @queries = T.let(query_scope, T.nilable(ActiveRecord::Relation))
  end

  # GET /queries/1 or /queries/1.json
  sig { void }
  def show; end

  # GET /queries/new
  sig { void }
  def new
    @query = Query.new
  end

  # GET /queries/1/edit
  sig { void }
  def edit; end

  # POST /queries or /queries.json
  sig { void }
  def create
    @query = Query.new(query_params)

    respond_to do |format|
      if @query.save
        format.html { redirect_to query_url(@query), notice: 'Query was successfully created.' }
        format.json { render :show, status: :created, location: @query }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @query.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /queries/1 or /queries/1.json
  sig { void }
  def update
    respond_to do |format|
      if T.must(@query).update(query_params)
        format.html { redirect_to query_url(@query), notice: 'Query was successfully updated.' }
        format.json { render :show, status: :ok, location: @query }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: T.must(@query).errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /queries/1 or /queries/1.json
  sig { void }
  def destroy
    T.must(@query).destroy!

    respond_to do |format|
      format.html { redirect_to queries_url, notice: 'Query was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  sig { void }
  def set_query
    @query = T.let(query_scope.find(params[:id]), T.nilable(Query))
  end

  sig { returns(ActiveRecord::Relation) }
  def query_scope
    Query.order(:created_at).all
  end

  sig { returns(ActionController::Parameters) }
  def query_params
    params.require(:query).permit(:queryable_type, :name, :description, :body)
  end
end
