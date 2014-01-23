Wit = require "../src/node-wit.coffee"

describe "Wit", ->
	access_token = process.env.WIT_ACCESS_TOKEN
	wit = new Wit(access_token)

	it "Should have a default URL", ->
		expect(wit.access_token).toEqual(access_token)

	it "Should have set a URL", ->
		witCustom = new Wit(access_token, "http://foobar.com")
		expect(witCustom.uri).toEqual('http://foobar.com')

	it "Should get a valid result when processing a message", (done) ->
		options = 
			user_text: 'Hello world'
		wit.analyze options, (err, res, body) ->
			data = JSON.parse body
			expect(res.statusCode).toEqual(200)
			expect(data.msg_body).toEqual("Hello world")
			expect(data.outcome.intent).toEqual("hello")
			done()

	it "Should get a valid result when processing an audio message", (done) ->
		options = 
			user_text: 'Hello world'
			audio_file: './audio_sample/helloWorld.wav'
		wit.analyze options, (err, res, body) ->
			data = JSON.parse body
			expect(res.statusCode).toEqual(200)
			expect(data.msg_body).toEqual("hello world")
			expect(data.outcome.intent).toEqual("hello")
			done()
