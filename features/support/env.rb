# frozen_string_literal: true

require 'debug'
require 'rspec'
require 'page-object'
require 'eventually_helper'

require_relative 'config'

# This really needs be an include since we do want configuration global
# and it throws an exception with World(Config::Pages)
# rubocop:disable Style/MixinUsage
include Config::Pages
include Config::Watir
# rubocop:enable Style/MixinUsage

World(PageObject::PageFactory)
World(EventuallyHelper)
