module Users
  class InvitationsController < Devise::InvitationsController
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner

    def new
      @company = current_user.company
      @user = User.new
    end

    def create
      @company = current_user.company
      # find user that is in database and has been invited (but not logged in)
      @user = User.where(email: params[:email], last_sign_in_at: nil).first
      # if there is no such user or found user company is equal to current company, invite
      if !@user || @user.company == @company
        @user = invite_resource
      else
        @user.errors.add(:base, "This user is already signed to another company.")
      end
      if @user.errors.empty?
        Membership.create(company: @company, user: @user, role: 0) unless @user.company == @company
        redirect_to business_users_path, notice: "User has been invited."
      else
        render :new
      end
    end


  end
end
