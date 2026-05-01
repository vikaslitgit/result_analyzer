require 'rails_helper'

RSpec.describe "Api::V1::TestResults", type: :request do
  let(:valid_headers) { { "X-Api-Key" => "test-secret-key" } }
  let(:valid_params) do
    {
      test_result: {
        student_name: "Alice Smith",
        subject:      "Math",
        marks:        85,
        timestamp:    Time.current.iso8601
      }
    }
  end

  before do
    # Set the API key env variable for tests
    allow(ENV).to receive(:fetch).with("MSM_API_KEY", "").and_return("test-secret-key")
  end

  describe "POST /api/v1/test_results" do
    context "with valid API key and valid params" do
      it "returns 201 Created" do
        post "/api/v1/test_results", params: valid_params, headers: valid_headers
        expect(response).to have_http_status(:created)
      end

      it "creates a TestResult record" do
        expect {
          post "/api/v1/test_results", params: valid_params, headers: valid_headers
        }.to change(TestResult, :count).by(10)
      end
    end

    context "with missing or invalid API key" do
      it "returns 401 Unauthorized when key is absent" do
        post "/api/v1/test_results", params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns 401 for a wrong API key" do
        post "/api/v1/test_results",
             params: valid_params,
             headers: { "X-Api-Key" => "wrong-key" }
        expect(response).to have_http_status(:unauthorized)
      end

      it "does not create a record when unauthorized" do
        expect {
          post "/api/v1/test_results", params: valid_params
        }.not_to change(TestResult, :count)
      end
    end

    context "with invalid params" do
      it "returns 422 when marks exceed 100" do
        params = valid_params.deep_merge(test_result: { marks: 150 })
        post "/api/v1/test_results", params: params, headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns 422 when subject is missing" do
        params = valid_params.deep_merge(test_result: { subject: "" })
        post "/api/v1/test_results", params: params, headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "includes error details in the response body" do
        params = valid_params.deep_merge(test_result: { marks: 150 })
        post "/api/v1/test_results", params: params, headers: valid_headers
        json = JSON.parse(response.body)
        expect(json["errors"]).to be_present
      end
    end
  end
end