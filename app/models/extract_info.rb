class ExtractInfo < ActiveRecord::Base

	validates_uniqueness_of :artist_name, scope: :artist_genre

	scope :search_all_artists , -> (keywords) { where( matching_keyword_query(keywords, 'AND')) }

	def self.matching_keyword_query(keywords, condition_separator='AND')
		keywords.map { |keyword| "(artist_name LIKE '%#{keyword}%' OR artist_genre LIKE '%#{keyword}%')" }.join(" #{condition_separator} ")		
	end 
	 
end
