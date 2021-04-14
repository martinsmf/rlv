module Helpers
    
    def get_fixture(item)
        examples = YAML.load(File.read(Dir.pwd + "/spec/fixtures/login.yml"), symbolize_names: true)
    end
    module_function :get_fixture
end