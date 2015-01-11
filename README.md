[![Build
Status](https://travis-ci.org/smsohan/api_through_ui.svg?branch=master)](https://travis-ci.org/smsohan/api_through_ui)

# API Through UI


## Why Do you Need it?

My friends, did you ever __document__ a REST API? If you did, chances are, the process was like the following:

* `cURL an API Endpoint` -> `Repeat until it works`
* `Copy the URL, headers, request and response body` -> `Paste somewhere` -> `Remove duplicates` -> `Write description`
* `Repeat for each API Endpoint`

Well, I find this to be laborious and error prone. Friends, instead of this, what if it was as follows:

* Write a test to describe your API


```
    describe 'gists' do

      it "List a user's gists since a time:" do
        response = Github.get '/users/smsohan/gists?since=20140101T00:00:00Z', @common_options
        assert_equal 200, response.code
        refute_nil response.body
      end
    end
```

* And it'd generate a full documentation as seen [here](http://spyrest.com/api_actions/details?api_action=GET+%2Fusers%2Fsmsohan%2Fgists&api_host=api.github.com&api_resource=gists&api_version=v3)

  Automated, with cURL example, based on live API data! My friend, are you sold yet?


## How it works

[http://spyrest.com/pages/how_it_works](http://spyrest.com/pages/how_it_works)

## Related Projects

This is the UI component of a project lovingly named SpyREST.

* [API Through Proxy](https://github.com/smsohan/api_through) is its counter part.

