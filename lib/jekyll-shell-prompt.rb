require "jekyll"
require "jekyll-shell-prompt/version"
require "templated"

module CoreExtensions
  module String
    module Shell
      def is_prompt?(prefix = ">")
        start_with?(prefix)
      end
      def as_prompt(prefix = ">")
        "{% prompt %}{% command #{delete_prefix(prefix)} %}\n"
      end
      def is_out?(prefix = ">")
        not line_prompt?(prefix)
      end
      def as_out
        "{% out #{self} %}"
      end
    end
  end
end

String.include CoreExtensions::String::Shell

module Jekyll
  # the convention is that each line exposing a `>` symbol
  # will be prefixed by a prompt like this
  #
  # user@host$
  #
  # The rest of the text is considered output and is going
  # to be rendered as is.
  #
  # There will be an option to switch the language
  # and have the prompt switch to the appropriate
  # repl convention, e.g. for python
  #
  # >>>
  #
  # Unsolved
  #
  # - Multi line prompts are problematic, I could look for some
  #   conventions like does the line end with characters like `\`
  #   which are used to put a command over more lines. This would be
  #   easy enough for bash but python shows `...` at the beginning
  #   of a multi-line prompt. The alternative would be to have
  #   a {% multi %} ... {% endmulti %} block to make some formatting
  #   easier to implement and still not to bad to write.
  #
  # - Make the prompt customizable by the user, this could be passed
  #   in as an option of could be assigned as a parameter in the shell
  #   block using {% assign shell_prompt = "In [1]:" %} for ipython
  #   or {% assign shell_prompt = "irb(main):001:0>" %} for ruby
  #
  class ShellBlock < Liquid::Block
    @template_file = "./templates/shell.html"

    def initialize(tag_name, markup, tokens)
      super
      @lang = markup
      @text = tokens
    end

    # for each line in the input we figure out the
    # one that are commands and put them in a fancy prompt
    # line while the others are rendered as output
    def render(context)
      text = super(context)
      ShellBlock.template.render!('text' => text.lines)
    end

    class << self
      include Templated
    end
  end 

  class OutTag < Liquid::Tag
    @template_file = "./templates/out.html"

    def initialize(tag_name, text, tokens)
      @text = text.strip
    end 

    def render(context)
      OutTag.template.render('text' => @text)
    end

    class << self
      include Templated
    end
  end

  class ErrTag < Liquid::Tag
    @template_file = "./templates/err.html"

    def initialize(tag_name, text, tokens)
      @text = text
    end 

    def render(context)
      OutTag.template.render('text' => @text)
    end

    class << self
      include Templated
    end
  end

  class CommandTag < Liquid::Tag
    @template_file = "./templates/command.html"

    def initialize(tag_name, text, tokens)
      @text = text.strip
    end 

    def render(context)
      CommandTag.template.render('text' => @text)
    end

    class << self
      include Templated
    end
  end

  class PromptTag < Liquid::Tag
    @template_file = "./templates/prompt.html"

    def initialize(tag_name, text, tokens)
      @text = text.strip
    end 

    def render(context)
      PromptTag.template.render('text' => @text)
    end
    class << self
      include Templated
    end
  end
end

Liquid::Template.register_tag('prompt', Jekyll::PromptTag)
Liquid::Template.register_tag('command', Jekyll::CommandTag)
Liquid::Template.register_tag('out', Jekyll::OutTag)
Liquid::Template.register_tag('err', Jekyll::ErrTag)
Liquid::Template.register_tag('shell', Jekyll::ShellBlock)
