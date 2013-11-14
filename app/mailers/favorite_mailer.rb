class FavoriteMailer < ActionMailer::Base
  default from: "raderj89@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@rader-bloccit.example>"
    headers["In-Reply-To"] = "<post/#{@post.id}@rader-bloccit.example>"
    headers["References"] = "<post/#{@post.id}@rader-bloccit.example>"
    
    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
