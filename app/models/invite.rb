require 'digest/sha1'

class Invite < ActiveRecord::Base
  
  validates_presence_of :email
  validates_uniqueness_of :email


  def invited?
    !!self.invite_code && !!self.invited_at
  end
  
  def invite!
    self.invite_code = Digest::SHA1.hexdigest("--#{Time.now.utc.to_s}--#{self.email}--")
    self.invited_at = Time.now.utc
    self.save!
  end
  
  def self.find_redeemable(invite_code)
    self.where({:redeemed_at => nil, :invite_code => invite_code}).first
  end

  def redeemed!
    self.redeemed_at = Time.now.utc
    self.save!
  end
  
end