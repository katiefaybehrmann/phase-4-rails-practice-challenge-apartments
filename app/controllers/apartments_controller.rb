class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        apts = Apartment.all
        render json: apts
    end

    def show
        apt = Apartment.find(params[:id])
        render json: apt
    end

    def create
        apt = Apartment.create(apt_params)
        render json: apt, status: :created
    end

    def update
        apt = Apartment.find(params[:id])
        apt.update(apt_params)
        render json: apt
    end

    def destroy
        apt = Apartment.find(params[:id])
        apt.destroy
        head :no_content
    end

    private
    def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def apt_params
        params.permit(:number)
    end
end
