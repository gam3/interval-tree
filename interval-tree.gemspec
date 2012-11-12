# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "interval-tree"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["G. Allen Morris III"]
  s.date = "2012-11-06"
  s.description = "http://wikipedia.com/wiki/Interval_tree"
  s.email = "gam3-pause@gam3.net"
  s.homepage = "https://github.com/gam3/interval-tree"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "An interval tree implimentation for ruby"
  s.files   = [ 'lib/inclusive-interval-tree.rb',
                'lib/interval-tree-node.rb',
		'lib/interval_tree.rb', 
                'lib/exclusive-interval-tree.rb' ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
