#!/usr/bin/env python
#
from google.appengine.ext import webapp
from google.appengine.ext.webapp import util
import pusher
try:
    import json
except ImportError:
    import simplejson as json

try:
    import config
except ImportError:
    raise Exception("refer to the README on creating a config.py file")

class AuthHandler(webapp.RequestHandler):
    def get(self):
        channel_name = self.request.get('channel_name')
        client_id = self.request.get('client_id')

        auth = p[channel_name].authenticate(socket_id)
        json_data = json.dumps(auth)

        callback = self.request.get('callback')
        self.response.out.write(callback + "(" + json_data + ")")


def main():
    application = webapp.WSGIApplication([('/pusher/jsonp_auth', AuthHandler)],
        debug=True)
    util.run_wsgi_app(application)


if __name__ == '__main__':
    main()
