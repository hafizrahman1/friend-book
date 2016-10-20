# Friend-book
Login with Facebook

The app communicates with the Facebook API, allowing users to sign in using their Facebook account. This uses devise and the omniauth gem to ensure easy and secure authentication.

## The overall concept:
The user need to sign in or sign up first to get access to Friend-book web app.
As a guest you can sign in or sign up
After logging in, you can post your thoughts.
You can add friends from the Friendbook users, cancel request, delete friend from existing friends
User can post any thoughts and add tags or posts piture as well.
User has their own profile
User can see all the Friendbook users
User can see the post feed for theirs own posts and friends post.

At its current state the project is an MVP, meeting all the requirements of the assessment.

## Requirements:

1. Use RoR
2. Models must include the following relationships
  has_many
  belongs_to
3. has_many :through and a join table
4. The join model must store user submittable attribute
5. Include reasonable validations for the simple attributes
6. At least one class level ActiveRecord scope method
7. Nested form that writes to an associated model through a custom attribute writer.
8. Provide a standard user authentication, including signup, login, logout, and passwords. Can use devise
  Implement Omniauth
9. Make use of a nested resource with the appropriate RESTful URLs
10. Your forms should correctly display validation errors
11. Strive for a DRY rails app.

