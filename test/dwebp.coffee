{DWebp} = require '../src'
data = require './utils/data'

describe 'dwebp', ->

  describe 'dwebp', ->

    it 'should decode images', ->
      webp = new DWebp data.webp
      webp.toBuffer().then (buffer) ->
        buffer.toString('utf8', 1, 4).should.be.equal 'PNG'

    it 'should work without new', ->
      webp = DWebp data.webp
      webp.toBuffer().then (buffer) ->
        buffer.toString('utf8', 1, 4).should.be.equal 'PNG'

    it 'should allow default bin rewriting', ->
      class Webp2 extends DWebp
        @bin: 'cwebp'
      webp = new Webp2 data.jpeg
      webp.toBuffer().then (buffer) ->
        buffer.toString('utf8', 0, 4).should.be.equal 'RIFF'
        buffer.toString('utf8', 8, 12).should.be.equal 'WEBP'

    it 'should accept bin as a constructor option', ->
      webp = new DWebp data.jpeg, 'cwebp'
      webp.toBuffer().then (buffer) ->
        buffer.toString('utf8', 0, 4).should.be.equal 'RIFF'
        buffer.toString('utf8', 8, 12).should.be.equal 'WEBP'

    it 'should report errors', ->
      webp = new DWebp data.corrupt
      webp.toBuffer().then ->
        throw new Error 'Should not be fulfilled'
      , (err) ->
        err.should.be.Error
        err.message.should.match /Status: 3/
        err.message.should.match /\(BITSTREAM_ERROR\)/
