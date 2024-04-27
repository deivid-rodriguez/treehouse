# -*- encoding: utf-8 -*-
# stub: annotate 3.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "annotate".freeze
  s.version = "3.2.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/ctran/annotate_models/issues/", "source_code_uri" => "https://github.com/ctran/annotate_models.git" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alex Chaffee".freeze, "Cuong Tran".freeze, "Marcos Piccinini".freeze, "Turadg Aleahmad".freeze, "Jon Frisby".freeze]
  s.date = "2024-04-27"
  s.description = "Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.".freeze
  s.email = ["alex@stinky.com".freeze, "cuong.tran@gmail.com".freeze, "x@nofxx.com".freeze, "turadg@aleahmad.net".freeze, "jon@cloudability.com".freeze]
  s.executables = ["annotate".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "CHANGELOG.md".freeze]
  s.files = ["AUTHORS.md".freeze, "CHANGELOG.md".freeze, "LICENSE.txt".freeze, "README.md".freeze, "RELEASE.md".freeze, "annotate.gemspec".freeze, "bin/annotate".freeze, "lib/annotate.rb".freeze, "lib/annotate/active_record_patch.rb".freeze, "lib/annotate/annotate_models.rb".freeze, "lib/annotate/annotate_models/file_patterns.rb".freeze, "lib/annotate/annotate_routes.rb".freeze, "lib/annotate/annotate_routes/header_generator.rb".freeze, "lib/annotate/annotate_routes/helpers.rb".freeze, "lib/annotate/constants.rb".freeze, "lib/annotate/helpers.rb".freeze, "lib/annotate/parser.rb".freeze, "lib/annotate/tasks.rb".freeze, "lib/annotate/version.rb".freeze, "lib/generators/annotate/USAGE".freeze, "lib/generators/annotate/install_generator.rb".freeze, "lib/generators/annotate/templates/auto_annotate_models.rake".freeze, "lib/tasks/annotate_models.rake".freeze, "lib/tasks/annotate_models_migrate.rake".freeze, "lib/tasks/annotate_routes.rake".freeze, "potato.md".freeze]
  s.homepage = "https://github.com/ctran/annotate_models".freeze
  s.licenses = ["Ruby".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Annotates Rails Models, routes, fixtures, and others based on the database schema.".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<rake>.freeze, [">= 10.4".freeze, "< 14.0".freeze])
  s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.2".freeze, "< 8.0".freeze])
end
