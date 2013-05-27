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

      it "should return the topics returned" do
        body = "\n    {\"time\":\"0.013219\",\"response\":{\"language\":\"eng\",\"languageIsReliable\":true,\"topics\":[{\"id\":0,\"label\":\"Airlines \",\"wikiLink\":\"http://en.wikipedia.org/Category:Airlines_by_country\",\"score\":0.199069},{\"id\":1,\"label\":\"Companies \",\"wikiLink\":\"http://en.wikipedia.org/Category:Companies_by_year_of_establishment\",\"score\":0.136068}]}} \n"

        http_response = ::OpenStruct.new code: 200, body: body

        response = Response.new(http_response)

        expect(response.topics.size).to eq(2)
      end

    end

  end

end
