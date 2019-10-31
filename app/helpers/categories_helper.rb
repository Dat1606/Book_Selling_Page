module CategoriesHelper
  def get_children (parent_id)
    @children = Category.where("parent_id = ?",parent_id)
  end
end
