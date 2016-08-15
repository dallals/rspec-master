class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
	before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
  	@articles = Article.all
  end

  def new
  	@article = Article.new
  end

  def show
    @comment = @article.comments.build
  end

  def edit
    if @article.user != current_user
      flash[:danger] = "You can only edit your own article."
      redirect_to root_path
    end
  end

  def update
    if @article.user != current_user
      flash[:danger] = "You can only edit your own article."
      redirect_to root_path
    else
    	if @article.update(article_params)
    		flash[:success] = "Article was successfully updated"
    		redirect_to article_path
    	else
    		flash.now[:danger] = "Article has not been updated"
    		render :edit
      end
  	end	
  end

  def create
  	@article = Article.new(article_params)
    @article = current_user.articles.build(article_params)
    # @article.user_id = current_user.id 
	if @article.save 
		flash[:success] = "Article has been created"
  		# redirect_to article_path(@article)
  		redirect_to articles_path
  	else
      flash.now[:danger] = "Article has not been created"
  		render :new
  	end	
  end

  def destroy
  	@article.destroy
  	flash[:danger] = "Article was successfully deleted"
  	redirect_to articles_path
  end

  private
  def set_article
  	@article = Article.find(params[:id])
  end

  def require_same_user

  end

  def article_params
  	params.require(:article).permit(:title, :description)
  	  	# params.require(:article).permit(:title, :description, category_ids: [])
  end
end
