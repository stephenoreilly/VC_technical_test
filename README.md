########
Re: My Solution - Stephen O'Reilly

Part 1:

I took a look at the Decorator rkit. It is being used to add the infos method functionality to the Users class.
I didn't see how I could use it in a way that would make it clearer than the method I chose so essentially I ignored the tip and carried on the best way I could.

I created an array with the Users that had the same company as the company selected for the show action.
I then created a Hash from the Array with the badge as the key and the count as the value

The information fromt he Hash table is diplayed by passing the hash table to the view.

Part 2:

As the names of the badges are all "hard-coded" and the test to check whether a Badge should be allocated is very specific to the badge I found it difficult to make this generic.

I have tried to make it as clear as possible what needs to be done in the case of adding a new Badge.

The functionality has been added to the User model. I looked at adding this functionality to the BadgeUser class but this would be effectively making this class "UserBadges" as Badge User only has information partaining to one Badge. As a result I thought it made most sense to add this functionality to the User model.

Part 3:

I thought that adding AJAX to carry out the Play functionality might make it confusing as to what I was trying to do, so instead I went with the method of routing to a "Play" action for the VideoController and the redirecting the User back to the Video Path for that particular Video.

-Adding the "Play" action allows watch_video and increase_iterations to be called within this action

I've added an iterations Column to the VideoUsers table using a migration file. The default for this column is set to 0. I have updated the User>>watch_video _method so that a video is only added to the videos Array if it has not been watched already.

Part 4:

I have added feature tests using Caybara for all the functionality that was requested in Challenge 1..3. These can be run by running command rspec spec/features.

The main challenge I found with this was clicking on the correct 'Show' for videos when testing the functionality of Updating the Badges when a user has has met the correct criteria. I chose to use all(:link, 'Show')[2].click.
This clicks on the element chosen from the Array. This is not the prettiest solution but it does work. This could be changed by changing the 'Show' link to include a reference to the name of the Video but I decided to leave it like this for my solution as I did not want to change the layout too much.


########
## Badge Challenges Application

### Overview of the application

This Application is a small Rails App that can be compared to a tiny Vodeclic App :)

You will find a "Company" model, linked to "User" and those users are also linked to "Video" and to "Badge" models.

A seed is present to let you start with some datas.
The UI Header let you logging as one of the four users present in the seed data.
Once a User is logged-in, accessing the "video#show" action will *link* a Video to the User.


### Challenge 1: Show Badges that belongs to a Company

You need to modify the "companies#show" action in order to show badges associated to a Company (through Users). The view should looks like "users#show":
* Company own a Badge once at least one of its users own one
* For each Badge that an Company own, you will have to show how many users own Badges

Notes:
* CSS Stylesheets is already present in the application and use a "Grid" system. The application use Ruby helpers in order to generate corresponding HTML tags for the grid, take a look at the "users/show" view for some inspiration. You can use any block type collection. Helpers are provided by the [r_kit](https://github.com/Saphyr/r_kit) Gem (code is the documentation!)
* A custom *decorator* logic is already implemented inside the Application - you don't need Gems to do that, if you want to understand how it works take a look at the "user" decorator.


### Challenge 2: Link a Badge to a User

The goal of this challenge is to define a logic that will automatically link a Badge to a User once required conditions are met.
This logic has to be as much flexible as possible because additional Badges could be created internally, with different behaviors, so the integration of those new Badges has to be simple.

Here is the obtained conditions for currently implemented Badges:
* "Halfway" Badge: User has to have viewed at least two videos
* "Allway" Badge: User has to have viewed all videos
* "SpeedRun" Badge: User has to have viewed the "Ruby classes" video only


### Challenge 3: Rebuild the "viewed" mecanism

The current "viewed" logic is too simple, you need to modify it and add a "play" button on the "video#show" view and then only trigger the "viewed" state once User clicked it (*Tips: use simple AJAX*).

This challenge is also a good opportunity to refactor the association between User and Video. For example today once a user watch multiple times the same video we create a new record each time - obviously this is not a great logic - you should add an "iteration" column on the joint table.


### Challenge 4: Adding tests using RSpec / Capybara

Everything is in the title :)


### Additional notes

The "companies" scaffold was once named "compagnies" due to a typo, but don't worry we fixed that for you ;)
