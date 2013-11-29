class UsersController < ApplicationController
  before_action :authorize_admin, only: [:destroy]
  before_action :set_user
  before_action :load_styles, only: [:edit, :update]


  def show
  end

  def edit
    @expert_edit = ExpertEdit.new(user: @user)
    ap @expert_edit.inspect
  end

  def update
    @expert_edit = ExpertEdit.new(attributes: params[:expert_edit], user: @user)
    if @expert_edit.save
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    # TODO Add some notices.
    @user.delete
    redirect_to :back
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # TODO REFACTOR THIS
  def load_styles
    configuration_file = File.join(Rails.root.to_s, 'config', 'styles.yml')
    @styles = YAML.load_file(configuration_file)
  end
end