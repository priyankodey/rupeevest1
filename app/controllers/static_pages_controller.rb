class StaticPagesController < ApplicationController
  def home
    @visitor = Visitor.new
  end

  def whyus
  end

  def aboutus
  end

  def profiler
  end

  def contact
  end
end
