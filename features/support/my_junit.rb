require 'cucumber/formatter/junit'

module Cucumber
  module Formatter
    class MyJunit < Junit
      def build_testcase(duration, status, exception = nil, suffix = "")
        @time += duration
        classname = "#{@feature_name}.#{@scenario}"
        name = "#{@scenario}#{suffix}"
        failed = (status == :failed || (status == :pending && @options[:strict]))
        #puts "FAILED:!!#{failed}"
        if status == :passed || failed
          @builder.testcase(:classname => classname, :name => name, :time => "%.6f" % duration) do
            if failed
              slug_line = exception ? "#{exception.message.match(/.*/)[0]}" : name
              @builder.failure(:message => "#{status.to_s}: #{slug_line}", :type => status.to_s) do
                @builder.text! @output
                @builder.text!(format_exception(exception)) if exception
              end
              @failures += 1
            end
          end
          @tests += 1
        end
      end
    end
  end
end
