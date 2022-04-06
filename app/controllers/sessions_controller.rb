class SessionsController < Devise::SessionsController
# https://github.com/heartcombo/devise/blob/main/app/controllers/devise/sessions_controller.rb

  def respond_to_on_destroy
    respond_to do |format|
      format.all { head :no_content }
      # Turbo対応としてstatus: :see_otherを追加
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name), status: :see_other }
    end
  end
end