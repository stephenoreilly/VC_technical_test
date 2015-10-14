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

  scenario "Check that the User initally only has no Badges" do

    visit "/users"
    click_link "Show"

    expect(page).not_to have_content("SpeedRun")
    expect(page).not_to have_content("Half-Way")
    expect(page).not_to have_content("All-Way")
    expect(page).to have_content("Current Logged User is : Thomas")
  end

  scenario "Check that the User gets SpeedRun Badge after watching video" do

    visit "/videos"
    all(:link, 'Show')[3].click
    click_link "Play"
    visit "/users"
    click_link "Show"

    expect(page).to have_content("SpeedRun")
    expect(page).not_to have_content("Half-Way")
    expect(page).not_to have_content("All-Way")
  end

  scenario "Check that the User gets Half-way Badge after watching 2 videos" do

    visit "/videos"
    all(:link, 'Show')[0].click
    click_link "Play"
    click_link "Back"
    all(:link, 'Show')[2].click
    click_link "Play"
    click_link "users"
    click_link "Show"

    expect(page).to have_content("Half-Way")
    expect(page).not_to have_content("SpeedRun")
    expect(page).not_to have_content("All-Way")
  end

  scenario "Check that the User gets All-way Badge after watching all videos" do

    visit "/videos"
    all(:link, 'Show')[0].click
    click_link "Play"
    click_link "Back"
    all(:link, 'Show')[1].click
    click_link "Play"
    click_link "Back"
    all(:link, 'Show')[2].click
    click_link "Play"
    click_link "Back"
    all(:link, 'Show')[3].click
    click_link "Play"
    click_link "users"
    click_link "Show"
    expect(page).to have_content("Half-Way")
    expect(page).not_to have_content("SpeedRun")
    expect(page).to have_content("All-Way")
  end


end