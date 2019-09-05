# == Schema Information
#
# Table name: request_tokens
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RequestToken < ApplicationRecord
  belongs_to :user

  has_secure_token
end
