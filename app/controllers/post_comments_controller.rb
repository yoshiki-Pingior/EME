class PostCommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    # if 
      comment.save
    # redirect_to request.referer
    
    #   @error_comment = comment
    #   @post = Post.find(params[:post_id])
    #   @post_comment = PostComment.new
    #   render 'posts/show'
    # end
  end
  
  def destroy
  end
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
