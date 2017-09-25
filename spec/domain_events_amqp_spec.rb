describe 'DomainEvent Pub/Sub with AMQP', :integration do
  class DummyDomainEventSubscriber < Pubsub::DomainEventSubscriber

  end

  class DummyEvent
    def to_h
      {
        name: 'event.created'
      }
    end
  end

  xcontext 'when publishing an event' do
    it 'is received by its subscriber' do
      publisher = Pubsub::AMQP::DomainEventPublisher.new
      listener = Pubsub::AMQP::DomainEventListener.new
      serializer = Pubsub::Serializer.new
      logger = ::Logger.new(STDOUT)
      processor = Pubsub::DomainEventProcessor.new(listener, serializer, logger)
      subscriber = DummyDomainEventSubscriber.new

      processor << subscriber
      event = DummyEvent.new

      publisher.publish(event)

      expect(subscriber.event).to eq(event.to_h)
    end
  end
end
