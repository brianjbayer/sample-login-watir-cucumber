# frozen_string_literal: true

require 'debug'
require 'rspec'
require 'watir'

require_relative 'config'
require_relative 'page_objects'
require_relative 'watir_cucumber'

# Configuration is shared with browser setup hooks.
# rubocop:disable Style/MixinUsage
include Config::PageObjects
include Config::Watir
# rubocop:enable Style/MixinUsage

World(WatirCucumber, PageObjects)
