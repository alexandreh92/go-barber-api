module Users
  class ValidatePasswordService
    include CallableService

    def initialize(opts = {})
      @user = User.find(opts[:user_id])
      @new_password = opts[:new_password]
      @new_password_confirmation = opts[:new_password_confirmation]
      @current_password = opts[:current_password]
    end

    def call
      validate_password!
    end

    private

      attr_reader :user, :new_password, :new_password_confirmation, :current_password,
                  :avatar, :name

      def validate_password!
        return unless current_password.present?

        validate_new_password!

        return if user.valid_password?(current_password)

        user.errors.add(:current_password, 'is invalid.')
        raise ActiveRecord::RecordInvalid, user
      end

      def validate_new_password!
        return if new_password_valid?

        user.errors.add(:password,
                        'and password_confirmation must match.')
        raise ActiveRecord::RecordInvalid, user
      end

      def new_password_valid?
        new_password == new_password_confirmation
      end
  end
end
