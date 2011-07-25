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

      # Customize image embedder to make images expanded by default for use in confluence pages
      def embed_image(src, label)
        id = "img_#{@img_id}"
        @img_id += 1
        @builder.span(:class => 'embed') do |pre|
          pre << %{<a href="" onclick="img=document.getElementById('#{id}'); img.style.display = (img.style.display == 'block' ? 'none' : 'block');return false">#{label}</a><br>&nbsp;
          <img id="#{id}" style="display: none" src="#{src}"/>}
        end
      end
    end
  end
end