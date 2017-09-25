describe Pubsub::AMQP::Client do
  let(:exchange) { 'test-fanout-exchange' }

  xit 'publishes and receives messages' do
    @amqp_client = Pubsub::AMQP::Client.new(rabbitmq_url)

    @amqp_client.topic(exchange)
  end
end
