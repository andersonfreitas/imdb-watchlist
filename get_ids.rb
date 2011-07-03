require "json"
require "open-uri"
require "cgi"

def create_url(title, year)
	title = CGI::escape(title)
	url = "http://www.imdbapi.com/?t=#{title}&y=#{year}"
	url
end

def get_id(url)
	uri = URI.parse(url)
	json = uri.open.read
	
	parsed_json = JSON.parse(json)
	parsed_json["ID"]
end

def create_js(id)
	"addToMyList(\"#{id}\");"
end

def get_movies_from_folder(folder)
	Dir[folder].select{|file| File.ftype(file) == "directory"}.collect{|name| name.split("/").last}	
end

def get_movies_from_file(file)
	File.open(file).lines
end

# movies = get_movies_from_folder "/Volumes/Movies/Movies/*"
movies = get_movies_from_file "import.txt"

errors = []

movies.each do |d| 
	r = d.match /^(.*) \((.{4})\)$/
	if r
		title = r[1]
		year = r[2]
		puts create_js(get_id(create_url(title, year)))
	else
		errors.push "I couldn't recognize #{d}"
	end
end

puts errors