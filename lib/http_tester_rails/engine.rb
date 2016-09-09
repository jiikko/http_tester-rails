module HttpTesterRails
  class Engine < ::Rails::Engine
    isolate_namespace HttpTesterRails

   config.generators do |g|
      g.test_framework :rspec
   end
  end
end
