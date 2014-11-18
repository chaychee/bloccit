require 'rails_helper'

describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or as values" do
        expect ( Vote.new(value: 1).valid? ).to eq(true)      
        expect ( Vote.new(value: -1).valid? ).to eq(true)
        expect ( Vote.new(value: 2).valid? ).to eq(false)
      end
    end
  end
end
