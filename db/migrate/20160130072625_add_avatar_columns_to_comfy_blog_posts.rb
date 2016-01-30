class AddAvatarColumnsToComfyBlogPosts < ActiveRecord::Migration

  def up
    add_attachment :comfy_blog_posts, :avatar
  end

  def down
    remove_attachment :comfy_blog_posts, :avatar
  end
  
end
