require 'spec_helper'

module TextRazor

  describe Response do

    context "#initialize" do

      context "when HTTP response code is 200" do

        it "should create an instance of Response" do
          body = "{\"response\":\"{}\"}"
          http_response = ::OpenStruct.new code: 200, body: body

          JSON.should_receive(:parse).
            with(body).
            and_return({"response"=>"{}"})

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

    context "#topics" do

      context "if there are topics returned from api" do

        it "should return topics" do
          body = "\n    {\"time\":\"0.013219\",\"response\":{\"language\":\"eng\",\"languageIsReliable\":true,\"topics\":[{\"id\":0,\"label\":\"Airlines \",\"wikiLink\":\"http://en.wikipedia.org/Category:Airlines_by_country\",\"score\":0.199069},{\"id\":1,\"label\":\"Companies \",\"wikiLink\":\"http://en.wikipedia.org/Category:Companies_by_year_of_establishment\",\"score\":0.136068}]}} \n"

          http_response = ::OpenStruct.new code: 200, body: body

          response = Response.new(http_response)

          topics = response.topics

          expect(topics).to_not be_nil
          expect(topics.size).to eq(2)
        end

      end

      context "if there are no topics returned from api" do

        it "should return nil" do
          body = "{\"time\":\"0.013219\",\"response\":{\"language\":\"eng\",\"languageIsReliable\":true}}"

          http_response = ::OpenStruct.new code: 200, body: body

          response = Response.new(http_response)

          expect(response.topics).to be_nil
        end

      end

    end

    context "#entities" do

      context "if there are any entities returned" do

        it "should return entities" do
          body = "{\"time\":\"0.013219\",\"response\":{\"language\":\"eng\",\"languageIsReliable\":true,\"entities\":[{\"id\":0,\"matchingTokens\":[0],\"entityId\":\"European Union\",\"freebaseTypes\":[\"/award/award_winner\",\"/book/author\",\"/location/country\",\"/organization/organization_scope\",\"/book/book_subject\",\"/location/dated_location\",\"/people/ethnicity\",\"/projects/project_participant\",\"/location/statistical_region\",\"/organization/organization\",\"/organization/organization_member\",\"/government/governmental_jurisdiction\",\"/organization/membership_organization\",\"/internet/website_category\",\"/internet/website_owner\",\"business/employer\",\"/location/location\"],\"confidenceScore\":1.01581,\"wikiLink\":\"http://en.wikipedia.org/wiki/European_Union\",\"matchedText\":\"eu\",\"freebaseId\":\"/m/02jxk\",\"relevanceScore\":0.567223,\"entityEnglishId\":\"European Union\",\"startingPos\":0,\"endingPos\":2},{\"id\":1,\"matchingTokens\":[1,2],\"entityId\":\"Foreign minister\",\"freebaseTypes\":[\"government/government_office_or_title\"],\"confidenceScore\":0.897858,\"wikiLink\":\"http://en.wikipedia.org/wiki/Foreign_minister\",\"matchedText\":\"foreign ministers\",\"freebaseId\":\"/m/01t_55\",\"relevanceScore\":0.311479,\"entityEnglishId\":\"Foreign minister\",\"startingPos\":3,\"endingPos\":20}]}}"

          http_response = ::OpenStruct.new code: 200, body: body

          response = Response.new(http_response)

          entities = response.entities

          expect(entities).to_not be_nil
          expect(entities.size).to eq(2)
        end

      end

      context "if there are no entities returned" do

        it "should return nil" do
          body = "{\"time\":\"0.013219\",\"response\":{\"language\":\"eng\",\"languageIsReliable\":true}}"

          http_response = ::OpenStruct.new code: 200, body: body

          response = Response.new(http_response)

          expect(response.entities).to be_nil
        end

      end

    end

  end

end
