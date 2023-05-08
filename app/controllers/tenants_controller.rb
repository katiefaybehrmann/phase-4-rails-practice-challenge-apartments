class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        ten = Tenant.all
        render json: ten
    end

    def show
        ten = Tenant.find(params[:id])
        render json: ten
    end

    def create
        ten = Tenant.create(apt_params)
        if ten.valid?
            render json: ten, status: :created
        else
            render json: { errors: ["validation errors"] }, status: :unprocessable_entity
        end
    end

    def update
        ten = Tenant.find(params[:id])
        ten.update(tenant_params)
        if ten.valid?
            render json: ten, status: :created
        else
            render json: { errors: ["validation errors"] }, status: :unprocessable_entity
        end
    end

    def destroy
        ten = Tenant.find(params[:id])
        ten.destroy
        head :no_content
    end

    private
    def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def tenant_params
        params.permit(:name, :age)
    end
end
