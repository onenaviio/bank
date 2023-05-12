module RenderMethods
  private

  def render_json(data, status: 200)
    render json: { data: data }, status: status
  end

  def render_collection(resources, status: 200)
    render_json(resources, status: status)
  end
end
