require 'rubygems'
require 'bundler'
Bundler.require

set :root, File.dirname(__FILE__)

class Processing
	class << self
		def run(sketchname)
			Headless.ly do
				r = File.dirname(__FILE__)
  			`#{r}/bin/processing/processing-java --sketch=#{r}/sketches/#{sketchname} --output=#{r}/sketches/#{sketchname}/build --force --run`
			end
		end
	end
end

get '/' do
	# this should totally go in a background job. Just showing it here for simplicity
	Processing.run("test")
	"Generated a test image into /sketches/test. You can upload it to S3 or whateva."
end