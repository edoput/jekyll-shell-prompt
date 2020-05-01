module Templated
  def template
    @template ||= Liquid::Template.parse template_contents
  end
  def template_contents
    @template_contents ||= begin
      File.read(template_path)
    end
  end
  def template_path
    @template_path ||= begin
      File.expand_path @template_file, File.dirname(__FILE__)
    end
  end
end
