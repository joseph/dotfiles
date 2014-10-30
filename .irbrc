require 'irb/completion'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 500
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.irb-history')

# Override rvm's prompt with the simple one.
IRB.conf[:PROMPT_MODE] = :SIMPLE

# If lib dir exists, add it to the loadpath (for testing gems)
$:.unshift('lib') if File.directory?("lib") && !$:.include?('lib')


# Use time for system-style benchmarking. Try it:
#
#   >> time { sleep 1 }
#
# Or more advanced (pushing integers to an array and sleeping):
#
#   >> x = 0; y = []; time(4) { y << x += 1; sleep 0.5 }; puts y
#
def time(times = 1)
  require 'benchmark'
  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end


def gap
  puts "\n" * 80
end


# Want to know what methods a class or instance specifically supports?
#
#   class Foo
#     attr_accessor :name
#
#     def mappelle
#       puts "My name is #{name}"
#     end
#
#     def self.make_johnson
#       inst = new
#       inst.name = "johnson"
#     end
#   end
#
# You can interrogate this class as follows:
#
#   >> Foo.specific_class_methods
#   => ["make_johnson"]
#
#   >> Foo.new.specific_methods
#   => ["mappelle", "name", "name="]
#
class Object
  def specific_methods
   (self.methods - Object.instance_methods).sort
  end
  def self.specific_class_methods
    (self.methods - Object.methods).sort
  end
end


def datauri(path, mime)
  require 'base64'
  out = Base64.strict_encode64(IO.read(path))
  "data:#{mime};charset=utf-8;base64,#{out}"
end


# View the contents of a Rails session cookie.
def inspect_rails_session(cookie)
  Marshal.load(Base64.decode64(CGI.unescape(cookie).split('--').first))
end
