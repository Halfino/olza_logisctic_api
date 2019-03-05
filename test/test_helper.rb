$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "olza_api"
require "webmock/minitest"
require "minitest/autorun"

WebMock.disable_net_connect!(:allow_localhost => true)