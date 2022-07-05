class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

    def index
        render json: Tenant.all, status: :ok
    end 

    def show 
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok
    end 

    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created 
    end 

    def update 
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end 

    def destroy 
        tenant = Tenant.find(params[:id])
        tenant.destroy 
        head :no_content 
    end 

    private 

    def tenant_params 
        params.permit(:name, :age)
    end 

    def invalid_record(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found 
        render json: {error: "Reocrd not found"}, status: :not_found
    end 

end
