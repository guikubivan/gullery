xml.instruct!

xml.rss "version" => "2.0", "xmlns:media" => "http://search.yahoo.com/mrss/" do
 xml.channel do

   xml.title       "Naya's artwork"
   xml.link        url_for :only_path => false, :controller => 'projects'
   xml.description "Keep track of Naya's pictures here"
   count = 0
   @projects.each do |project|
#     xml.item do
#       xml.title       project.name
#       xml.description project.description
#       xml.guid        url_for :only_path => false, :controller => 'projects', :action => 'show', :id => project.id
#     end
     break if count == 2
     project.assets.each do |asset|
        xml.item do
          xml.title       asset.caption
          @d = asset.measurements != '' ? asset.artwork_medium + "(" + asset.measurements + ")" : asset.artwork_medium
          #xml.description asset.artwork_medium + "(" + asset.measurements + ")"
          xml.description @d
          xml.tag!("media:group") do
            xml.media :content, :url=> "http://nayabei.com/artwork" + asset.web_path, :type => "image/jpg", :duration => 3, :start => 10
          end

        end

     end
     count +=1
   end
 end
end
