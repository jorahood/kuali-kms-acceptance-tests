require 'cucumber/formatter/html'

module Cucumber
  module Formatter
    class AnchoredHtml < Html

      def before_feature_element(feature_el)
        super(feature_el)
        lines = feature_el.feature.name.split(/\r?\n/)
        dashed_name = lines[0].gsub(/\s+/, "-")
        @builder.a(:name => dashed_name)
      end
    end
  end
end