require 'pathname'
dir = Pathname.new(__FILE__).parent
$LOAD_PATH.unshift(dir, File.join(dir, 'fixtures/modules/augeasproviders_core/spec/lib'), File.join(dir, '..', 'lib'))

require 'rubygems'

require 'simplecov'
unless RUBY_VERSION =~ /^1\.8/
  require 'coveralls'
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
end
SimpleCov.start do
  add_group "Puppet Types", "/lib/puppet/type/"
  add_group "Puppet Providers", "/lib/puppet/provider/"

  add_filter "/spec/fixtures/"
  add_filter "/spec/unit/"
  add_filter "/spec/support/"
end

require 'puppetlabs_spec_helper/module_spec_helper'
require 'augeas_spec'

Puppet[:modulepath] = File.join(dir, 'fixtures', 'modules')

# There's no real need to make this version dependent, but it helps find
# regressions in Puppet
#
# 1. Workaround for issue #16277 where default settings aren't initialised from
# a spec and so the libdir is never initialised (3.0.x)
# 2. Workaround for 2.7.20 that now only loads types for the current node
# environment (#13858) so Puppet[:modulepath] seems to get ignored
# 3. Workaround for 3.5 where context hasn't been configured yet,
# ticket https://tickets.puppetlabs.com/browse/MODULES-823
#
ver = Gem::Version.new(Puppet.version.split('-').first)
if ver >= Gem::Version.new("2.7.20")
    puts "augeasproviders: setting $LOAD_PATH to work around broken type autoloading"
    Puppet.initialize_settings
    $LOAD_PATH.unshift(
        dir,
        File.join(dir, 'fixtures/modules/augeasproviders_core/spec/lib'),
        File.join(dir, 'fixtures/modules/augeasproviders_core/lib')
    )

    $LOAD_PATH.unshift(File.join(dir, '..', 'lib'))
end

# Load all shared contexts and shared examples
Dir["#{dir}/support/**/*.rb"].sort.each {|f| require f}
