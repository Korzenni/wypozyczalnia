require 'rails_helper'

RSpec.describe ItemCategory, :type => :model do
  let(:item_category) { create(:item_category) }

  subject { item_category }

  it "#as_json returns proper hash" do
    expect(subject.as_json(nil)).to eq({ id: subject.id, text: subject.name })
  end
end
