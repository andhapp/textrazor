require "spec_helper"

module TextRazor

  describe Client do

    let(:text) { 'text' }
    let(:api_key) { 'api_key' }
    let(:nil_text_instance) { Client.new(api_key, nil) }
    let(:empty_text_instance) { Client.new(api_key, '') }
    let(:nil_api_key_instance) { Client.new(nil, '') }
    let(:empty_api_key_instance) { Client.new('', '') }
    let(:very_long_text_instance) { Client.new(api_key, text_with_byte_size_1 * 201 * 1024)}
    let(:custom_options_instance) { Client.new(api_key, text, {extractors: %w(entities topics words),
                                    cleanup_html: true, filter_dbpedia_types: %w(type1),
                                    filter_freebase_types: %w(type2)}) }
    let(:default_options_instance) { Client.new(api_key, text) }
    let(:text_with_byte_size_1) { "L" }

    context "#initialize" do

      context "valid parameters" do

        it "should assign correct api_key, text and default options" do
          expect(default_options_instance.api_key).to eq('api_key')
          expect(default_options_instance.text).to eq('text')
          expect(default_options_instance.extractors).to eq(%w(entities topics words dependency-trees relations entailments))
          expect(default_options_instance.cleanup_html).to be_false
          expect(default_options_instance.filter_dbpedia_types).to eq([])
          expect(default_options_instance.filter_freebase_types).to eq([])
        end

        it "should assign correct api_key, text and passed in options" do
          expect(custom_options_instance.api_key).to eq('api_key')
          expect(custom_options_instance.text).to eq('text')
          expect(custom_options_instance.extractors).to eq(%w(entities topics words))
          expect(custom_options_instance.cleanup_html).to be_true
          expect(custom_options_instance.filter_dbpedia_types).to eq(%w(type1))
          expect(custom_options_instance.filter_freebase_types).to eq(%w(type2))
        end

      end

      context "invalid parameters" do

        context "api_key" do

          context "is nil" do

            it "should raise an exception" do
              expect { nil_api_key_instance }.
                to raise_error(TextRazor::EmptyApiKey)
            end

          end

          context "is empty" do

            it "should raise an exception" do
              expect { empty_api_key_instance }.
                to raise_error(TextRazor::EmptyApiKey)
            end

          end

        end

        context "text" do

          context "is nil" do

            it "should raise an exception" do
              expect { nil_text_instance }.
                to raise_error(TextRazor::EmptyText)
            end

          end

          context "is empty" do

            it "should raise an exception" do
              expect { empty_text_instance }.
                to raise_error(TextRazor::EmptyText)
            end

          end

          context "size is > 200kb" do

            it "should raise an exception" do
              expect { very_long_text_instance }.
                to raise_error(TextRazor::TextTooLong)
            end

          end

        end


      end

    end

  end

end
