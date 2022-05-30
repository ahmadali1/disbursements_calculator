module Api
  module V1
    class DisbursementsController < ApplicationController
      def index
        @disbursements = Disbursement.where(disbursement_params)

        render json: @disbursements
      end

      private

      def disbursement_params
        params.permit(:year, :week, :merchant_id)
      end
    end
  end
end
