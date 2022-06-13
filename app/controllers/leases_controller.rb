class LeasesController < ApplicationController
  def create
    lease = Lease.create!(permitted_params)
    render json: lease
  end

  def destroy
    lease = find_lease
    lease.destroy
    head :no_content
  end

  private

  def find_lease
    Lease.find(params[:id])
  end

  def permitted_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end

  def handle_record_not_found
    render json: { error: "Lease not found" }, status: :not_found
  end

  def handle_invalid_record(invalid)
    render json: {
             error: invalid.record.errors.full_messages
           },
           status: :unprocessable_entity
  end
end
