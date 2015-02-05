require 'spec_helper'

describe MosCarpet::MarkdownProcessor do
  describe 'モジュールメソッド' do
    describe '#to_html(text)' do
      it 'textをマークダウンルールにもとづいてhtmlにして返す' do
        expect(described_class.to_html("hoge")).to match("<p>hoge</p>\n")
        expect(described_class.to_html("#hoge")).to match("<h1>hoge</h1>\n")
        
        allow_any_instance_of(MosCarpet::MarkdownRenderer).to receive(:html_youtube).and_return('<img src="\1"/>')
        expect(described_class.to_html("youtube(1234)")).to match("<p><img src=\"1234\"/></p>\n")
        
        allow_any_instance_of(MosCarpet::MarkdownRenderer).to receive(:html_vimeo).and_return('<img src="\1"/>')
        expect(described_class.to_html("vimeo(1234)")).to match("<p><img src=\"1234\"/></p>\n")
        
        allow_any_instance_of(MosCarpet::MarkdownRenderer).to receive(:html_slideshare).and_return('<img src="\1"/>')
        expect(described_class.to_html("slideshare(1234)")).to match("<p><img src=\"1234\"/></p>\n")
      end
    end

    describe '#markdown' do
      it 'Redcarpet::Markdownクラスにmedia, optionをよんで渡す' do
        allow(described_class).to receive(:media).and_return('hoge')
        allow(described_class).to receive(:options).and_return('fuga')
        expect(Redcarpet::Markdown).to receive(:new).with('hoge', 'fuga')
        described_class.markdown
      end
    end

    describe '#media' do
      it 'MosCarpet::MarkdownRendererを新規作成して返す' do
        expect(MosCarpet::MarkdownRenderer).to receive(:new)
        described_class.media
      end
    end

    describe '#options' do
      it 'redcarpetに渡すオプションをHashとして返す' do
        expect(described_class.options).not_to eq nil
        expect(described_class.options).to be_a Hash
      end
    end
  end
end
