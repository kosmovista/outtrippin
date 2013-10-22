class ExpertsController < ApplicationController
  before_action :load_styles

  def new
    ap User.last
    @expert_registration = ExpertRegistration.new
  end

  def create
    @expert_registration = ExpertRegistration.new(params[:expert_registration])
    if @expert_registration.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def load_styles
    configuration_file = File.join(Rails.root.to_s, 'config', 'styles.yml')
    @styles = YAML.load_file(configuration_file)
  end
end