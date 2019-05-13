require "rails_helper"

RSpec.describe V1::UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/users").to route_to("v1/users#index")
    end

    it "routes to #operations" do
      expect(:get => "/v1/users/1/operations").to route_to("v1/users#operations", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/users").to route_to("v1/users#create")
    end

    it "routes to #update_balance via PATCH" do
      expect(:patch => "/v1/users/1/update_balance").to route_to("v1/users#update_balance", :id => "1")
    end
  end
end
