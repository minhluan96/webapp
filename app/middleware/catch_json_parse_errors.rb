class CatchJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::Http::Parameters::ParseError => error
      p env
      error_output = "There was a problem in the JSON you submitted: #{error}"
      p env['HTTP_ACCEPT']
      p "error_output= #{error_output}"
      return [
          400, { "Content-Type" => "application/json" },
          [ { status: 400, error: error_output }.to_json ]
      ]
    end
  end
end
