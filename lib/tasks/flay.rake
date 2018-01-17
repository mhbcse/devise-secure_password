#
# flay.rake
#
# Run flay code coverage tasks.
#
require 'rake'

FLAY_ROOT_DIR = File.expand_path('../../../', __FILE__)
FLAY_FILES = Dir.glob("#{FLAY_ROOT_DIR}/lib/devise_password_policy_extension/**/*.rb")

unless Gem::Specification.find_all_by_name('flay').any?
  abort 'Flay gem is missing. Install it.'
end
require 'flay'
require 'flay_task'

unless Gem::Specification.find_all_by_name('ruby2ruby').any?
  abort 'Flay code coverage tests require ruby2ruby gem. Install it.'
end
require 'ruby2ruby'

namespace :test do
  desc 'Run Flay code coverage tests'
  task :flay do
    flay = Flay.new(Flay.default_options.merge(diff: true, mass: 35))
    flay.process(*FLAY_FILES)
    flay.report
  end
end