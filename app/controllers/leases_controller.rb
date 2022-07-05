class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

    def index
        render json: Lease.all
    end 

    def create 
        lease = Lease.create!(rent:params[:rent], tenant_id:params[:tenant_id], apartment_id: params[:apartment_id])
        render json: lease, status: :created
    end 

    def destroy 
        lease = Lease.find(params[:id])
        lease.destroy 
        head :no_content 
    end 

private 
    def invalid_record(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found 
        render json: {error: "Reocrd not found"}, status: :not_found
    end 
end
