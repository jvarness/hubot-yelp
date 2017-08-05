# Description
#   Enables hubot to suggest places for lunchtime. Powered by Yelp.
#
# Dependencies:
#   @"yelpv3": "^1.2.1"
# 
# Configurations:
#   HUBOT_YELP_APP_ID
#   HUBOT_YELP_APP_SECRET
#   HUBOT_YELP_DEFAULT_LOCATION
#   HUBOT_YELP_DEFAULT_CATEGORY
#
# Commands:
#   hubot lunchtime - randomly selects a place to eat using the default location
#   hubot lunchtime near <city|state|zip> - randomly selects a place to eat near a specified location.
#   hubot lunchtime thats <term> - randomly selects a place to eat near the default configured location that matches a category.
#   hubot lunchtime near <city|state|zip> thats <term> - randomly selects a place to eat near a specified location matching a category.
#
# Author:
#   Jake Varness, http://github.com/jvarness

yelpv3 = require 'yelpv3'

APP_ID           = process.env.HUBOT_YELP_APP_ID
APP_SECRET       = process.env.HUBOT_YELP_APP_SECRET
DEFAULT_LOCATION = process.env.HUBOT_YELP_DEFAULT_LOCATION
DEFAULT_CATEGORY = process.env.HUBOT_YELP_DEFAULT_CATEGORY
DEFAULT_LANG     = process.env.HUBOT_YELP_DEFAULT_LANG

queryYelp = (msg, usrLocation, category) ->
  yelp = new yelpv3({
    app_id: APP_ID,
    app_secret: APP_SECRET
  })
  params = {
    location: usrLocation or DEFAULT_LOCATION or 'Kansas City, MO',
    term: category or DEFAULT_CATEGORY
    locale: DEFAULT_LANG or 'en_US'
  }

  yelp.search (params)
    .then (response) ->
      data = JSON.parse response
      if data.businesses.length > 0
        randomBusiness = msg.random data.businesses
        message = """
          Give this place a shot:
          #{ randomBusiness.name  }
          Yelp rating: #{ randomBusiness.rating }
          Total reviews: #{ randomBusiness.review_count }
          #{ randomBusiness.url }
        """
      else
        msg.send "Couldn't find a place to eat there. Try again."
    .catch (err) ->
      errorDescription = JSON.parse(err.error)['error']['description']
      msg.send "Error :( #{err.statusCode}: #{errorDescription}"

module.exports = (robot) ->
  robot.respond /lunchtime\W*(near (.*) thats (.*)|near (.*)|thats (.*))?/i, (msg) ->
    matches = msg.match
    usrLocation = matches[2] or matches[4] or ''
    category = matches[3] or matches[5] or ''
    queryYelp(msg, usrLocation.trim(), category.trim())
