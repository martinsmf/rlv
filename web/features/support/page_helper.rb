Dir[File.join(File.dirname(__FILE__),
    '../view/pages/*_page.rb')].each { |file| require file}

module Pages

    def login_page
        @login ||= LoginPage.new
    end
    
end