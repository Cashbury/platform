![Cashbury Logo](http://www.cashbury.com/images/home/cashbery-hp-logo.png?1316340230) 

## Platform Docs : Mobile API

#### TODO: FIX: https://gist.github.com/4506402 (RAILS Security Vulnerability)

##### Author: Jasdeep Singh
##### Email: narang.jasdeep@gmail.com
##### Web: cashbury.com

## Available Resources:

* Users
* Business
* Location

## 1. Users :man:

### Available Methods:

* Create (Signup)
* Getting Access Token
* Reset Password

#### Create (Signup)

`POST /api/v1/users.json`

**REQUEST:**

```
user[first_name] = 'Jasdeep'
user[last_name]  = 'Narang'
user[email]      = 'narang.jasdeep@gmail.com'
user[password]   = 'iamadmin'
```

**RESPONSE:**

```javascript
{
  "first_name" : "Jasdeep",
  "last_name" : "Narang",
  "email" : "narang.jasdeep@me.com"
}
```

#### Getting Access Token

`POST /api/v1/sessions.json`

**REQUEST:**

```
user[email]      = 'narang.jasdeep@gmail.com'
user[password]   = 'iamadmin'
```

**RESPONSE:**

```javascript
{
  "email" : "narang.jasdeep@me.com",
  "authentication_token" : "783650b82a2fed959599b40dc5b06c16e3c82e3e00a78c84"
}
```

#### Password Reset

`POST /api/v1/password_resets.json`

**REQUEST:**
```javascript
email   =  'narang.jasdeep@gmail.com'
```

**RESPONSE:**
`If email address exists in our system:`

```javascript
{
  "message" : "A password reset instructions email has been sent at the email address you provided"
}
```

`If email address is not found:`
```

```

----

## 2. Business :office:

### Available Methods:

* Create Business
* Reset Business PIN

#### Create (Signup)

`POST /api/v1/businesses.json`

**REQUEST:**

```
business[name]         = 'Starbucks'
business[subdomain]    = 'starbucks'
business[legal_name]   = 'Starbucks Inc.'
business[state]        = 'initial_state'
business[description]  = 'Some text description'
business[master_pin]   = '9990'
```

**RESPONSE:**

```javascript
{
  "id" : 4,
  "name" : "Starbucks",
  "legal_name" : "Starbucks Inc.",
  "description" : "this is starbucks",
  "featured" : null,
  "created_at" : "2013-01-10T05:12:17Z",
  "updated_at" : "2013-01-10T05:12:17Z"
}
```

#### Reset Business PIN

`PUT /api/v1/business_pin/:business_id.json`

**REQUEST**

```javascript
business[id]          = 10
business[master_pin]  = 9999 
```

**RESPONSE:**

```javascript
{
  "messages" : [
    "Successfully updated your Master PIN"
  ]
}
```

----

## 3. Locations

### Available Methods:

* Create Location

`POST /api/v1/locations.json`

**REQUEST:**
```javascript
location[state] = ON
location[is_mobile] = true
location[street_address] = 49 Avalanche Cres
location[name] = Toronto Location
location[description] = some description
location[country] = Canada
location[business_id] = 1
location[city] = Brampton
location[postal_code] = L6P 1L8
location[featured_image] = http://google.com/image.jpg
```

**RESPONSE:**
```javascript
{
  "id" : 3,
  "name" : "Toronto Location",
  "address" : "49 avalanche cres, brampton, on, l6p1l8",
  "description" : "some description",
  "featured_image" : "http://goole.com/image.jpg",
  "created_at" : "2013-01-11T02:24:44Z",
  "updated_at" : "2013-01-11T02:24:44Z",
  "latitude" : null,
  "longitude" : null,
  "business" : {
    "id" : 4,
    "name" : "Starbucks",
    "legal_name" : "Starbucks Inc.",
    "description" : "this is starbucks",
    "featured" : null,
    "created_at" : "2013-01-10T05:12:17Z",
    "updated_at" : "2013-01-10T05:12:17Z"
  }
}
```