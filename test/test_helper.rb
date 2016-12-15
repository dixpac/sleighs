$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'rack/mock'
#require 'minitest/reporters'


#MiniTest::Reporters.use! [Minitest::Reporters::DefaultReporter.new]

require_relative "blog/config/environment"
