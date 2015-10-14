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
    john = User.create(name: 'Thomas', company: company, videos: videos, badges: badges[0..1])
    mike = User.create(name: 'Guillaume', company: company, videos: videos[0..1], badges: [badges.first])
    visit (log_in_path(id: john))
  end


  scenario "Make sure correct user count for Company Badges" do
    visit "/companies"

    click_link "Show"
    expect(page).to have_content("Half-Way 2")
    expect(page).to have_content("All-Way 1")
  end

end