class CommentsController < ApplicationController


  def new
      @comment = Comment.new
  end
  
  def create
    
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    #@comment.user = current_user
    redirect_to article_path(@article)
    #@comment = Comment.new(comment_params)
   # @comment.article = Article.find(params[:article_id])
    #@comment.user = current_user
    
    #if @comment.save
    #    flash[:success] = "New comment created!"
    #    redirect_to article_path(@comment.article)
    #else
    #    redirect_to article_path(@comment.article)
    #    flash[:danger] = "Article creation failed!"
    #end
    
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
