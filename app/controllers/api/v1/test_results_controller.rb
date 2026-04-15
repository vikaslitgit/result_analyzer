module Api
  module V1
    class TestResultsController < ApplicationController
      def create
        # Build the record from the permitted params MSM sends
        result = TestResult.new(test_result_params)

        if result.save
          render json: { message: "Result stored successfully" }, status: :created
        else
          # Return validation errors so MSM knows what went wrong
          render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def test_result_params
        params.require(:test_result).permit(
          :student_name, :subject, :marks, :timestamp
        )
      end
    end
  end
end