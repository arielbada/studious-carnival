class SeguimientoImport
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Excel
  include Validaciones
  
  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }	
  end

  def persisted?
    false
  end

  def save
    if imported_data.map(&:valid?).all?
      imported_data.each(&:save!)
      true
    else	
      imported_data.each_with_index do |data, index|
        data.errors.full_messages.each do |message|
          errors.add :base, "Fila #{index+1}: #{message}: #{@spreadsheet[index].map{ |k,v| "#{k}: \"#{v}\"" }.join('; ')}"
        end
      end
      false
    end
  end

  def imported_data
    @imported_data ||= load_imported_data
  end

  def load_imported_data
    @model, @spreadsheet = open_spreadsheet
	@spreadsheet.map do |row|				# row:	[{:alumno_id=>59285, :seccion_id=>1151, :estado=>nil, :calificacion=>7}, {:alumno_id...
		item = @model.find_by(alumno_id: row[:alumno_id], fecha_acta: row[:fecha_acta], seccion_id: row[:seccion_id]) || @model.new
		item.attributes = row.to_hash.slice( *@model.column_names.map { |a| a.to_sym } )

		item
	end
  end
  
  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".xls" then excel_handler = Excel::ExcelParser.new(file.path, :xls)
    when ".xlsx" then excel_handler = Excel::ExcelParser.new(file.path, :xlsx)
    else raise "Tipo de archivo desconocido: #{file.original_filename}"
    end
	
	return excel_handler.parse_spreadsheet
  end
end