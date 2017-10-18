
module Excel
	extend ActiveSupport::Concern

	class ExcelParser

		def initialize(file_path, type)		
			@excel = Roo::Spreadsheet.open(file_path, extension: type)
		end
		
		def parse_spreadsheet
			parsed_content = []
			spreadsheet = open_spreadsheet

			if @model != Seguimiento
				spreadsheet.each(get_headers_as_keys(spreadsheet.row(2))) do |row_hash|
					parsed_content << row_hash
				end
				parsed_content.shift
				parsed_content.map!{ |row| get_ids_from_relations(row) }
			else
				fecha_acta = spreadsheet.cell(5, 6).to_date				
				seccion = spreadsheet.cell(6, 6).to_s

				if seccion_id = validate_seccion(seccion)
					spreadsheet.parse(header_search: ["DNI", "Condición", "Calificación"]).each do |row_hash|						
						if row_hash["DNI"] && alumno_id = validate_alumno(row_hash["DNI"].to_i)							
							parsed_content << {alumno_id: alumno_id, fecha_acta: fecha_acta, seccion_id: seccion_id, estado: row_hash["Condición"], calificacion: row_hash["Calificación"]}
						end
					end				
				end
			end
		
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

		def validate_seccion(seccion)

				if cohorte = seccion.match(/(C\d+)/i)
					cohorte = cohorte[1]
					cohorte.sub!(/C(\d)$/i, 'C0\1')
				else
					raise "Cohorte no encontrada en archivo de importación: #{seccion}"
				end
				
				if modulo = seccion.match(/(M\d+)/i)
					modulo = modulo[1]
					modulo.sub!(/M\d$/i, 'M0\1')
				else
					raise "Módulo no encontrado en archivo de importación: #{seccion}"
				end
				
				if aula = seccion.match(/(\d+)$/)
					aula = aula[1]
					aula.sub!(/(.+)/i, 'A\1').sub!(/^(\d)$/, '0\1')
				else
					raise "Aula no encontrado en archivo de importación: #{seccion}"
				end
				seccion = cohorte + modulo + aula
				seccion_id = Seccion.find_by(seccion: seccion).id
				
				if seccion_id
					return seccion_id.to_i
				else
					return false
				end			
		end
		
		def validate_alumno(dni)
			if dni.to_s.match(/\d+/)
				alumno_id = Alumno.find_by(dni: dni)
				if alumno_id
					return alumno_id.id
				else
					raise "Alumno no válido, DNI: #{dni.to_s}"
				end
			else
				raise "Formato no válido de DNI: #{dni.to_s}"
				return false
			end
		end
		
		def open_spreadsheet
			if @excel.sheet(0).cell(1,1).to_s != ''
				@model = @excel.sheet(0).cell(1,1).capitalize
			elsif @excel.sheet(0).cell(10,2).to_s.in?(['Nº', 'N°'])
				@model = "Seguimiento"
			end
			raise "Tabla no presente o nombre erróneo de tabla en 'A1' #{@model}" if !@model
			@model = @model.constantize
			
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