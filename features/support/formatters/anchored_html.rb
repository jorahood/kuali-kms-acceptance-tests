require 'cucumber/formatter/html'

module Cucumber
  module Formatter
    class AnchoredHtml < Html

      def before_feature(feature)
        super(feature)
        lines = feature.name.split(/\r?\n/)
        @builder.a(:name => lines[0])
      end
    end
  end
end