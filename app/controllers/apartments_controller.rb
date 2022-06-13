class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def index
    apartments = Apartment.all
    render json: apartments
  end

  def show
    apartment = find_apartment
    render json: apartment
  end

  def create
    apartment = Apartment.create!(permitted_params)
    render json: apartment
  end

  def update
    apartment = find_apartment
    apartment.update!(permitted_params)
    render json: apartment
  end

  def destroy
    apartment = find_apartment
    apartment.destroy
    head :no_content
  end

  private

  def find_apartment
    Apartment.find(params[:id])
  end

  def permitted_params
    params.permit(:number)
  end

  def handle_record_not_found
    render json: { error: "Apartment not found" }, status: :not_found
  end

  def handle_invalid_record(invalid)
    render json: {
             error: invalid.record.errors.full_messages
           },
           status: :unprocessable_entity
  end
end
