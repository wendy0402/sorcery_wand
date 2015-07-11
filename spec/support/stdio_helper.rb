module StdioHelpers

  def redirect_stdout(&block)
    captured_stream = StringIO.new

    orginal_io, $stdout = $stdout, captured_stream

    block.call

    captured_stream.string
  ensure
    $stdout = orginal_io
  end
end
