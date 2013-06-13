#if RUBY_VERSION =~ /1.9/
    #Encoding.default_external = Encoding::UTF_8
    #Encoding.default_internal = Encoding::UTF_8
#end

source "http://rubygems.org"

#gem "veewee", :path => "."
#gem "fission", :path => '/Users/patrick/dev/fission'

group :kvm do
  gem "ruby-libvirt"
end

group :windows do
  gem "em-winrm", :git => 'http://github.com/hh/em-winrm.git', :ref => '31745601d3'
  gem "log4r"
end

group :vagrant do
  gem "vagrant", github: "mitchellh/vagrant" # , tag: "v1.2.2"
end

group :chef do
  gem "chef"
end

group :test do
  gem "rake"
  #gem "knife-windows"
end

gemspec
