require 'cucumber/formatter/html'

module Cucumber
  module Formatter
    class AnchoredHtml < Html

      def before_feature(feature)
        super(feature)
        lines = feature.name.split(/\r?\n/)
        dashed_name = lines[0].gsub(/\s+/, "-")
        @builder.a(:name => dashed_name)
      end
    end
  end
end