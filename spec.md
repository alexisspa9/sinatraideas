# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - install sinatra gem
- [x] Use ActiveRecord for storing information in a database - installed activerecord gem
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) - created 2 tables on for users one for ideas
- [x] Include at least one has_many relationship on your User model (x has_many y, e.g. User has_many Posts) -added hasmany to users belongs to to ideas
- [x] Include at least one belongs_to relationship on another model (x belongs_to y, e.g. Post belongs_to User)
- [x] Include user accounts - user model is structuredas a user account
- [x] Ensure that users can't modify content created by other users - ideas user id must be equal to currentuser id
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - create templates and actions for crud
- [x] Include user input validations - used active record validations at the models
- [ ] Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
