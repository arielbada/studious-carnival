json.extract! seguimiento, :id, :alumno_id, :cohorte, :modulo, :fecha_acta, :aula, :estado, :calificacion, :comentario, :created_at, :updated_at
json.url seguimiento_url(seguimiento, format: :json)