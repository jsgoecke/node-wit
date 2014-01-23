Wit = require '../lib/node-wit.coffee'

wit = new Wit(process.env.WIT_ACCESS_TOKEN)

# Audio file
options =
	audio_file: './audio_sample/helloWorld.wav'

wit.analyze options, (err, res, body) ->
	if err
		console.log err
	else
		console.log JSON.parse body

	# Simple text
	options = 
		user_text: 'Hello world'

	wit.analyze options, (err, res, body) ->
		if err
			console.log err
		else
			console.log JSON.parse body

