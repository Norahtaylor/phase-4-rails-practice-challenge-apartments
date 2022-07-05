class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

    def index 
        render json: Apartment.all 
    end 

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end 

    def update 
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end 

    def create
        apartment= Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy 
        head :no_content 
    end 

    private 

    def apartment_params
        params.permit(:number)
    end 

    def invalid_record(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found 
        render json: {error: "Reocrd not found"}, status: :not_found
    end 
end
