require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
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
    @user = User.create(name: 'Thomas', company: company)
  end
  test "User should be valid" do
    assert @chef.valid?
  end

end
