class AlumnoImport
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Excel

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
          errors.add :base, "Fila #{index+2}: #{message}: #{@spreadsheet[index].map{ |k,v| "#{k}: \"#{v}\"" }.join('; ')}"
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
	@spreadsheet.map do |row|				#	{:dni=>16469312, :nombre=>"Francisco Alfredo", :apellido=>"Aballay", :sexo=>nil, :domicilio=>nil,...
		item = @model.find_by(dni: row[:dni]) || @model.new
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