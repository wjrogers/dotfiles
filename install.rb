#!/usr/bin/env ruby
require 'fileutils'
require 'pathname'
include FileUtils::Verbose

# expand paths
def home(path)
  File.expand_path File.join('~', path)
end

# get path to SSH key
key = ARGV[0] or raise 'path to RSA key required'
key = Pathname.new(key)
key_pub = key.sub_ext('.pub')
raise("#{key} is not readable") unless key.readable?
raise("#{key_pub} is not readable") unless key_pub.readable?

# configure SSH stupidly (WSL-only)
mkpath home('.ssh')
File.write home('.ssh/config'), <<~CONFIG
  AddKeysToAgent yes
CONFIG
cp key, home('.ssh/id_rsa')
cp key_pub, home('.ssh/id_rsa.pub')
chmod 0600, home('.ssh/config')
chmod 0600, home('.ssh/id_rsa')

# checkout submodules
system "git submodule update --init --recursive"

# from http://errtheblog.com/posts/89-huba-huba
Dir['*'].each do |file|
  next if file =~ /base16/
  next if file =~ /install/
  target = home(".#{file}")
  system "ln -s -f -v -T #{File.expand_path file} #{target}"
end

