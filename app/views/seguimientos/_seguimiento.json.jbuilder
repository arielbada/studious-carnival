json.extract! seguimiento, :id, :alumno_id, :cohorte, :modulo, :fecha_acta, :aula, :estado, :calificacion, :created_at, :updated_at
json.url seguimiento_url(seguimiento, format: :json)