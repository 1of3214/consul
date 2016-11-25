class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  load_and_authorize_resource class: "User"

  def show
  end

  def update
    if @account.update(account_params)
      redirect_to account_path, notice: t("flash.actions.save_changes.notice")
    else
      @account.errors.messages.delete(:organization)
      render :show
    end
  end

  private

    def set_account
      @account = current_user
    end

    def account_params
      if @account.organization?
        params.require(:account).permit(:phone_number, :email_on_comment, :email_on_comment_reply, :newsletter, organization_attributes: [:name, :responsible_name])
      else
        params.require(:account).permit(:username, :public_activity, :email_on_comment, :email_on_comment_reply, :email_on_direct_message, :email_digest, :newsletter, :official_position_badge)
      end
    end

end