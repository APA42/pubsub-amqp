module Pubsub
  module AMQP
    class Client
      def initialize(rabbitmq_url)
        @rabbitmq_url = rabbitmq_url
        @client = Bunny.new(url: rabbitmq_url)
      end

      def publish(exchange, message)
      end

      def subscribe(queue)
      end

      def topic(exchange)
      end
    end
  end
end
