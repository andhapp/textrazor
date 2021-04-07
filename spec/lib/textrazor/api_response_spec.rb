require 'spec_helper'

module TextRazor

  describe ApiResponse do

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
  end

end
