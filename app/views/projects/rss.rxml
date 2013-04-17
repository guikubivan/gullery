xml.instruct!

xml.rss "version" => "2.0", "xmlns:media" => "http://search.yahoo.com/mrss/" do
 xml.channel do

   xml.title       "Naya's artwork - " + @project.name
   xml.link        url_for :only_path => false, :controller => 'projects'
   xml.description @project.description 
   count = 0
   @project.assets.each do |asset|
      xml.item do
        xml.title       asset.caption
        @d = asset.measurements != '' ? asset.artwork_medium + "(" + asset.measurements + ")" : asset.artwork_medium 
        xml.description @d
        xml.tag!("media:group") do
          xml.media :content, :url=> "http://nayabei.com/artwork" + asset.web_path, :type => "image/jpg", :duration => 2, :start=> 10
        end

      end

   end
 end
end
