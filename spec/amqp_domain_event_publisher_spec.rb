describe Pubsub::AMQP::DomainEventPublisher do
  class DummyEvent
    def to_h
      {
        name: 'event.created'
      }
    end
  end

  context 'when publishing an event' do
    let(:exchange) { 'irrelevant exchange' }
    let(:event) {  DummyEvent.new }

    before(:each) do
      @amqp_client = instance_spy(Pubsub::AMQP::Client)
      @serializer = instance_spy(Pubsub::Serializer)
      @event_publisher = Pubsub::AMQP::DomainEventPublisher.new(@amqp_client,
                                                                exchange,
                                                                @serializer)
    end

    it 'publishes event to exchange' do
      serialized_event = 'irrelevant_serialized_event'
      allow(@serializer).to \
        receive(:serialize).with(event.to_h).and_return(serialized_event)

      @event_publisher.publish(event)

      expect(@amqp_client).to \
        have_received(:publish).with(exchange, serialized_event)
    end
  end
end
