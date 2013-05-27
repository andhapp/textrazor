require 'spec_helper'

describe TextRazor do

  context ".topics" do

    it "should make correct calls" do
      TextRazor::Client.should_receive(:topics).
        with('api_key', 'text', {})

      TextRazor.topics('api_key', 'text', {})
    end

  end

end
