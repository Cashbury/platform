describe "Events" do

  describe "in cashbury.user.* namespace" do

    let(:user) { stub_model(User) }

    describe 'Registration Action' do

      def with_instrumentation
        ActiveSupport::Notifications.subscribe(/^cashbury\.user\..+$/) do |*args|
          @events = []
          @events << ActiveSupport::Notifications::Event.new(*args)
        end
        yield
      end

      it "should recognise the registration event" do
        with_instrumentation do 
          user.notify
        end
        @events.first.name.should == 'cashbury.user.registration'
      end

      it "should send the user payload with the event as dispatcher" do
        with_instrumentation do 
          user.notify
        end
        @events.first.payload.should_not be_nil
      end

      it "should set the dispatcher instance as the user who initiated the action" do
        with_instrumentation do 
          user.notify
        end
        @events.first.payload[:dispatcher].should be_an_instance_of(User)
        @events.first.payload[:dispatcher].should == user
      end

      it "should log a record in the events table for auditing purposes" do
        Event.should_receive(:create!)
        with_instrumentation do 
          user.notify
        end
      end

      it "should add X marketing credits to dispatchers marketing money account" do
        pending 'not at a point to finish this yet'
      end

    end

  end

end