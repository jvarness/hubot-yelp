# Description
#   Enables hubot to suggest places for lunchtime. Powered by Yelp.
#
# Dependencies:
#   "moment": "^2.10.6",
#   "oauth-signature": "^1.3.0"
# 
# Configurations:
#   HUBOT_YELP_CONSUMER_KEY
#   HUBOT_YELP_CONSUMER_SECRET
#   HUBOT_YELP_TOKEN
#   HUBOT_YELP_TOKEN_SECRET
#   HUBOT_YELP_DEFAULT_LOCATION
#
# Commands:
#   hubot lunchtime - randomly selects a place to eat using the default location
#   hubot lunchtime near <city|state|zip> - randomly selects a place to eat near a specified location.
#   hubot lunchtime thats <term> - randomly selects a place to eat near the default configured location that matches a category.
#   hubot lunchtime near <city|state|zip> thats <term> - randomly selects a place to eat near a specified location matching a category.
#
# Author:
#   Jake Varness, http://github.com/jvarness

oauth = require 'oauth-signature'
moment = require 'moment'

CONSUMER_KEY     = process.env.HUBOT_YELP_CONSUMER_KEY
CONSUMER_SECRET  = process.env.HUBOT_YELP_CONSUMER_SECRET
TOKEN            = process.env.HUBOT_YELP_TOKEN
TOKEN_SECRET     = process.env.HUBOT_YELP_TOKEN_SECRET
DEFAULT_LOCATION = process.env.HUBOT_YELP_DEFAULT_LOCATION

queryYelp = (msg, usrLocation, category) ->
  seconds = moment().unix()
  params = {
    oauth_consumer_key: CONSUMER_KEY,
    oauth_token: TOKEN
    oauth_signature_method:	'HMAC-SHA1',
    oauth_timestamp: seconds,
    oauth_nonce: 'str' + seconds,
    location: usrLocation or DEFAULT_LOCATION or 'Kansas City, MO',
    term: category
  }
  
  signature = oauth.generate('GET', 'https://api.yelp.com/v2/search/', params, CONSUMER_SECRET, TOKEN_SECRET, { encodeSignature: false})
  params.oauth_signature = signature
  
  msg.http('https://api.yelp.com/v2/search/').query(params).get() (err, res, body) ->
    
    if err
      msg.send 'Error :( #{err}'
      return
      
    if res.statusCode isnt 200
      msg.send 'Error :( statusCode ' + res.statusCode + ' body ' + body
      return
        
    response = JSON.parse(body)
    msg.send 'Give this place a shot:'
    randomBusiness = msg.random response.businesses
    msg.send randomBusiness.name 
    msg.send 'Yelp rating: ' + randomBusiness.rating
    msg.send 'Total reviews: ' + randomBusiness.review_count
    msg.send randomBusiness.url 

module.exports = (robot) ->
  robot.respond /lunchtime\W*(near (.*) thats (.*)|near (.*)|thats (.*))?/i, (msg) ->
    matches = msg.match
    usrLocation = matches[2] or matches[4] or ''
    category = matches[3] or matches[5] or ''
    queryYelp(msg, usrLocation.trim(), category.trim())




