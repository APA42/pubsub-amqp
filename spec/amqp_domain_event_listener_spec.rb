describe Pubsub::AMQP::DomainEventListener do
  context 'when subscribes to a queue' do
    let(:queue) { 'irrelevant queue' }

    it 'receives message' do
      amqp_client = instance_spy(Pubsub::AMQP::Client)
      domain_event_listener = \
        Pubsub::AMQP::DomainEventListener.new(amqp_client, queue)

      domain_event_listener.listen { |message| message }

      expect(amqp_client).to have_received(:subscribe)
    end
  end
end
