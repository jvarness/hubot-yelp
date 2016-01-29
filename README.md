## hubot-yelp

Enables hubot to suggest places for lunchtime.

See [`src/lunchtime.coffee`](src/lunchtime.coffee) for full documentation.

## Build and Static Analysis

[![Build Status](https://travis-ci.org/jvarness/hubot-yelp.svg)](https://travis-ci.org/jvarness/hubot-yelp)
[![Codacy Badge](https://api.codacy.com/project/badge/6a56acb4d30644a3993e44199033c029)](https://www.codacy.com/app/jvarness/hubot-yelp)

## Installation

In hubot project repo, run:

`npm install hubot-yelp --save`

Then add **hubot-yelp** to your `external-scripts.json`:

```json
[
  "hubot-yelp"
]
```

## Configuration

The following configuration is required in order to run the yelp script:

```coffeescript
HUBOT_YELP_CONSUMER_KEY       # The Yelp API consumer key
HUBOT_YELP_CONSUMER_SECRET    # The Yelp API consumer secret
HUBOT_YELP_TOKEN              # The Yelp API consumer token
HUBOT_YELP_TOKEN_SECRET       # The Yelp API token secret
```

All of these should be configured using the API keys given to you when you signed up for a Yelp Developer API account.

The following configurations are optional:

```coffeescript
HUBOT_YELP_DEFAULT_LOCATION   # The default location that should be used
HUBOT_YELP_DEFAULT_CATEGORY   # The default category that should be used
HUBOT_YELP_DEFAULT_LANG       # The default language that should be used
```

If a location is not specified, the script is hard-coded to use Kansas City, MO as the default location. If no 
default category is specified, no category will be used unless specified by the user.If a language is not specified, 
the script is hard-coded to use en as the default language.

## Sample Interaction

The hubot-yelp script will allow your hubot to look up different kinds of food for you. By using `hubot lunchtime`, hubot
will find a random place to eat using the default location:

```
<You> hubot lunchtime
<hubot> Give this place a shot:
<hubot> Novel Restaurant
<hubot> Yelp rating: 4.5
<hubot> Total reviews: 133
<hubot> http://www.yelp.com/biz/novel-restaurant-kansas-city
```

This script makes it possible to specify any location to find food. Type `hubot lunchtime thats ` 
to call the script, then specify a category of food:

```
<You>hubot lunchtime thats bbq
<hubot> Give this place a shot:
<hubot> BRGR Kitchen + Bar
<hubot> Yelp rating: 4
<hubot> Total reviews: 165
<hubot> http://www.yelp.com/biz/brgr-kitchen-bar-kansas-city
```

The lunchtime script will randomly select a place that matches the category you specified, and print out the name of the place,
the rating out of 5 on Yelp, how many reviews the place has been given by Yelp users, and a link to the Yelp website containing 
reviews, directions, hours of operation, and more.

If you'd rather not specify a category and would rather find a place near a certain location, you can specify that 
by typing `hubot lunchtime near ` and specifying a location:

```
<You> hubot lunchtime near Las Vegas, NV
<hubot> Give this place a shot:
<hubot> Fountains of Bellagio
<hubot> Yelp rating: 4.5
<hubot> Total reviews: 940
<hubot> http://www.yelp.com/biz/fountains-of-bellagio-las-vegas
```

The script also allows you to specify a place and a category by typing `hubot lunchtime near <place> thats <category>`:

```
<You> hubot lunchtime near 99206 thats seafood
<hubot> Give this place a shot:
<hubot> Ivar's Seafood Bars
<hubot> Yelp rating: 3
<hubot> Total reviews: 1
<hubot> http://www.yelp.com/biz/ivars-seafood-bars-spokane
```

## Powered by

[![Yelp](https://s3-media3.fl.yelpcdn.com/assets/srv0/developer_pages/65526d1a519b/assets/img/Powered_By_Yelp_Red.png)](https://www.yelp.com/developers)

[![CoffeeScript](http://coffeescript.org/documentation/images/logo.png)](http://coffeescript.org/)

[Hubot](https://hubot.github.com/)
