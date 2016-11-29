ENV['TEST'] = '1'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "pp"
require 'ostruct'
require 'pry'

root = File.expand_path('../../', __FILE__)
require "#{root}/lib/jack"

require "#{root}/spec/support/fake_project"

module Helpers
  def execute(cmd)
    puts "Running: #{cmd}" if ENV['DEBUG']
    out = `#{cmd}`
    puts out if ENV['DEBUG']
    out
  end

  def test_options(env_name="hi-web-stag-1")
    {
      noop: true,
      mute: true,
      force: true,
      root: @root,
      env_name: env_name
    }
  end

  def fake_project
    return @fake_project if @fake_project
    @fake_project = FakeProject.new(@root)
    @fake_project.create_eb_config
    @fake_project
  end
end

RSpec.configure do |c|
  c.include Helpers
  c.before :all do
    @root = "spec/fixtures/project" # @root is being treated as a global with specs
    fake_project
  end
  c.after :all do
    FileUtils.rm_f("#{@root}/.gitignore")
  end
end
