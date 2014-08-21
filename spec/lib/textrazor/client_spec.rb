require "spec_helper"

module TextRazor

  describe Client do

    let(:api_key) { 'api_key' }
    let(:client) { custom_options_client }
    let(:nil_api_key_client) { Client.new(nil) }
    let(:empty_api_key_client) { Client.new('') }
    let(:custom_options_client) { Client.new(api_key, {extractors: %w(entities topics words),
                                    cleanup_html: true, filter_dbpedia_types: %w(type1),
                                    language: 'fre',
                                    filter_freebase_types: %w(type2)}) }
    let(:default_options_client) { Client.new(api_key) }

    context "#initialize" do

      context "valid parameters" do

        it "should assign correct api_key, text and default options" do
          expect(default_options_client.api_key).to eq(api_key)
          expect(default_options_client.request_options).
            to eq({extractors: %w(entities topics words phrases dependency-trees relations entailments senses)})
        end

        it "should assign correct api_key, text and passed in options" do
          expect(custom_options_client.api_key).to eq(api_key)
          expect(custom_options_client.request_options).
            to eq({extractors: %w(entities topics words), cleanup_html: true, language: 'fre',
                   filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2)})
        end

      end

      context "invalid parameters" do

        context "api_key" do

          context "is nil" do

            it "should raise an exception" do
              expect { nil_api_key_client }.
                to raise_error(Client::EmptyApiKey)
            end

          end

          context "is empty" do

            it "should raise an exception" do
              expect { empty_api_key_client }.
                to raise_error(Client::EmptyApiKey)
            end

          end

        end

      end

    end

    context "#analyse" do

      let(:very_long_text) { "L" * 201 * 1024 }

      context "valid parameters" do

        it "should make correct calls" do
          request = Object.new

          Request.should_receive(:post).
            with('text', {api_key: 'api_key', extractors: %w(entities topics words), cleanup_html: true,
                          language: 'fre', filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2)}).
            and_return(request)

          Response.should_receive(:new).with(request)

          client.analyse('text')
        end

      end

      context "invalid parameters" do

        context "text" do

          context "is nil" do

            it "should raise an exception" do
              expect { client.analyse(nil) }.
                to raise_error(Client::EmptyText)
            end

          end

          context "is empty" do

            it "should raise an exception" do
              expect { client.analyse('') }.
                to raise_error(Client::EmptyText)
            end

          end

          context "size is > 200kb" do

            it "should raise an exception" do
              expect { client.analyse(very_long_text) }.
                to raise_error(Client::TextTooLong)
            end

          end

        end

      end

    end

    context ".topics" do

      it "should make correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new topics: ['topic1'], coarseTopics: ['topic1']

        Client.should_receive(:new).
          with(api_key, {extractors: ['topics']}).
          and_return(client)

        client.should_receive(:analyse).
          with("text").
          and_return(response)

        Client.topics(api_key, 'text', {})
      end

    end

    context ".coarse_topics" do

      it "should make correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new topics: ['topic1'], coarseTopics: ['topic1']

        Client.should_receive(:new).
          with(api_key, {extractors: ['topics']}).
          and_return(client)

        client.should_receive(:analyse).
          with("text").
          and_return(response)

        Client.topics(api_key, 'text', {})
      end

    end

    context ".entities" do

      it "should make correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new entities: ['Entity1']

        Client.should_receive(:new).
          with(api_key, {extractors: ['entities']}).
          and_return(client)

        client.should_receive(:analyse).
          with("text").
          and_return(response)

        Client.entities(api_key, 'text', {})
      end

    end

    context ".words" do

      it "should make correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new words: ['Word1']

        Client.should_receive(:new).
          with(api_key, {extractors: ['words']}).
          and_return(client)

        client.should_receive(:analyse).
          with("text").
          and_return(response)

        Client.words(api_key, 'text', {})
      end

    end

    context ".phrases" do

      it "should make correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new phrases: ['Phrase1']

        Client.should_receive(:new).
          with(api_key, {extractors: ['phrases', 'words']}).
          and_return(client)

        client.should_receive(:analyse).
          with("text").
          and_return(response)

        Client.phrases(api_key, 'text', {})
      end

    end

  end

end
