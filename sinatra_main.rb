require "sinatra"
require "sinatra/reloader"
require "sinatra/namespace"
require "sinatra/json"
require "./lib/file_util.rb"
require "./lib/array_util.rb"
require "active_support"
require "rack/contrib"
require "./sushi_recommend.rb"
use Rack::PostBodyContentTypeParser

namespace "/api" do
	namespace "/v1" do
		get "/" do
				data ={
					title: "Sushi Recommendation",
					description: "機械学習を使って寿司をレコメンドするサービスです.",
					charset:"utf-8",
				}
				json data
		end

		post "/" do
			preference = generate_preference_from(params)
			sushi_ranking = get_ranking_by(preference)
			data ={
				best:sushi_ranking[0],
				second_best:sushi_ranking[1],
				third_best:sushi_ranking[2]
			}
			json data
		end
	end
end