desc "Create a new post"
task :new do 
  title = ask 'Post Title:'
  slug = sluggit title
  
  #could be .yaml here, but I wan to control the order
  post = "---\nlayout: post\ntitle: #{title}\ndate: #{Time.now.strftime("%m/%d/%Y %I:%M %p")}\npermalink: /#{slug}\ntags: [ ]\n---\n\nOnce upon a time..."
  
  path = "#{Dir.pwd}/_posts/#{Time.now.strftime("%Y-%m-%d-")}#{slug}.textile"
    
    unless File.exist? path
      File.open(path, "w") do |file|
        file.write post
      end
      tell "a post was created for you at #{path}."
    else
      tell "I can't create the post, #{path} already exists."
    end    
  
end

desc "Preview the site"
task :preview do
  tell 'executing jekyll'
  `jekyll`
  tell 'starting shotgun. press control+C to exit'
  `shotgun config.ru`
  
end

def tell msg
  puts "\n#{msg}\n\n"
end

def ask message
  print message + ' '
  STDIN.gets.chomp
end

def sluggit title
   slug = title.dup.downcase
   slug = slug.gsub(/[\W_-]/, ' ') 
   slug = slug.split(' ').select{|s| s unless s.empty?}.collect{|s| s unless %w{a an and are as at be but by for if in into is it no of on or such that the their then there these they this to was will with}.include?(s)}.join(' ')
   slug = slug.strip.gsub(/ +/,'-')
   slug = (slug.split('-')[0...5]).join('-') if slug.size > 25
   slug = "post-#{Time.now.strftime("%Y-%m-%d")}" if slug.size == 0 ||  %w{update edit feed rss create new tag}.include?(slug)
   slug
end