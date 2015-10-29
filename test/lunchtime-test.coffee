chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'The hubot-yelp script', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
    require('../src/lunchtime')(@robot)

  describe 'should register a respond listener for', ->
    
    it 'lunchtime near <location> thats <term>', ->
      expect(@robot.respond).to.have.been.calledWith(/(?:lunchtime)\W*(((?:near\W*(.*)\W*)(?:thats\W*(.*)))|(?:near\W*(.*))|(?:thats\W*(.*)))/i)
