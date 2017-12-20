class Admin::CategoriesController < Admin::BaseController
  before_action :authenticate_root!

  def index
    @categories = Category.all.page(params[:page]).per(20).includes :parent_category
  end
end
