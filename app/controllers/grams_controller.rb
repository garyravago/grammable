class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy]

  def index
    @grams = Gram.all
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
    return render_not_found(:forbidden) if @gram.user != current_user
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
    return render_not_found(:forbidden) if @gram.user != current_user

    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found unless @gram 
    return render_not_found(:forbidden) if @gram.user != current_user
    @gram.destroy
    redirect_to root_url
  end

  private

  def gram_params
    params.require(:gram).permit(:message, :picture)
  end
end
