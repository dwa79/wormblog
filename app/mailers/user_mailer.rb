class UserMailer < ApplicationMailer
    default from: 'theskyrider@163.com'
   
    def welcome_email(user)
      @user = user
      @url  = 'wormblog.heroku.com'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
end
