require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    @notes = assign(:notes, FactoryBot.create_list(:note, 3))
  end

  it "renders a list of notes" do
    render
    for note in @notes do
      assert_select "tr>td", text: note.title
      assert_select "tr>td", text: note.content
    end
  end
end