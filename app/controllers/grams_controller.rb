class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found unless @gram
  end

  def new
    @gram = Gram.new
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found unless @gram
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found unless @gram

    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def render_not_found
    render plain: "404 Error. Page not found", status: :not_found
  end


  def gram_params
    params.require(:gram).permit(:message)
  end
end
