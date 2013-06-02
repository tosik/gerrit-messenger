require 'bundler/setup'

require "pathname"
$:.unshift Pathname.new(__FILE__).realpath.join('../../lib') if $0 == __FILE__

require 'gerrit-messenger'

RSpec.configure do |config|
end