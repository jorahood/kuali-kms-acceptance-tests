module CustomMatchers
  # HasContentOnce was copied and modified from webrat/core/matchers/have_content
  class HasContentOnce #:nodoc:
    def initialize(content)
      @content = content
    end

    def matches?(stringlike)
      @document = Webrat::XML.document(stringlike)
      @element = @document.inner_text

      @number_of_matches = @element.scan(@content).length
      @number_of_matches == 1 #one match exactly
    end

    # ==== Returns
    # String:: The failure message.
    def failure_message
      "expected the following element's content to match once, but it matched #{@number_of_matches} times:\n#{squeeze_space(@element)}"
    end

    # ==== Returns
    # String:: The failure message to be displayed in negative matches.
    def negative_failure_message
      "expected the following element's content to not match once:\n#{squeeze_space(@element)}"
    end

    def squeeze_space(inner_text)
      inner_text.gsub(/^\s*$/, "").squeeze("\n")
    end

  end

  # Matches the contents of an HTML document with
  # whatever string is supplied
  def contain_once(content)
    HasContentOnce.new(content)
  end

end
