class ExpertsController < ApplicationController
  before_action :load_styles

  def new
    @expert_registration = ExpertRegistration.new
  end

  def create
    @expert_registration = ExpertRegistration.new(params[:expert_registration])
    if @expert_registration.save
      redirect_to expert_path
    else
      render 'new'
    end
  end

  def update
    # personal_info
    # expert_info

    # TODO missing the case where the admin edits!
    @user = current_user
    personal_info = params[:personal_info]
    expert_info = params[:expert_info]

    updated_personal_info = @user.update_personal_info(personal_info) unless personal_info.nil?
    updated_expert_info = @user.update_expert_info(expert_info) unless expert_info.nil?

    render json: updated_personal_info unless updated_personal_info.nil?
    render json: updated_expert_info unless updated_expert_info.nil?
  end

  private
  # TODO REFACTOR THIS
  def load_styles
    configuration_file = File.join(Rails.root.to_s, 'config', 'styles.yml')
    @styles = YAML.load_file(configuration_file)
  end
end