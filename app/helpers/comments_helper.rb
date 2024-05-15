module CommentsHelper
    def recursive_comments(comments, post, valid = false)
      html = ''
      comments.each do |comment|
        if valid || comment.parent_comment_id.nil?
          html += render(partial: 'comments/comment', locals: { comment: comment, post: post, green: false })
        end
      end
      html.html_safe
    end
  end