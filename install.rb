#!/usr/bin/env ruby

# from http://errtheblog.com/posts/89-huba-huba

home = File.expand_path('~')

Dir['*'].each do |file|
  next if file =~ /install/
  target = File.join(home, ".#{file}")
  system "ln -s -f -v -T #{File.expand_path file} #{target}"
end

