require 'spec_helper'

describe TextRazor do

  context ".topics" do

    it "should make correct calls" do
      TextRazor::Client.should_receive(:topics).
        with('api_key', 'text', {})

      TextRazor.topics('api_key', 'text', {})
    end

  end

  context ".entities" do

    it "should make correct calls" do
      TextRazor::Client.should_receive(:entities).
        with('api_key', 'text', {})

      TextRazor.entities('api_key', 'text', {})
    end

  end

  context ".words" do

    it "should make correct calls" do
      TextRazor::Client.should_receive(:words).
        with('api_key', 'text', {})

      TextRazor.words('api_key', 'text', {})
    end

  end

end
