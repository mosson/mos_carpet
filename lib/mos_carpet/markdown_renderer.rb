require 'redcarpet'

class MosCarpet::MarkdownRenderer < Redcarpet::Render::HTML
  def postprocess(text)
    process_methods.inject(utf8(text)) do |mem, process|
      send process, mem
    end
  end

  def utf8(text)
    text.force_encoding('UTF-8')
  end

  def process_methods
    [:process_youtube, :process_vimeo, :process_slideshare]
  end

  def process_youtube(text)
    return text unless include_youtube?(text)
    text.gsub! pattern_youtube, html_youtube
  end

  def process_vimeo(text)
    return text unless include_vimeo?(text)
    text.gsub! pattern_vimeo, html_vimeo
  end

  def process_slideshare(text)
    return text unless include_slideshare?(text)
    text.gsub! pattern_slideshare, html_slideshare
  end

  def html_youtube
    @html_youtube ||= %q(
      <div class="video-container">
        <iframe src="//www.youtube.com/embed/\1"
                frameborder="0"
                allowfullscreen></iframe>
      </div>
    )
  end

  def html_vimeo
    @html_vimeo ||= %q(
      <div class="video-container">
        <iframe class="embedded"
                src="//player.vimeo.com/video/\1"
                frameborder="0"
                allowFullScreen></iframe>
      </div>
    )
  end

  def html_slideshare
    @html_slideshare ||= %q(
      <div class="video-container">
        <iframe class="embedded"
                src="//www.slideshare.net/slideshow/embed_code/\1"
                frameborder="0"
                allowFullScreen></iframe>
      </div>
    )
  end

  def include_youtube?(text)
    pattern_youtube =~ text
  end

  def include_vimeo?(text)
    pattern_vimeo =~ text
  end

  def include_slideshare?(text)
    pattern_slideshare =~ text
  end

  def pattern_youtube
    @pattern_youtube ||= /youtube\((.+?)\)/
  end

  def pattern_vimeo
    @pattern_vimeo ||= /vimeo\((.*?)\)/
  end

  def pattern_slideshare
    @pattern_slideshare ||= /slideshare\((.*?)\)/
  end
end
