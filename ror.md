# Ruby on Rails Challenge

### Overview

Using Ruby on Rails, we'd like you to create a simple experts directory search tool. 

* We suggest starting out by forking this repo to a public one of your own. If you are concerned with the repo being public, this is not required.

* Spend, at max, 4 hours on this project.

* DO NOT USE SCAFFOLDING

### Requirements

The application should fulfill the following requirements:

* I enter a name and a personal website address and a member is created.

* When a member is created, all the heading (h1-h3) values are pulled in from the website to that members profile.

* The website url is shortened (e.g. using http://goo.gl).

* After the member has been added, I can define their friendships with other existing members. Friendships are bi-directional i.e. If David is a friend of Oliver, Oliver is always a friend of David as well.

* The interface should list all members with their name, short url and the number of friends.

* Viewing an actual member should display the name, website URL, shortening, website headings, and links to their friends' pages.

* Now, looking at Alan's profile, I want to find experts in the application who write about a certain topic and are not already friends of Alan.

* Results should show the path of introduction from Alan to the expert e.g. Alan wants to get introduced to someone who writes about 'Dog breeding'. Claudia's website has a heading tag "Dog breeding in Ukraine". Bart knows Alan and Claudia. An example search result would be Alan -> Bart -> Claudia ("Dog breeding in Ukraine").

We encourage the use of gems and libraries for everything except the search functionality, in which we want to see your simple algorithm approach. For the back-end engineers, the front-end just needs to be clean and usable. Do not spend the majority of your time there.

### Submission

Once you've completed the technical requirements, please deploy the code to a free dyno on Heroku (or any free Cloud computing solution) and include the URLs to the repo and the live instance in your submission.
