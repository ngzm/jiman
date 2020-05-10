# frozen_string_literal: true

# Authentication common functions
module Authentication
  def verify_auth_token(access_token: nil, provider: 'google', identifier: nil)
    account = Account.find_by_credentials(provider, identifier, access_token)
    return account.user if account.present?

    userinfo = obtain_userinfo(access_token, provider)
    raise(Auths::Error::Unauthorized, 'user identifier is not match!')  \
      unless identifier == userinfo[:identifier]

    account = Account.update_access_token(provider, identifier, access_token)
    return account.user if account.present?

    account = Account.create_account(provider, identifier, access_token, userinfo)
    account.user
  end

  def obtain_userinfo(access_token, provider)
    auth = Auths::Authorize.new
    if provider == 'google'
      return auth.obtain_userinfo_with_google(access_token)
    elsif provider == 'facebook'
      return nil
    elsif provider == 'github'
      return nil
    end

    nil
  end
end
