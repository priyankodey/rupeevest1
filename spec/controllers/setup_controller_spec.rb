require 'spec_helper'

describe SetupController do

  describe "GET '80c'" do
    it "returns http success" do
      get '80c'
      response.should be_success
    end
  end

  describe "GET 'rgess'" do
    it "returns http success" do
      get 'rgess'
      response.should be_success
    end
  end

  describe "GET 'bonds'" do
    it "returns http success" do
      get 'bonds'
      response.should be_success
    end
  end

  describe "GET 'emergency'" do
    it "returns http success" do
      get 'emergency'
      response.should be_success
    end
  end

  describe "GET 'gold'" do
    it "returns http success" do
      get 'gold'
      response.should be_success
    end
  end

  describe "GET 'justinvest'" do
    it "returns http success" do
      get 'justinvest'
      response.should be_success
    end
  end

  describe "GET 'house'" do
    it "returns http success" do
      get 'house'
      response.should be_success
    end
  end

  describe "GET 'marriage'" do
    it "returns http success" do
      get 'marriage'
      response.should be_success
    end
  end

  describe "GET 'education'" do
    it "returns http success" do
      get 'education'
      response.should be_success
    end
  end

end
