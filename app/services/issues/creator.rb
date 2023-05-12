class Issues::Creator < AppService
  CODE_SIZE = 3

  param :exception
  param :context

  def call
    Issue.create!(
      message: exception.message,
      backtrace: exception.backtrace,
      occured_at: DateTime.now.in_time_zone,
      context: context,
      code: code
    )
  end

  private

  def code
    line = error_file_data[:line]
    line_range = (line - (CODE_SIZE + 1))...(line + CODE_SIZE)

    File.readlines(error_file_data[:path]).filter_map.with_index do |line, index|
      line if index.in?(line_range)
    end
  end

  def error_file_data
    array = exception.backtrace[0].split(":in").first.split("/")
    file_name, line = array.last.split(":")
    filtered_array = array.filter_map.with_index { |c, i| c if i >= array.index("app")  }
    filtered_array[-1] = file_name

    {
      path: Rails.root.join(*filtered_array),
      line: line.to_i
    }
  end
end
