class Scrapingcar
  def self.scraping_car
 

    cars = []
    links = [] # 個別ページのリンクを保存する配列
    agent = Mechanize.new
    carlists = [["レクサス","/bLE/index.html"],["トヨタ","/bTO/index.html"],["ホンダ","/bHO/index.html"],["日産","/bNI/index.html"],["スズキ","/bSZ/index.html"],["ダイハツ","/bDA/index.html"],["マツダ","/bMA/index.html"],["スバル","/bSB/index.html"],["三菱","/bMI/index.html"]]
    carlists.each do |carlist|
      maker = carlist[0]
      next_url = carlist[1]

      current_page = agent.get("https://www.carsensor.net/usedcar/shashu"+ next_url)
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
end
          
 