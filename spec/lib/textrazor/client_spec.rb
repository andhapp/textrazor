require "spec_helper"

module TextRazor

  describe Client do

    let(:api_key) do
     'api_key'
    end

    let(:client) do
      custom_options_client
    end

    let(:nil_api_key_client) do
      Client.new(nil)
    end

    let(:empty_api_key_client) do
      Client.new('')
    end

    let(:custom_options_client) do
      Client.new(api_key, {
        extractors: %w(entities topics words), cleanup_mode: 'raw',
        classifiers: 'textrazor_newscodes',
        cleanup_return_cleaned: true, cleanup_return_raw: true,
        filter_dbpedia_types: %w(type1), language: 'fre',
        filter_freebase_types: %w(type2), allow_overlap: false,
        dictionaries: %w(test)
      })
    end

    let(:default_options_client) do
      Client.new(api_key)
    end

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
                     allow_overlap: false, dictionaries: %w(test),
                     classifiers: 'textrazor_newscodes'})
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

      let(:very_long_text) do
        "L" * 201 * 1024
      end

      context "valid value of 'text'" do

        it "makes correct calls" do
          request = BasicObject.new

          expect(Request).to receive(:post).
            with(api_key, 'text', extractors: %w(entities topics words), cleanup_mode: 'raw',
                          cleanup_return_cleaned: true, cleanup_return_raw: true, language: 'fre',
                          filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2),
                          allow_overlap: false, dictionaries: %w(test), classifiers: 'textrazor_newscodes').
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

    context "#create_dictionary" do

      it "make correct calls" do
        expect(Request).to receive(:create_dictionary).
          with(api_key, a_kind_of(Dictionary))
        client.create_dictionary("id")
      end

      context "with an invalid dictionary" do

        it "raises an exception" do
          expect { client.create_dictionary('') }.
            to raise_error(Client::InvalidDictionary)
        end
      end
    end

    context "#delete_dictionary" do
      it "make correct calls" do
        expect(Request).to receive(:delete_dictionary).
          with(api_key, "id")
        client.delete_dictionary("id")
      end
    end

    context "#create_dictionary_entries" do

      let(:dictionary_entries_hash) do
        [{text: "text"}]
      end

      it "make correct calls" do
        expect(Request).to receive(:create_dictionary_entries).
          with(api_key, "dictionary_id", all(a_kind_of(DictionaryEntry)))
        client.create_dictionary_entries("dictionary_id", dictionary_entries_hash)
      end

      context "with an invalid dictionary" do

      let(:dictionary_entries_hash) do
        [{ text: '' }]
      end

        it "raises an exception" do
          expect { client.create_dictionary_entries("dictionary_id", dictionary_entries_hash) }.
            to raise_error(Client::InvalidDictionaryEntry)
        end
      end
    end

    context "#delete_dictionary_entry" do
      it "make correct calls" do
        expect(Request).to receive(:delete_dictionary_entry).
          with(api_key, "dictionary_id", "dictionary_entry_id")
        client.delete_dictionary_entry("dictionary_id", "dictionary_entry_id")
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

    context ".categories" do

      it "makes correct calls" do
        client = OpenStruct.new
        response = OpenStruct.new categories: ['Category1']

        expect(Client).to receive(:new).
          with(api_key, {classifiers: ['textrazor_iab']}).
          and_return(client)

        expect(client).to receive(:analyse).
          with("text").
          and_return(response)

        Client.categories(api_key, 'text', {})
      end

    end

  end

end
