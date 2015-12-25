#
# dtk_export_variable.rb
#

module Puppet::Parser::Functions
  newfunction(:dtk_export_variable, :type => :statement, :doc => <<-EOS
    Utility to send variable value back to DTK Arbiter 
    EOS
  ) do |arguments|
    fn_name = 'dtk_export_variable'
    unless [2].include?(arguments.size)
      raise Puppet::ParseError, "#{fn_name}(): Wrong number of arguments given (#{arguments.size} for 2)"
    end 

    name = arguments[0]
    unless name =~ /(^.+)::(.+$)/
      raise Puppet::Error, "#{fn_name}(): 'name' parameter (#{self[:name]}) must have form that matches regexp /(^.+)::(.+$)/"
    else
      component = $1
      attribute = $2

      if name =~ /\[/
        raise Puppet::Error, "#{fn_name}(): the 'content' paramter must be explicitly given since name refes to a definition component"
      end
      content = (arguments[1] == 'undef' ? lookupvar(name) : arguments[1])
      
      # TODO: in a puppet manifest there can be emultiple modules that call this; with this implementation
      # one would overwrite the other; also want to put this in some subdirectory under /usr/share/dtk
      # so there should probably be designated directory and name files one to one with name
      # so also can get rid of use of thread variable
      p = Thread.current[:exported_variables] ||= Hash.new
      (p[component] ||= Hash.new)[attribute] = content
require 'pp'; pp p # TODO: for debbugging
      File.open('/tmp/dtk_exported_variables', 'w') { |f| f.write(Marshal.dump(p)) }
    end
  end
end      
