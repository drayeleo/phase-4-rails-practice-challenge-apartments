class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def index
    tenants = Tenant.all
    render json: tenants
  end

  def show
    tenant = find_tenant
    render json: tenant
  end

  def create
    tenant = Tenant.create!(permitted_params)
    render json: tenant
  end

  def update
    tenant = find_tenant
    tenant.update!(permitted_params)
    render json: tenant
  end

  def destroy
    tenant = find_tenant
    tenant.destroy
    head :no_content
  end

  private

  def find_tenant
    Tenant.find(params[:id])
  end

  def permitted_params
    params.permit(:name, :age)
  end

  def handle_record_not_found
    render json: { error: "Tenant not found" }, status: :not_found
  end

  def handle_invalid_record(invalid)
    render json: {
             error: invalid.record.errors.full_messages
           },
           status: :unprocessable_entity
  end
end
