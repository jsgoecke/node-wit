class Wit
  constructor: (access_token, uri) ->
    @fs = require 'fs'
    @request = require 'request'
    @access_token = access_token
    @uri = uri || 'https://api.wit.ai'

  ##
  # Analyze text or audio messages
  #
  #       options = 
  #         user_text: 'Hello world'
  #
  #  *OR*
  #
  #       options =
  #         audio_file: './audio_sample/helloWorld.wav'
  #
  #       analyze options, (err, res, body) ->
  #          console.log JSON.parse body
  analyze: (options, callback) ->
    request_options = 
      headers:
        Authorization: "Bearer #{@access_token}"

    if options.audio_file
      request_options.method = 'POST'
      request_options.uri = @uri + '/speech'
      request_options.headers['Content-Type'] = options.content_type || 'audio/wav;rate=8000'
      @fs.readFile options.audio_file, (err, data) =>
        request_options.body = data
        @request request_options, callback
    else
      request_options.method = 'GET'
      request_options.uri = @uri + "/message?q=#{encodeURIComponent(options.user_text)}"
      @request request_options, callback

module.exports = Wit