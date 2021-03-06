require 'spec_helper'

describe Jack::CLI do
  before(:all) do
    @args = "hi-web-stag-1 --root spec/fixtures/project --noop --sure"
    FileUtils.rm_rf("spec/fixtures/project/.elasticbeanstalk")
  end

  describe "jack" do
    it "should create environment" do
      out = execute("bin/jack create #{@args}")
      # puts out
      expect(out).to include('eb create')
      expect(out).to include('--cname hi-web-stag-1')
      expect(out).to include('--keyname "default"')
      expect(out).to include('hi-web-stag-1')
    end

    it "should upload and apply config to environment" do
      out = execute("bin/jack apply #{@args}")
      # puts out
      expect(out).to include('eb config save')
    end

    it "should download config from environment" do
      out = execute("bin/jack get #{@args}")
      # puts out
      expect(out).to include("Config downloaded")
    end

    it "should diff local config from eb environment config" do
      out = execute("bin/jack diff #{@args}")
      # puts out
      expect(out).to include("diff")
    end

    it "should reformat the local config to a sorted yaml format" do
      out = execute("bin/jack sort #{@args}")
      # puts out
      expect(out).to include("Reformatted the local config")
    end

    it "should deploy environment" do
      out = execute("bin/jack deploy #{@args}")
      # puts out
      expect(out).to include("eb deploy")
    end

    it "should terminate environment" do
      out = execute("bin/jack terminate #{@args}")
      # puts out
      expect(out).to include("Whew that was close")
    end
  end
end
