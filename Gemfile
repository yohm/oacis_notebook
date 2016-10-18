oacis = ENV['OACIS_ROOT']
unless oacis
  $stderr.puts "set environment variable 'OACIS_ROOT'"
  exit 1
end

eval_gemfile File.join( oacis, "Gemfile")

gem "rbczmq"
gem "iruby", "~> 0.2.9"
gem "daru"
gem "gnuplotrb"
# gem "statsample-glm"
# gem "nyaplot", git: 'https://github.com/domitry/nyaplot.git', ref: 'master'
# pointing the master branch to avoid an issue. See https://github.com/domitry/nyaplot/issues/52

