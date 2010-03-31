

def read_yaml(filename) #borrowed from Jekyll

  content = File.read(filename)
  
  if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
    content = content[($1.size + $2.size)..-1]
  
    data = YAML.load($1)
  end
  
  data ||= {}
end


def files_with_layout(layout='preview')

  files_to_search = nil
  Dir.glob("_posts" + "**/**.*").each do  |file| 
    yaml = read_yaml(file)
    files_to_search ||= [] << file if (yaml['layout'] == layout)
  end
  
  files_to_search

end

def get_blog_images

  paths = {}
    Dir.glob("_posts" + "**/**.*").each do  |file| 
  
    content = File.read(file).downcase
    match = content.scan(/!http:\/\/(scottwater|scottw|simpable)\.com\/(.+)!/).collect{ |img|  img[1].to_s.gsub(/\(.+\)/,'')}
    #take2 = match
  
    match.each do |path|
      (paths[path.slice(7..-1)] = file unless paths.include?(path))# if path =~ /^http:\/\/s/
    end
  
  end

  #paths.collect!{ |img| img.slice!(7..-1)}
  paths
end

def find_empty_folders(dirPath, folders=[])
  #Dir.open("/foo").collect.length-2
  
  if(File.directory?(dirPath))

    Dir.foreach(dirPath) do |entry|
        
      if entry[0,1] != "."
          path = "#{dirPath}/#{entry}"
          if(File.directory?(path))          
            folders << path #{}"#{path} (#{Dir.open(path).collect.length-2})"
            find_empty_folders(path, folders)
          end
      end
    end
  end
  folders
end

def all_blog_images
  
  root_path = '/Users/scott/code/dump/simpable_temp'
  Dir.glob(root_path + "**/**.*").each do  |file| 
    puts file 
  end
  
end

#all_blog_images

basePath = '/Users/scott/code/dump/simpable_temp'


def listDir(dirPath, list=[])
    
  if File.directory?(dirPath)
    
    
    Dir.foreach(dirPath) do |entry|
    
      if entry[0,1] != "."
        path = "#{dirPath}/#{entry}"
        list = listDir(path, list) 
        list << path.downcase unless File.directory?(path)
      end
    
    end
  

  
  end
  
  list
end


blog_images = get_blog_images
#p blog_images
all_images = listDir(basePath).collect!{ |img| img.slice!(43..-1)}

#images_to_delete = all_images.reject{|img| blog_images.include? img}
missing_images = blog_images.reject {|img, path| all_images.include? img}

missing_images.each_key do |key|
  
  puts "The image #{key} is missing from #{missing_images[key]}"
  
end

#puts "There are #{blog_images.size} blog images, #{all_images.size} total images, #{images_to_delete.size} images to delete, and #{missing_images.size} missing images"

#folders = find_empty_folders(basePath)
#folders.each do |folder|
  
#  puts "#{folder} will be deleted" if Dir.open(folder).collect.length-2 == 0
#  Dir.delete(folder) if Dir.open(folder).collect.length-2 == 0
  
#end

#puts 'blog images'
#puts blog_images
#puts ''
#puts 'all images'
#puts all_images
#puts ''
#puts 'can delete'
#images_to_delete.each do |img|
   
  #File.delete("/Users/scott/code/dump/simpable_temp/image/#{img}")
  #puts "deleting /Users/scott/code/dump/simpable_temp/image/#{img}"
#end
#puts ''
#puts 'missing'
#puts missing_images

#require 'find' 
#Find.find('/Users/scott/code/dump/simpable_temp') do |f| 
#  p f unless File::directory?(f) 
#end

#Dir.foreach("_posts") {|x| puts "Got #{x}" }

#files.each do |file|
  
  #hash = read_yaml(file)
  #puts "Layout " + hash['layout']
#end

#h = read_yaml("_posts/2008-11-25-cloud-options.textile")
