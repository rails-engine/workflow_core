# frozen_string_literal: true

# tmp file for with_advisory_lock, see https://github.com/ClosureTree/with_advisory_lock/issues/3
ENV["FLOCK_DIR"] ||= File.expand_path("../tmp/locks", __dir__)

require "fileutils"
FileUtils.mkdir_p ENV["FLOCK_DIR"]

# Set up gems listed in the Gemfile.
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../../Gemfile", __dir__)

require "bundler/setup" if File.exist?(ENV["BUNDLE_GEMFILE"])
$LOAD_PATH.unshift File.expand_path("../../../lib", __dir__)
