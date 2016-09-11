module SugoiHttpTesterRails
  class Engine < ::Rails::Engine
    isolate_namespace SugoiHttpTesterRails

   config.generators do |g|
      g.test_framework :rspec
   end
  end
end
