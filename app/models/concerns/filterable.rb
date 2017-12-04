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

	#@projects = Project.parseParams(params,@projects)
	def filter(p, obj)
		p.each do |key, val|
			if key != 'controller' && key != 'action' && val != "" && !key.match(/_condition$/) then
				value = sanitizeValue(key, val)	#added boolean support
				if validateParams(key) then
					if value == !!value	# is boolean
						if !value
							obj = obj.where("#{key} = #{val} or #{key} IS NULL")
						else
							obj = obj.where("#{key} = #{val}")
						end
					elsif key.match(/(date|fecha)/)	# is date
						condition = p["#{key}_condition"]	# gets condition value (it's formed by "key" name plus "_condition" string
						if value.length == 10
							obj = obj.where(key + " #{condition} ?", value)
						elsif value.length == 4		# only year
							obj = obj.where("extract(year from #{key}) #{condition} ?", value)
						elsif value.length == 7		# only year and month
							year, month = value.sub(/(\d{4})(?:\-|\/)(\d{2})/, '\1'), value.sub(/(\d{4})(?:\-|\/)(\d{2})/, '\2')
							obj = obj.where("extract(year from #{key}) #{condition} ?", year)
							obj = obj.where("extract(month from #{key}) #{condition} ?", month)
						end
					elsif value == "-"	# asking for empty value
						obj = obj.where("#{key} = '' OR #{key} IS NULL")
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
					if key == "valor_de_acta"
						if value == false
							obj = obj.where("fecha_acta IS NULL")
						elsif value == true
							obj = obj.where("fecha_acta IS NOT NULL")
						end						
					end					
				end
			end
		end
		obj
	end
	
	def sanitizeValue(key, val)
		val = val.downcase
		if ["true", "false"].include?(val)
			val == "true" ? true : false
		elsif key.match(/fecha/)
			val
		elsif val == "-"
			val
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

	