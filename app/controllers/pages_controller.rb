class PagesController < ApplicationController

    def home
        redirect_to bulletin_path if logged_in?
    end
    
    def about
    
    end
    
    def personal
        
    end

    def bulletin
        
    end
    
    def try
        
    end
    
    def comment_all
      @articles = Article.all
    end
   

end