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
    visit (log_in_path(id: john))
  end


  scenario "Make sure expected badges are present" do
    visit "/companies"

    click_link "Show"
    expect(page).to have_content("Half-Way")
    expect(page).to have_content("All-Way")
  end

  scenario "Make sure unexpected badges are not present" do
    visit "/companies"

    click_link "Show"
    expect(page).not_to have_content("SpeedRun")
  end
  
  

end