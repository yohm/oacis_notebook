oacis = ENV['OACIS_ROOT']
unless oacis
  $stderr.puts "set environment variable 'OACIS_ROOT'"
  exit 1
end

eval_gemfile File.join( oacis, "Gemfile")

gem "rbczmq"
gem "iruby", "~> 0.2.9"

