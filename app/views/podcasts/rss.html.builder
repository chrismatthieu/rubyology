xml.instruct! :xml, :version=>"1.0" 
xml.rss ("version"=>"2.0", "xmlns:itunes"=>"http://www.itunes.com/dtds/podcast-1.0.dtd") { 
  xml.channel{
    xml.title("Rubyology")
    xml.link("http://www.rubyology.com/")
    xml.language("en-us")
    xml.copyright("Copyright 2007 Chris Matthieu")
    xml.itunes :subtitle, "Study of Ruby on Rails by Chris Matthieu"
    xml.itunes :author, "Chris Matthieu"
    xml.itunes :summary, "The Rubyology podcast is a series of lessons learned by Chris Matthieu on his endeavor of switching from Microsoft .NET programming to Ruby on Rails.  Believe it or not, there are similarities between both Micorost ASP and .NET and Ruby on Rails.  Let Chris show you how to get up and running on Rails and become proficient with Ruby with little effort.  Learn AJAX tricks, tagging, buddy lists, rating, and other Web 2.0 social network programming techniques and get your idea to market today!  While you are at it, check out the Rubyology.com website for code snippets and additional show information."
    xml.description("The Rubyology podcast is a series of lessons learned by Chris Matthieu on his endeavor of switching from Microsoft .NET programming to Ruby on Rails.  Believe it or not, there are similarities between both Micorost ASP and .NET and Ruby on Rails.  Let Chris show you how to get up and running on Rails and become proficient with Ruby with little effort.  Learn AJAX tricks, tagging, buddy lists, rating, and other Web 2.0 social network programming techniques and get your idea to market today!  While you are at it, check out the Rubyology.com website for code snippets and additional show information.")
		
    xml.itunes :owner do
      xml.itunes :name,"Chris Matthieu"
      xml.itunes :email,"chris@rubyology.com"
    end

    xml.itunes :image,:href=>"http://rubyology.com/images/rubyology.jpg"
    xml.itunes :explicit, 'clean' 
    		
  
  
		xml.itunes :category,:text=>'Technology' do
			xml.itunes :category,:text=>'Software How-To'
		end    
		
    for podcast in @podcasts
      xml.item do
        
        if podcast.podurl == "mov"
          @url = "http://rubyology.com/mp3s/rubyology" + podcast.id.to_s + ".mov"
          #@url = "http://s3.amazonaws.com/rubyology/rubyology" + podcast.id.to_s + ".mov"
          
        elsif podcast.podurl.blank? or podcast.podurl == "mp3"
          @url = "http://rubyology.com/mp3s/rubyology" + podcast.id.to_s + ".mp3"
        else
          @url = podcast.podurl
          #@url = "http://s3.amazonaws.com/rubyology/rubyology" + podcast.id.to_s + ".mp3"
        end
      
        xml.title(podcast.podname)
        xml.itunes :author, "Chris Matthieu"
        xml.itunes :subtitle, podcast.poddesc #"Study of Ruby on Rails"
        xml.itunes :summary, podcast.poddesc
        xml.description(podcast.poddesc)
        if podcast.podurl == "mov"
          xml.enclosure(:url=>@url, :type=>"video/quicktime") #add length
        else
          xml.enclosure(:url=>@url, :type=>"audio/mpeg") #add length
        end
        xml.guid(@url)
        # xml.pubDate(podcast.created_at.rfc2822)
        xml.pubDate(podcast.created_at) #.strftime("%A, %d %B %Y %I:%M:%S %z"))
        xml.itunes :duration, "15:00" #add duration to database entry
        xml.itunes :keywords, "ruby,rails,ruby on rails,programming,web 2.0,rubyology" #add keywords to database entry
      end
    end
  }
}