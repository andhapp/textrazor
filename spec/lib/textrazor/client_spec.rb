require "spec_helper"

module TextRazor

  describe Client do

    let(:api_key) { 'api_key' }
    let(:client) { custom_options_client }
    let(:nil_api_key_client) { Client.new(nil) }
    let(:empty_api_key_client) { Client.new('') }
    let(:custom_options_client) { 
      Client.new(api_key, { 
        extractors: %w(entities topics words), cleanup_mode: 'raw',
        cleanup_return_cleaned: true, cleanup_return_raw: true,
        filter_dbpedia_types: %w(type1), language: 'fre',
        filter_freebase_types: %w(type2), allow_overlap: false
      }) 
    }
    let(:default_options_client) { Client.new(api_key) }

    describe "#initialize" do

      context 'with valid api key' do

        context "and default request options" do

          it 'assigns correctly' do
            expect(default_options_client.api_key).to eq(api_key)
            expect(default_options_client.request_options).
              to eq({extractors: %w(entities topics words phrases dependency-trees 
                     relations entailments senses), cleanup_mode: 'raw'})
          end

        end

        context 'and custom request options' do
          
          it "assigns correctly" do
            expect(custom_options_client.api_key).to eq(api_key)
            expect(custom_options_client.request_options).
              to eq({extractors: %w(entities topics words), cleanup_mode: 'raw', language: 'fre',
                     cleanup_return_cleaned: true, cleanup_return_raw: true,
                     filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2), 
                     allow_overlap: false})
          end

        end

      end

      context "with invalid api key" do

        context "when nil" do

          it "raises an exception" do
            expect { nil_api_key_client }.
              to raise_error(Client::EmptyApiKey)
          end

        end

        context "when empty" do

          it "raises an exception" do
            expect { empty_api_key_client }.
              to raise_error(Client::EmptyApiKey)
          end

        end

      end

      context 'with invalid request options' do

        context 'when an invalid extractor value is supplied' do

          it 'raises an exception' do
            expect { Client.new(api_key, {extractors: ['invalid-extractor', 'topics']}) }.
              to raise_error(Client::UnsupportedExtractor)
          end

        end

        context 'when an invalid cleanup_mode value is supplied' do

          it 'raises an exception' do
            expect { Client.new(api_key, {cleanup_mode: 'invalid-cleanup-mode'}) }.
              to raise_error(Client::UnsupportedCleanupMode)
          end
          
        end

      end

    end

    context "#analyse" do

      let(:very_long_text) { "L" * 201 * 1024 }

      context "valid value of 'text'" do

        it "makes correct calls" do
          request = BasicObject.new

          expect(Request).to receive(:post).
            with('text', {api_key: 'api_key', extractors: %w(entities topics words), cleanup_mode: 'raw',
                          cleanup_return_cleaned: true, cleanup_return_raw: true, language: 'fre', 
                          filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2), 
                          allow_overlap: false}).
            and_return(request)

          expect(Response).to receive(:new).with(request)

          client.analyse('text')
        end

      end

      context "invalid value of 'text'" do

        context "when nil" do

          it "raises an exception" do
            expect { client.analyse(nil) }.
              to raise_error(Client::EmptyText)
          end

        end

        context "when empty" do

          it "raises an exception" do
            expect { client.analyse('') }.
              to raise_error(Client::EmptyText)
          end

        end

        context "when size is > 200kb" do

          it "raises an exception" do
            expect { client.analyse(very_long_text) }.
              to raise_error(Client::TextTooLong)
          end

        end

      end

    end

    context ".topics" do

      it "makes correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new topics: ['topic1'], coarseTopics: ['topic1']

        expect(Client).to receive(:new).
          with(api_key, {extractors: ['topics']}).
          and_return(client)

        expect(client).to receive(:analyse).
          with("text").
          and_return(response)

        Client.topics(api_key, 'text', {})
      end

    end

    context ".coarse_topics" do

      it "makes correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new topics: ['topic1'], coarseTopics: ['topic1']

        expect(Client).to receive(:new).
          with(api_key, {extractors: ['topics']}).
          and_return(client)

        expect(client).to receive(:analyse).
          with("text").
          and_return(response)

        Client.topics(api_key, 'text', {})
      end

    end

    context ".entities" do

      it "makes correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new entities: ['Entity1']

        expect(Client).to receive(:new).
          with(api_key, {extractors: ['entities']}).
          and_return(client)

        expect(client).to receive(:analyse).
          with("text").
          and_return(response)

        Client.entities(api_key, 'text', {})
      end

    end

    context ".words" do

      it "makes correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new words: ['Word1']

        expect(Client).to receive(:new).
          with(api_key, {extractors: ['words']}).
          and_return(client)

        expect(client).to receive(:analyse).
          with("text").
          and_return(response)

        Client.words(api_key, 'text', {})
      end

    end

    context ".phrases" do

      it "makes correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new phrases: ['Phrase1']

        expect(Client).to receive(:new).
          with(api_key, {extractors: ['phrases', 'words']}).
          and_return(client)

        expect(client).to receive(:analyse).
          with("text").
          and_return(response)

        Client.phrases(api_key, 'text', {})
      end

    end

  end

end
