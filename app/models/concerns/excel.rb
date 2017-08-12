
module Excel
	extend ActiveSupport::Concern

	class ExcelParser

		def initialize(file_path, type)		
			@excel = Roo::Spreadsheet.open(file_path, extension: type)
		end
		
		def parse_spreadsheet		
			parsed_content = []			
			open_spreadsheet.each(get_headers_as_keys(open_spreadsheet.row(2	))) do |row_hash|
				parsed_content << row_hash
			end
			parsed_content.shift
			parsed_content.map!{ |row| get_ids_from_relations(row) }
			
			return @model, parsed_content	# Alumno,	[{:dni=>16469312, :nombre=>"Franci...
		end
	
	private

		def get_ids_from_relations(hash)
		a = []
			hash_to_fix = []
			hash.each_pair do |key, value|
				if key.to_s.match('__')
					attribute_name, model_name = key.to_s.match(/^(.+?)__(.+?)$/)[1..2]
					attribute_name = attribute_name.downcase + '_id'					
					related_id = model_name.capitalize.constantize.where("#{model_name.downcase} ilike ?", value).first
					related_id ? related_id = related_id.id : related_id = value
					new_key = attribute_name.to_sym
					hash_to_fix << [key, new_key, related_id]
				end
			end

			hash_to_fix.each do |old_key, new_key, value|
				hash[new_key] = hash.delete old_key
				hash[new_key] = value
			end
			
			return hash
		end

		def open_spreadsheet
			@model = @excel.sheet(0).cell(1,1).capitalize.constantize
			raise "Tabla no está presente o nombre erróneo en celda A1 #{@model}" if !@model
			return @excel.sheet(0)
		end
		
		def get_foreign_keys(parsed_content)
			parsed_content
		end
		
		def get_headers_as_keys(header_row)
			return header_row.map { |header| {header.downcase.gsub(/ \(.+?\)/, '').gsub(' ', '_').gsub(/\./, '__').to_sym => header} }.inject(&:merge)
		end

	end
end