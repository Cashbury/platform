require 'spec_helper'

describe User do

  let(:user) { stub_model(User) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should ensure_length_of(:first_name).is_at_least(2).is_at_most(30) }
    it { should ensure_length_of(:last_name).is_at_least(2).is_at_most(30) }

    it { should validate_presence_of(:password) }
    it { should ensure_length_of(:password).is_at_least(6).is_at_most(32) }
  end

  describe 'valid values' do
    it { should allow_value('Jasdeep').for(:first_name) }
    it { should allow_value('Narang').for(:last_name) }
    it { should allow_value('narang.jasdeep@gmail.com').for(:email) }
  end

  describe 'invalid values' do

    describe 'empty strings' do
      
      # empty strings
      it { should_not allow_value('').for(:first_name) }
      it { should_not allow_value('').for(:last_name)  }
      it { should_not allow_value('').for(:email)      }

      # long empty strings
      it { should_not allow_value('    ').for(:first_name) }
      it { should_not allow_value('    ').for(:last_name)  }
      it { should_not allow_value('    ').for(:email)      }

      # invalid
      it { should_not allow_value('test').for(:email)        }
      it { should_not allow_value('test@domain').for(:email) }
      it { should_not allow_value('testdomain.com').for(:email) }

      it { should_not allow_value('J').for(:first_name) }
      it { should_not allow_value('N').for(:last_name)  }

      # too long
      it { should_not allow_value('thirty characters long string for first name of a user').for(:first_name) }
      it { should_not allow_value('thirty characters long string for last name of a user ').for(:last_name)  }

    end

  end

  describe "#reset_authentication_token!" do

    it "resets the authentication token" do
      user.authentication_token = 'something'
      user.reset_authentication_token!
      user.authentication_token.should_not == 'something'
    end

    it "should call the SecureRandom lib to generate a token" do
      user.authentication_token = 'something'
      SecureRandom.should_receive(:hex).with(24)
      user.reset_authentication_token!
    end

  end

end