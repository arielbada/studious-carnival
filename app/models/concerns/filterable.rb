# Call scopes directly from your URL params:
#
#     @products = Product.filter(params.slice(:status, :location, :starts_with))
module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    
    # Call the class methods with the same name as the keys in <tt>filtering_params</tt>
    # with their associated values. Most useful for calling named scopes from 
    # URL params. Make sure you don't pass stuff directly from the web without 
    # whitelisting only the params you care about first!
=begin
    def filter(filtering_params)
      results = self.where(nil) # create an anonymous scope
      filtering_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
=end

		#@projects = Project.parseParams(params,@projects)
		def filter(p, obj)
			p.each do |key, val|
				if key != 'controller' && key != 'action' and val != "" then
					value = sanitizeValue(val)	#added boolean support
					if validateParams(key) then
						if value == true || value == false	# is boolean
							if value == false
								obj = obj.where("#{key} = #{val} or #{key} IS NULL")
							else
								obj = obj.where("#{key} = #{val}")
							end
						else
							obj = obj.where(key + " ilike ?", value)
						end
					else
						if validateParamsSub(key) then
							if key != "alumno"	#improve with attr_accessor option
								obj = obj.includes(key).where(key + " ilike ?", value).references(key)	# http://stackoverflow.com/questions/18234602/rails-active-record-querying-association-with-exists
							else
								obj = obj.includes(key).where("nombre ilike '%#{val}%' OR apellido ilike '%#{val}%'").references(key)
							end							
						end
						if key == "legajo"
							legajo = ["inscripcion_ficha", "inscripcion_foto", "inscripcion_partida", "inscripcion_certificado"]
							value ? cond = "AND" : cond = "OR"
							query = ""
							legajo.each do |leg|
								query += "#{leg} = #{value} #{cond} "
								query += "#{leg} IS NULL #{cond} " if !value 
							end
							query = query.chomp(" #{cond} ")
							obj = obj.where(query)							
						end
						if key == "cada_ultimo_registro"							
							obj = obj.group("alumno_id").having("fecha_acta = MAX(fecha_acta)")
						end
					end
				end
			end
			obj
		end
		
		def sanitizeValue(val)
			val = val.downcase
			if ["true", "false"].include?(val)
				val == "true" ? true : false
			else
				"%#{val}%"
			end
		end
		
		def validateParams(pname)
			i = false
			self.columns.each do |column|
				if pname == column.name then
					i = true
				end
			end
			i
		end
		
		def validateParamsSub(pname)
			i = false
			self.columns.each do |column|
				if pname+"_id" == column.name then
					i = true					
				end
			end
			i
		end
		
	end
end

	