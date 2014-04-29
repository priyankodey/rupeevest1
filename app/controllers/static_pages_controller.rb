class StaticPagesController < ApplicationController
  
  def index
    render :layout => 'home1'
  end

  def home
   
  end

  def whyus
   
  end

  def aboutus
   
  end

  def videotreasure
    
  end

  def video
   
  end 

  def productpage
    @visitor = Visitor.new
  end

  def setup
   

    render :layout=> "layoutformodal" 
  end


  def download_pdf1
    send_file("#{Rails.root}/app/assets/data/Rupeevest Hudco Tax Free.pdf",
              filename: "Rupeevest Hudco Tax Free.pdf",
              type: "application/pdf")
  end

   def download_pdf2
    send_file("#{Rails.root}/app/assets/data/Rupeevest IIFCL Tax Free.pdf",
              filename: "Rupeevest IIFCL Tax Free.pdf",
              type: "application/pdf")
  end

   def download_pdf3
    send_file("#{Rails.root}/app/assets/data/Rupeevest Shriram City Union.pdf",
              filename: "Rupeevest Shriram City Union.pdf",
              type: "application/pdf")
  end

   def download_pdf4
    send_file("#{Rails.root}/app/assets/data/Rupeevest Indian Infoline Housing Finance.pdf",
              filename: "Rupeevest Indian Infoline Housing Finance.pdf",
              type: "application/pdf")
  end

end
