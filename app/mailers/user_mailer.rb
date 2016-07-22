class UserMailer < ApplicationMailer
    default from: 'superlittleblog@gmail.com'
   
    def welcome_email(user)
      @user = user
      @url  = 'wormblog.heroku.com'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
end
