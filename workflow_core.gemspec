# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "workflow_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "workflow_core"
  s.version     = WorkflowCore::VERSION
  s.authors     = ["jasl"]
  s.email       = ["jasl9187@hotmail.com"]
  s.homepage    = "https://github.com/rails-engine/workflow_core"
  s.summary     = "A Rails engine which providing essential infrastructure of workflow. It's based on Workflow Nets."
  s.description = "A Rails engine which providing essential infrastructure of workflow. It's based on Workflow Nets."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2"
end
