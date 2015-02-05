require 'redcarpet'

module MosCarpet::MarkdownProcessor
  module ModuleMethods
    def to_html(text)
      markdown.render(text)
    end

    def markdown
      Redcarpet::Markdown.new(media, options)
    end

    def media
      MosCarpet::MarkdownRenderer.new(
        filter_html: false,
        hard_wrap: true
      )
    end

    def options
      {
        autolink: true,
        tables: true,
        no_intraemphasis: true,
        fenced_code_blocks: true,
        space_after_headers: false
      }
    end
  end

  extend ModuleMethods
end
