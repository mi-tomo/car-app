class Scraping
    def self.scraping_contents(link)
      begin
      agent = Mechanize.new
      page = agent.get(link)
    
    
      evaluation = page.at('.evaluationWrap__contents p span').inner_text if page.at('.evaluationWrap__contents p span')
      model = page.at('.title3 span').inner_text if page.at('.title3 span')
      model = model.split(/ /)
      model.pop
      model = model.join
      model.slice!(0)
      exhaust = page.at('//th[text()="排気量"]/following-sibling::td[position()=1]').inner_text if page.at('//th[text()="排気量"]/following-sibling::td[position()=1]')
      exhaust.gsub!(/cc/, '')
      modelyear = page.at('.specWrap__box__num').inner_text if page.at('.specWrap__box__num')
      color = page.at('//th[text()="色"]/following-sibling::td[position()=1]').inner_text if page.at('//th[text()="色"]/following-sibling::td[position()=1]')
      distance = page.at('//p[text()="走行距離"]/following-sibling::p[position()=1]').inner_text if page.at('//p[text()="走行距離"]/following-sibling::p[position()=1]')
  
    
      unit = page.at('//p[text()="走行距離"]/following-sibling::p[position()=2]').inner_text if page.at('//p[text()="走行距離"]/following-sibling::p[position()=2]')
      distance = distance.to_f
        if unit=="km"
          distance = distance * 0.0001
          distance = distance.floor(4).to_f
          unit = "万km"
        end
        if distance > 20
          distance = nil
        end
      price = page.at('.totalPrice__price span').inner_text if page.at('.totalPrice__price span')
      repare = page.at('//p[text()="修復歴"]/following-sibling::p[position()=1]').inner_text if page.at('//p[text()="修復歴"]/following-sibling::p[position()=1]')
    
      product = Product.new
      product.evaluation = evaluation
      product.model = model
      product.exhaust = exhaust
      product.modelyear = modelyear
      product.color =color
      product.distance = distance
      product.unit = unit
      product.price = price
      product.repare = repare
      product.save
    rescue => e
      puts e
    end
    end
    def self.scraping_url(urlpass)
        links = [] # 個別ページのリンクを保存する配列
        agent = Mechanize.new
        
        next_url = "/usedcar#{urlpass}index.html"
        
        while true 
    
        current_page = agent.get("https://www.carsensor.net"+ next_url)
    
        elements = current_page.search('.casetMedia__obj a')
        
        elements.each do |ele|
          links << ele.get_attribute('href')
        end
      
        next_link = current_page.at('.pager__btn .pager__btn__next')
        next_link = next_link.to_s
        next_link = next_link[/.href='(.*)'/,1]

        puts next_link
        break unless next_link
          
            next_url = next_link
            # puts next_url
        end
       links.each do |link|
       scraping_contents('https://www.carsensor.net/' + link)

       end
     end
end
