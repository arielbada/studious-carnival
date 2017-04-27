# ruby encoding: utf-8

require 'win32ole'

class ExcelConstants

end

def get_excel_content(file)

	puts "opening excel file: #{file}..."
    excel = WIN32OLE.new('Excel.Application')
    excel.Visible = false
    excel.DisplayAlerts = false

    WIN32OLE.const_load(excel, ExcelConstants)
	
	# Recopilar info de excel
    fileName = File.basename(file)
    puts "extracting data from the file: " + file + "..."
    excel_path = File.expand_path(file)
    workbook = excel.Workbooks.Open(excel_path)
    wSheet = workbook.WorkSheets(1)
    
    column_names = []
    data =[]
    col = 1
    row = 1
    entity_name = wSheet.Cells(row, col).Value
    row += 1    

    while wSheet.Cells(row, col).Value do
    	column_names << [col, wSheet.Cells(row, col).Value.downcase.gsub(/\(.+?\)/, "").strip.gsub(" ", "_")]
    	col += 1
    end
	puts "#{column_names.count} columns discovered #{column_names.inspect}"
	col_count = column_names.count

	row += 1
    while wSheet.Cells(row, 'B').Value do
    	set = []
    	column_names.each do |index, column|
    		cell_value = wSheet.Cells(row, index).Value
			if cell_value
				cell_value = cell_value.to_s.strip
				cell_value.gsub!(/\.0$/, "")
				cell_value.gsub!('"', '\\\"')
			else
				cell_value = ""
			end

    		set << [column, cell_value]
    	end # col_count do

        data << Hash[set]
        row += 1
    end

    puts "closing file: #{fileName}..."
    workbook.Close
    excel.quit
		puts "#{row-2} registers loaded"

    return entity_name, data 
end

def generate_seed_file(table_name, data)
	filename = "#{table_name}_seed.rb"
	puts "generating #{filename}..."
	output = "# ruby encoding: utf-8\n" + data
	File.open(filename, "w+:UTF-8"){|f| f.puts output}
end

def get_table_name(xlsx_file)	
	if xlsx_file.match(/Tabla .+?.xlsx/)
		table_name = xlsx_file.sub(/Tabla (.+?)\.xlsx/, '\1').downcase
	else
		table_name = "unrecognized"
		puts "Excel File should be named 'Tabla Xxxxx.xlsx'"
	end
	puts "table recognized as '#{table_name}'"

	return table_name
end

def generate_seed_code(table_name, entity_name, parsed_content)
	puts "generating seed code..."
	#		parsed_content => {"seccion"=>"C1M00A01", "fecha_inicio"=>2015-06-08 00:00:00 -0300, "fecha_finalizacion"=>2015-08-30 00:00:00 -0300}
	
	entity_name = entity_name.capitalize
	output = "#{entity_name}.delete_all\n"
	output += "broken_ids = []\n"
	parsed_content.each do |row|
		query = "#{entity_name}.create( "
		reference_values = []
		rescue_string = ""
		row.each do |key, value|
			if key.match(/\w\.\w/)
				reference_attribute = key.match(/\.(.+?)$/)[1]
				reference_entity = key.match(/(.+?)\./)[1].capitalize
				query_reference_id = "#{reference_entity}.where('lower(#{reference_attribute.downcase}) = ?', '#{value}'.downcase).first.id"
				query += "#{reference_attribute}: #{query_reference_id}, "	#reference field
				reference_values << value
			else
				query += "#{key}: \"#{value}\", "	# normal field
			end
		end
		rescue_string = " rescue broken_ids << #{reference_values}" if reference_values.count > 0
		query = query[0..-3] + ")#{rescue_string}\n"	# delete last comma, add rescue and add breakline
		output += query
	end
	output += "puts broken_ids.flatten.uniq.sort"
	return output
end


migration_tables = Dir['*.xlsx'] - Dir['~$*.xlsx']

migration_tables.each do |xlsx_file|
	table_name = get_table_name(xlsx_file)
	entity_name, excel_content = get_excel_content(xlsx_file)
	seed_code = generate_seed_code(table_name, entity_name, excel_content)
	generate_seed_file(table_name, seed_code)
end