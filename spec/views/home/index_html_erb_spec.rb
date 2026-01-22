require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  before do
    allow(view).to receive(:user_signed_in?).and_return(false)
    allow(I18n).to receive(:locale).and_return(:en)
  end

  it "renders the home page layout" do
    render

    expect(rendered).to include("StockMate")
  end

  it "renders the home page background" do
    render

    expect(rendered).to include("bg-gray-900")
  end

  it "includes navigation links" do
    render

    expect(rendered).to include(I18n.t('home.nav.product'))
  end

  it "includes hero section" do
    render
    expect(rendered).to include(I18n.t('home.hero.title'))
  end
end
