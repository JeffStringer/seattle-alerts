require 'spec_helper'

describe 'Static Pages' do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content('city of Seattle') }
    it { should have_title(full_title(page_title)) }
  end

  describe "Main page" do
    before { visit root_path }
    let(:page_title) { '' }

    it { should have_content('Explore the map') }
    it { should have_css('div#map_canvas') }
    it { should have_css('div#tweets') }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Main') }
  end

  describe 'About page' do
    before { visit about_path }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
    it { should have_content('Seattle Alerts') }
  end

  describe 'Contact page' do
    before { visit contact_path }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
    it { should have_content('Contact us!') }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Seattle Alerts"
    expect(page).to have_title(full_title(''))
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
  end
end
