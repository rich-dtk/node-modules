define "r8::export_variable", :content => Puppet::Parser::AST::Leaf::Undef.new({:value => '***'}) do 
  if @name =~ /(^.+)::(.+$)/
    component = $1
    attribute = $2
    if content = (@content == '***' ? scope.lookupvar(@name) : @content) 
      p = Thread.current[:exported_variables] ||= Hash.new
      (p[component] ||= Hash.new)[attribute] = content 
    end
  end
end 
