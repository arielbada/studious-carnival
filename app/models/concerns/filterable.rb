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
				if key != 'controller' && key != 'action' then
					value = sanitizeValue(val)	#added boolean support
					if validateParams(key) then						
						obj = obj.where(key + " like ?", value)
					else
						if validateParamsSub(key) then
							if key != "alumno"	#improve with attr_accessor option
								#obj = obj.where("EXISTS (SELECT * FROM localidades l, alumnos a WHERE l.id = a.localidad_id and l.localidad like '%#{val}%')")
								obj = obj.includes(key).where(key + " like ?", value).references(key)	# http://stackoverflow.com/questions/18234602/rails-active-record-querying-association-with-exists
							else
								obj = obj.includes(key).where("nombre like '%#{val}%' OR apellido like '%#{val}%'")
							end							
						end						
						if key == "legajo"
							value ? cond = "AND" : cond = "OR"		# if legajo true, condition is for all items true, if false, at least an item should be false														
							obj = obj.where("inscripcion_ficha = ? #{cond} inscripcion_foto = ? #{cond} inscripcion_partida = ? #{cond} inscripcion_certificado = ?", value, value, value, value)
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

	