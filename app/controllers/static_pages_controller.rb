class StaticPagesController < ApplicationController
  

  def home
    @visitor = Visitor.new
  end

  def whyus
    @visitor = Visitor.new
  end

  def aboutus
    @visitor = Visitor.new
  end

  def profiler
    @visitor = Visitor.new
  end

  def contact
    @visitor = Visitor.new
  end

  def setup
    @visitor = Visitor.new

    render :layout=> "layoutformodal"
     
  end
end
