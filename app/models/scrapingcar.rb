class Scrapingcar
  def self.scraping_car
 

    cars = []
    links = [] # 個別ページのリンクを保存する配列
    agent = Mechanize.new

    next_url = ""
 
      maker = "トヨタ"
      current_page = agent.get("https://www.carsensor.net/usedcar/shashu/bTO/index.html"+ next_url)

      elements = current_page.search('.label--checkbox a')
   
      elements.each do |ele|
        links << ele
 
      end

   
          links.each do |link|
            car = link.inner_text
            car = car.split("(")
          url = link.get_attribute('href')
          url = url.split("/")
          # puts maker
          #   puts car[0]
          #   puts "/" + url[3] +"/" + url[4] +"/"
            address= "/" + url[3] +"/" + url[4] +"/"
          
            carname = Carname.new
            carname.maker = maker
            carname.name = car[0]
            carname.address = address
            carname.maker_name = maker+":  " + car[0]

            
            carname.save if Carname.find_by(name: car[0])==nil
            
    
            
          end 
          

  end    
end
          
 