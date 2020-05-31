# frozen_string_literal: true

# Account Model
class Account < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :identifier, presence: true
  validates :access_token, presence: true

  class << self
    def find_by_credentials(provider, identifier, access_token)
      account = Account.find_by(
        provider: provider,
        identifier: identifier,
        access_token: access_token
      )
      return nil if account.blank?

      account
    end

    def update_access_token(provider, identifier, access_token)
      account = find_by_provider_identifier(provider, identifier)
      return nil if account.blank?

      account.access_token = access_token
      account.save!
      account
    end

    def find_by_provider_identifier(provider, identifier)
      Account.find_by(provider: provider, identifier: identifier)
    end

    def create_account(provider, identifier, access_token, userinfo)
      account = nil
      Account.transaction do
        user = User.update_or_create_user_by_userinfo(userinfo)
        account = Account.new(provider: provider, identifier: identifier, access_token: access_token)
        account.user = user
        account.save!
      end
      account
    end
  end
end
