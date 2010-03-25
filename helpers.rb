

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

result = files_with_layout #'blb'
if(result)
  puts result
else
  puts 'no worries, keep going'
end
  

#Dir.foreach("_posts") {|x| puts "Got #{x}" }

#files.each do |file|
  
  #hash = read_yaml(file)
  #puts "Layout " + hash['layout']
#end

#h = read_yaml("_posts/2008-11-25-cloud-options.textile")
