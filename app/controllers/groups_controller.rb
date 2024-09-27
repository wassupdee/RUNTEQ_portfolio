class GroupsController < ApplicationController
  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      flash[:success] = "アルバムを登録しました"
      redirect_to groups_path
    else
      flash[:danger] = "連絡先を登録できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @groups = current_user.groups
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end


  def update
    @group = current_user.groups.find(params[:id])
    if @group.update(group_params)
      flash[:success] = "アルバムを更新しました"
      redirect_to groups_path
    else
      flash[:danger] = "アルバムを更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy!
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
