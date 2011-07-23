module Cucumber
  module Formatter
    class AnchoredHtml < Html
      def before_features(features)
        super(features)
        @builder.title 'KITS KMS Acceptance Tests'
      end

      def before_feature(feature)
        @builder.a(:name => feature.name)
      end
    end
  end
end