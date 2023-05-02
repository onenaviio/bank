class Issues::Creator < AppService
  param :exception
  param :context

  def call
    Issue.create!(
      message: exception.message,
      backtrace: exception.backtrace,
      occured_at: DateTime.now.in_time_zone,
      context: context
    )
  end
end
