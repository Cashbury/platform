### User
  - invalid values
    - empty strings
      - should not allow last\_name to be set to "    "
      - should not allow first\_name to be set to "    "
      - should not allow email to be set to "test@domain"
      - should not allow first\_name to be set to "J"
      - should not allow last\_name to be set to "thirty characters long string for last name of a user "
      - should not allow last\_name to be set to "N"
      - should not allow email to be set to "testdomain.com"
      - should not allow first\_name to be set to "thirty characters long string for first name of a user"
      - should not allow last\_name to be set to ""
      - should not allow first\_name to be set to ""
      - should not allow email to be set to "    "
      - should not allow email to be set to ""
      - should not allow email to be set to "test"
  - valid values
    - should allow email to be set to "narang.jasdeep@gmail.com"
    - should allow last\_name to be set to "Narang"
    - should allow first\_name to be set to "Jasdeep"
  - validations
    - should ensure first\_name has a length between 2 and 30
    - should require last\_name to be set
    - should require email to be set
    - should require case sensitive unique value for email
    - should require first\_name to be set
    - should ensure password has a length between 6 and 32
    - should require password to be set
    - should ensure last\_name has a length between 2 and 30

### Business
  - \#create\_new\_for(user)
    - should add admin role for user on the business
    - should setup the postgres schema for this business (PENDING: need to figure out how to test this)
  - \#downcase\_subdomain
    - should downcase subdomain before saving
  - valid values
    - should allow description to be set to "Starbucks is good coffee place"
    - should allow subdomain to be set to "jasdeep"
    - should not allow master\_pin to be set to "12345"
    - should not allow subdomain to be set to "jasdeep singh"
    - should allow master\_pin to be set to "1234"
    - should not allow subdomain to be set to "jasdeep!@\\#$%"
    - should not allow subdomain to be set to "jasdeep @"
    - should not allow subdomain to be set to ".com"
    - should not allow subdomain to be set to "12345678901234567"
    - should not allow subdomain to be set to "co"
    - should allow name to be set to "Starbucks"
    - should allow legal\_name to be set to "Starbucks Canada Inc."
  - validations
    - should require legal\_name to be set
    - should require description to be set
    - should only allow numeric, integer values for master\_pin
    - should require name to be set
    - should ensure legal\_name has a length between 2 and 50
    - should ensure master\_pin has a length of exactly 4
    - should ensure name has a length between 2 and 50
    - should master\_pin have a valid format
    - should require state to be set
    - should ensure subdomain has a length between 3 and 16

### Authentication
  - add some examples to (or delete) /Users/jasdeep/personal/platform/spec/models/authentication\_spec.rb (PENDING: No reason given)

Pending:
  Business#create_new_for(user) should setup the postgres schema for this business
    # need to figure out how to test this
    # ./spec/models/business_spec.rb:64
  Authentication add some examples to (or delete) /Users/jasdeep/personal/platform/spec/models/authentication_spec.rb
    # No reason given
    # ./spec/models/authentication_spec.rb:4

Finished in 7.66 seconds
50 examples, 0 failures, 2 pending

Randomized with seed 54743

