require 'spec_helper'

module TextRazor

  describe Response do

    let(:http_response) do
      ::OpenStruct.new(code: 200, body: body)
    end

    let(:response) do
      Response.new(http_response)
    end

    describe "#initialize" do

      context "when HTTP response code is 200" do

        it "should create an instance of Response" do
          body = "{\"response\":\"{}\"}"
          http_response = ::OpenStruct.new code: 200, body: body

          expect(JSON).to receive(:parse).
            with(body, {symbolize_names: true}).
            and_return({"response" => "{}"})

          Response.new(http_response)
        end

      end

      context "when HTTP response code is 400" do

        it "should raise an exception" do
          http_response = ::OpenStruct.new code: 400

          expect{ Response.new(http_response) }.
            to raise_error(Response::BadRequest)
        end

      end

      context "when HTTP response code is 401" do

        it "should raise an exception" do
          http_response = ::OpenStruct.new code: 401

          expect{ Response.new(http_response) }.
            to raise_error(Response::Unauthorised)
        end

      end

      context "when HTTP response code is 413" do

        it "should raise an exception" do
          http_response = ::OpenStruct.new code: 413

          expect{ Response.new(http_response) }.
            to raise_error(Response::RequestEntityTooLong)
        end

      end

    end

    describe '#time' do

      it 'returns time taken to process request' do
        body = {time: "0.013219"}.to_json
        http_response = ::OpenStruct.new code: 200, body: body
        response = Response.new(http_response)

        time = response.time

        expect(time).to eq(0.013219)
      end

    end

    describe '#ok?' do

      context 'when successfully analysed' do

        it 'returns true' do
          body = {ok: true}.to_json
          http_response = ::OpenStruct.new code: 200, body: body
          response = Response.new(http_response)

          expect(response).to be_ok
        end

      end

      context 'when unsuccessfully analysed' do

        it 'returns false' do
          body = {ok: false}.to_json
          http_response = ::OpenStruct.new code: 200, body: body
          response = Response.new(http_response)

          expect(response).to_not be_ok
        end

      end

    end

    describe '#custom_annotation_output' do

      it 'returns raw text' do
        body = {
          response: {
            customAnnotationOutput: 'custom annotation output'
          }
        }.to_json

        http_response = ::OpenStruct.new code: 200, body: body
        response = Response.new(http_response)

        expect(response.custom_annotation_output).to eq 'custom annotation output'
      end

    end

    describe '#cleaned_text' do

      it 'returns cleaned text' do
        body = {
          response: {
            cleanedText: 'cleaned text'
          }
        }.to_json

        http_response = ::OpenStruct.new code: 200, body: body
        response = Response.new(http_response)

        expect(response.cleaned_text).to eq 'cleaned text'
      end

    end

    describe '#raw_text' do

      it 'returns raw text' do
        body = {
          response:{
            rawText: 'raw text'
          }
        }.to_json

        http_response = ::OpenStruct.new code: 200, body: body
        response = Response.new(http_response)

        expect(response.raw_text).to eq 'raw text'
      end

    end

    describe 'entailments' do

      let(:http_response) { ::OpenStruct.new(code: 200, body: body) }
      let(:response) { Response.new(http_response) }

      context 'when response has entailments' do

        let(:body) {
          {
            "time"=>"0.013219",
            "response"=>{
              "language"=>"eng",
              "languageIsReliable"=>true,
              "entailments"=>[{
                "id"=>2, "wordPositions"=>[1],
                "entailedWords"=>["misrepresentation"],
                "entailedTree"=>{
                  "word"=>"misrepresentation", "wordId"=>0, "parentRelation"=>-1
                },
                "priorScore"=>0.00132419,
                "contextScore"=>0.0694058,
                "score"=>0.154246
              }]
            }
          }.to_json
        }

        it 'returns entailments' do
          entailments = response.entailments

          expect(entailments).to_not be_nil
          expect(entailments.size).to eq(1)
        end

      end

      context  'when response does not have entailments' do

        let(:body) {
          {
            "time"=>"0.013219",
            "response"=>{
              "language"=>"eng", "languageIsReliable"=>true
            }
          }.to_json
        }

        it 'returns nil' do
          expect(response.entailments).to be_nil
        end

      end

    end

    describe "#topics" do

      let(:http_response) do
        ::OpenStruct.new(code: 200, body: body)
      end

      let(:response) do
        Response.new(http_response)
      end

      context "if there are topics returned from api" do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable" => true,
              "topics" => [
                {
                  "id" => 0,
                  "label" => "Airlines ",
                  "wikiLink" => "http://en.wikipedia.org/Category:Airlines_by_country",
                  "score" => 0.199069
                },
                {
                  "id" => 1,
                  "label" => "Companies ",
                  "wikiLink" => "http://en.wikipedia.org/Category:Companies_by_year_of_establishment",
                  "score" => 0.136068
                }
              ]
            }
          }.to_json
        end

        it "returns topics" do
          topics = response.topics

          expect(topics).to_not be_nil
          expect(topics.size).to eq(2)
        end

      end

      context "if there are no topics returned from api" do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable" => true
            }
          }.to_json
        end

        it "returns nil" do
          expect(response.topics).to be_nil
        end

      end

    end

    describe "#coarse_topics" do

      let(:http_response) do
        ::OpenStruct.new(code: 200, body: body)
      end

      let(:response) do
        Response.new(http_response)
      end

      context "if there are topics returned from api" do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true,
              "coarseTopics"=> [
                {
                  "id"=>0,
                  "label" => "Airlines ",
                  "wikiLink" => "http://en.wikipedia.org/Category:Airlines_by_country",
                  "score"=>0.199069
                },
                {
                  "id"=>1,
                  "label" => "Companies ",
                  "wikiLink" => "http://en.wikipedia.org/Category:Companies_by_year_of_establishment",
                  "score"=>0.136068
                }
              ]
            }
          }.to_json
        end

        it "should return topics" do
          topics = response.coarse_topics

          expect(topics).to_not be_nil
          expect(topics.size).to eq(2)
        end

      end

      context "if there are no topics returned from api" do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true
            }
          }.to_json
        end

        it "should return nil" do
          expect(response.coarse_topics).to be_nil
        end

      end

    end

    describe "#entities" do

      let(:http_response) do
        ::OpenStruct.new(code: 200, body: body)
      end

      let(:response) do
        Response.new(http_response)
      end

      context "if there are any entities returned" do

        let(:body) do
          {
            "time" => "0.013219",
            "response"=>{
              "language" => "eng",
              "languageIsReliable"=>true,
              "entities"=>[
                {
                  "id"=>0,
                  "matchingTokens"=>[0],
                  "entityId" => "European Union",
                  "freebaseTypes" => [
                    "/award/award_winner",
                    "/book/author",
                    "/location/country",
                    "/organization/organization_scope",
                    "/book/book_subject",
                    "/location/dated_location",
                    "/people/ethnicity",
                    "/projects/project_participant",
                    "/location/statistical_region",
                    "/organization/organization",
                    "/organization/organization_member",
                    "/government/governmental_jurisdiction",
                    "/organization/membership_organization",
                    "/internet/website_category",
                    "/internet/website_owner",
                    "business/employer",
                    "/location/location"
                  ],
                  "confidenceScore" => 1.01581,
                  "wikiLink" => "http://en.wikipedia.org/wiki/European_Union",
                  "matchedText" => "eu",
                  "freebaseId" => "/m/02jxk",
                  "relevanceScore"=>0.567223,
                  "entityEnglishId" => "European Union",
                  "startingPos"=>0,
                  "endingPos"=>2
                },
                {
                  "id"=>1,
                  "matchingTokens"=>[1, 2],
                  "entityId" => "Foreign minister",
                  "freebaseTypes"=>["government/government_office_or_title"],
                  "confidenceScore"=>0.897858,
                  "wikiLink" => "http://en.wikipedia.org/wiki/Foreign_minister",
                  "matchedText" => "foreign ministers",
                  "freebaseId" => "/m/01t_55",
                  "relevanceScore"=>0.311479,
                  "entityEnglishId" => "Foreign minister",
                  "startingPos"=>3,
                  "endingPos"=>20
                }
              ]
            }
          }.to_json
        end

        it "should return entities" do
          entities = response.entities

          expect(entities).to_not be_nil
          expect(entities.size).to eq(2)
        end

      end

      context "if there are no entities returned" do

        let(:body) do
          {
            "time" => "0.013219",
            "response"=> {
              "language" => "eng",
              "languageIsReliable" => true
            }
          }.to_json
        end

        it "should return nil" do
          expect(response.entities).to be_nil
        end

      end

    end

    describe "#categories" do

      let(:http_response) do
        ::OpenStruct.new(code: 200, body: body)
      end

      let(:response) do
        Response.new(http_response)
      end

      context "if there are categories returned from api" do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable" => true,
              "categories" => [
                {
                  "id" => 0,
                  "classifierId" => "textrazor_iab",
                  "categoryId" => "IAB11",
                  "label" => "Law, Gov’t & Politics",
                  "score" => 0.809611
                },
                {
                  "id" => 1,
                  "classifierId" => "textrazor_iab",
                  "categoryId" => "IAB11-2",
                  "label" => "Law, Gov’t & Politics>Legal Issues",
                  "score" => 0.61239
                }
              ]
            }
          }.to_json
        end

        it "returns categories" do
          categories = response.categories

          expect(categories).to_not be_nil
          expect(categories.size).to eq(2)
        end

      end

      context "if there are no categories returned from api" do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable" => true
            }
          }.to_json
        end

        it "returns nil" do
          expect(response.categories).to be_nil
        end

      end

    end

    describe "#words" do

      let(:http_response) do
        ::OpenStruct.new(code: 200, body: body)
      end

      let(:response) do
        Response.new(http_response)
      end

      context "if there are any words returned" do

        let(:body) do
         {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable" => true,
              "sentences"=>[
                {
                  "position"=>1,
                  "words"=>[
                    {
                      "position"=>0,
                      "startingPos"=>0,
                      "endingPos"=>3,
                      "stem" => "the",
                      "lemma" => "the",
                      "token" => "The",
                      "partOfSpeech" => "DT"
                    },
                    {
                      "position"=>1,
                      "startingPos"=>4,
                      "endingPos"=>7,
                      "stem" => "two",
                      "lemma" => "two",
                      "token" => "two",
                      "partOfSpeech" => "CD"
                    },
                    {
                      "position"=>2,
                      "startingPos"=>8,
                      "endingPos"=>11,
                      "stem" => "men",
                      "lemma" => "man",
                      "token" => "men",
                      "partOfSpeech" => "NNS"
                    },
                    {
                      "position"=>3,
                      "startingPos"=>12,
                      "endingPos"=>19,
                      "stem" => "accus",
                      "lemma" => "accuse",
                      "token" => "accused",
                      "partOfSpeech" => "VBN"
                    }
                  ]
                }
              ]
            }
          }.to_json
        end

        it "returns words" do
          words = response.words

          expect(words).to_not be_nil
          expect(words.size).to eq(4)
          expect(words.first).to be_instance_of(Word)
        end

      end

      context "if there are no words returned" do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true
            }
          }.to_json
        end

        it "returns nil" do
          expect(response.words).to be_nil
        end

      end

    end

    describe '#properties' do

      let(:http_response) do
        ::OpenStruct.new(code: 200, body: body)
      end

      let(:response) do
        Response.new(http_response)
      end

      context 'if there are properties' do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true,
              "properties" => [
                {
                  "id" => 0,
                  "wordPositions" => [9,10,12],
                  "propertyPositions" => [12]
                }
              ]
            }
          }.to_json
        end

        it 'returns properties' do
          properties = response.properties

          expect(properties).to_not be_nil
          expect(properties.size).to eq(1)
          expect(properties.first).to be_instance_of(Property)
        end

      end

      context 'if there are no properties returned' do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true
            }
          }.to_json
        end

        it 'returns nil' do
          expect(response.properties).to be_nil
        end

      end

    end

    describe '#relations' do

      context 'if there are relations returned' do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true,
              "relations" => [{
                  id: 0,
                  wordPositions: [1, 6],
                  params: [{
                    relation: "SUBJECT",
                    wordPositions: [18, 19, 20, 21]
                  },
                  {
                    relation: "OBJECT",
                    wordPositions: [2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
                  }]
              }]
            }
          }.to_json
        end

        it 'returns relations' do
          relations = response.relations

          expect(relations).to_not be_nil
          expect(relations.size).to eq(1)
          expect(relations.first).to be_instance_of(Relation)
        end

      end

      context 'if there are no relations returned' do

         let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true
            }
          }.to_json
        end

        it 'returns nil' do
          expect(response.relations).to be_nil
        end
      end
    end

    describe '#sentences' do

      context 'if there are sentences returned' do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true,
              "sentences" => [{
                :position=>0,
                :words=>
                 [{
                   :position=>0,
                   :startingPos=>0,
                   :endingPos=>8,
                   :stem=>"barclay",
                   :lemma=>"barclay",
                   :token=>"Barclays",
                   :partOfSpeech=>"NNP",
                   :parentPosition=>1,
                   :relationToParent=>"nsubj"
                 }]
              }]
            }
          }.to_json
        end

        it 'returns sentences' do
          sentences = response.sentences

          expect(sentences).to_not be_nil
          expect(sentences.size).to eq(1)
          expect(sentences.first).to be_instance_of(Sentence)
        end

      end

      context 'if there are no sentences returned' do

        let(:body) do
          {
            "time" => "0.013219",
            "response" => {
              "language" => "eng",
              "languageIsReliable"=>true
            }
          }.to_json
        end

        it 'returns nil' do
          expect(response.sentences).to be_nil
        end

      end

    end

    describe '#language' do

      let(:body) do
        {
          "time" => "0.013219",
          "response" => {
            "language" => "eng",
            "languageIsReliable"=>true
          }
        }.to_json
      end

      it 'returns language' do
        expect(response.language).to eq 'eng'
      end

    end

    describe '#language_is_reliable?' do

      let(:body) do
        {
          "time" => "0.013219",
          "response" => {
            "language" => "eng",
            "languageIsReliable"=>true
          }
        }.to_json
      end

      let(:http_response) do
        ::OpenStruct.new(code: 200, body: body)
      end

      let(:response) do
        Response.new(http_response)
      end

      it 'returns language_is_reliable?' do
        expect(response).to be_language_is_reliable
      end

    end

  end

end
