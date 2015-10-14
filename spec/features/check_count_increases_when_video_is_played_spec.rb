require 'rails_helper'

RSpec.feature "Show Badges That Belong to a Company" do
  before do
    videos = Video.create [
                {name: 'Ruby variables'},
                {name: 'Ruby operators'},
                {name: 'Ruby methods'},
                {name: 'Ruby classes'},
              ]

    badges = Badge.create [
      {name: 'Half-Way', fa_symbol: 'bookmark-o'},
      {name: 'All-Way', fa_symbol: 'bookmark'},
      {name: 'SpeedRun', fa_symbol: 'bolt'},
    ]
    company = Company.create(name: 'Vodeclic')
    thomas = User.create(name: 'Thomas', company: company)

    # Login as Thomas
    visit "/users"
    click_link "Thomas"
  end

  scenario "Check that count is set to zero for al videos initially" do

    visit "/videos"

    expect(page).to have_content("Ruby classes	0")
    expect(page).to have_content("Ruby methods	0")
    expect(page).to have_content("Ruby operators	0")
    expect(page).to have_content("Ruby variables	0")
  end

  scenario "Check that count is increased when a video is played and redirected back to video page" do

    visit "/videos"
    all(:link, 'Show')[0].click
    click_link "Play"

    expect(page).to have_content("Count: 1")
    expect(current_path).to eq(video_path(Video.first))
  end

  scenario "Check that count is increased on the video index page" do

    visit "/videos"
    all(:link, 'Show')[0].click
    click_link "Play"

    click_link "Back"

    expect(page).to have_content("Ruby classes	0")
    expect(page).to have_content("Ruby methods	0")
    expect(page).to have_content("Ruby operators	0")
    expect(page).to have_content("Ruby variables	1")
  end

end