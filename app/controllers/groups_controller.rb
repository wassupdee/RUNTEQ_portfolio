class GroupsController < ApplicationController
  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      flash.now[:success] = "グループを登録しました"
    else
      flash.now[:danger] = "グループを登録できませんでした"
    end
  end

  def index
    @group = current_user.groups.new
    @groups = current_user.groups
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def update
    @group = current_user.groups.find(params[:id])
    if @group.update(group_params)
      flash.now[:success] = "グループを更新しました"
    else
      flash.now[:danger] = "グループを更新できませんでした"
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy!
    flash[:success] = "グループを削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
