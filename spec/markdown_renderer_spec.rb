require 'spec_helper'

describe MosCarpet::MarkdownRenderer do
  let(:media) { described_class.new }

  describe 'メソッド' do
    describe '#postprocess(text)' do
      it 'textをprocess_methodsから返されるメソッドすべてをパイプして処理する' do
        allow(media).to receive(:process_youtube).and_return('hoge')
        allow(media).to receive(:process_vimeo).and_return('fuga')
        allow(media).to receive(:process_slideshare).and_return('piyo')

        expect(media.postprocess('dadan')).to eq 'piyo'
      end
    end

    describe 'utf8(text)' do
      it 'text#force_encodingに\'UTF-8\'を渡して返す' do
        str = 'hoge'
        expect(str).to receive(:force_encoding).with('UTF-8')
        media.utf8(str)
      end
    end

    describe '#process_methods' do
      it 'redcarpetから受け取った文字列にさらに加工するためのメソッドを列挙して配列として返す' do
        expect(media.process_methods).to all(be_a Symbol)
        expect(media.process_methods).to be_a Array
      end
    end

    describe '#process_youtube(text)' do
      it 'include_youtube?(text)がtrueを返さなければtextを返す' do
        allow(media).to receive(:include_youtube?).and_return false
        expect(media.process_youtube('hoge')).to eq 'hoge'
      end

      it '引数textのpattern_youtubeに一致する部分をhtml_youtubeに置きかえて返す' do
        allow(media).to receive(:include_youtube?).and_return(true)
        allow(media).to receive(:pattern_youtube).and_return(/a\((.+?)\)/)
        allow(media).to receive(:html_youtube).and_return('b\1c\1')

        expect(media.process_youtube('a(1234)')).to eq 'b1234c1234'
      end
    end

    describe '#process_vimeo(text)' do
      it 'include_vimeo?(text)がtrueを返さなければtextを返す' do
        allow(media).to receive(:include_vimeo?).and_return false
        expect(media.process_vimeo('hoge')).to eq 'hoge'
      end

      it '引数textのpattern_vimeoに一致する部分をhtml_vimeoに置きかえて返す' do
        allow(media).to receive(:include_vimeo?).and_return(true)
        allow(media).to receive(:pattern_vimeo).and_return(/a\((.+?)\)/)
        allow(media).to receive(:html_vimeo).and_return('b\1c\1')

        expect(media.process_vimeo('a(1234)')).to eq 'b1234c1234'
      end
    end

    describe '#process_slideshare(text)' do
      it 'include_slideshare?(text)がtrueを返さなければtextを返す' do
        allow(media).to receive(:include_slideshare?).and_return false
        expect(media.process_slideshare('hoge')).to eq 'hoge'
      end

      it '引数textのpattern_slideshareに一致する部分をhtml_slideshareに置きかえて返す' do
        allow(media).to receive(:include_slideshare?).and_return(true)
        allow(media).to receive(:pattern_slideshare).and_return(/a\((.+?)\)/)
        allow(media).to receive(:html_slideshare).and_return('b\1c\1')

        expect(media.process_slideshare('a(1234)')).to eq 'b1234c1234'
      end
    end

    describe '#html_youtube' do
      it 'youtubeの埋め込みテンプレートを返す' do
        expect(media.html_youtube).to be_a String
        expect(media.html_youtube.length).not_to eq 0
      end
    end

    describe '#html_vimeo' do
      it 'vimeoの埋め込みテンプレートを返す' do
        expect(media.html_vimeo).to be_a String
        expect(media.html_youtube.length).not_to eq 0
      end
    end

    describe '#html_slideshare' do
      it 'slideshareの埋め込みテンプレートを返す' do
        expect(media.html_slideshare).to be_a String
        expect(media.html_youtube.length).not_to eq 0
      end
    end

    describe '#include_youtube?(text)' do
      it '引数に与えられたtextがpattern_youtubeと一致するかを返す' do
        expect(media.include_youtube?("youtube(1234)")).not_to eq nil
        expect(media.include_youtube?("anitube(1234")).to eq nil
      end
    end

    describe '#include_vimeo?(text)' do
      it '引数に与えられたtextがpattern_youtubeと一致するかを返す' do
        expect(media.include_vimeo?("vimeo(1234)")).not_to eq nil
        expect(media.include_vimeo?("vaiduu(1234")).to eq nil
      end
    end

    describe '#include_slideshare?(text)' do
      it '引数に与えられたtextがpattern_slideshareと一致するかを返す' do
        expect(media.include_slideshare?("slideshare(1234)")).not_to eq nil
        expect(media.include_slideshare?("spaekdeck(1234")).to eq nil
      end
    end

    describe '#pattern_youtube' do
      it 'youtube(...)に一致するためのパターンを返す' do
        expect(media.pattern_youtube =~ 'youtube(1234)').not_to eq nil
        expect(media.pattern_youtube =~ 'anitube(1234').to eq nil
      end
    end

    describe '#pattern_vimeo' do
      it 'vimeo(...)に一致するためのパターンを返す' do
        expect(media.pattern_vimeo =~ 'vimeo(1234)').not_to eq nil
        expect(media.pattern_vimeo =~ 'vaiduu(1234').to eq nil
      end
    end

    describe '#pattern_slideshare' do
      it 'slideshare(...)に一致するためのパターンを返す' do
        expect(media.pattern_slideshare =~ 'slideshare(1234)').not_to eq nil
        expect(media.pattern_slideshare =~ 'slidesharee(1234').to eq nil
      end
    end
  end
end
