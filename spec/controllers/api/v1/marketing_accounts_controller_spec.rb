require 'spec_helper'

describe Api::V1::MarketingAccountsController do

  render_views

  before(:each) do
    authenticate_with_token
  end

  let(:marketing_account) { {

    }
  }

  describe '#create' do
    pending 'need to gather more requirements for creation'
  end

end