class SetupController < ApplicationController
  
  def c80
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end

  def rgess
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end

  def bonds
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end

  def emergency
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end

  def gold
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end

  def justinvest
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end

  def house
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end

  def marriage
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end

  def education
    @visitor = Visitor.new
    @analysis = Analysis.new
    render :layout=> "layoutforsetup"
  end
end
