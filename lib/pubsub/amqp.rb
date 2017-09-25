require 'pubsub/amqp/version'
require 'pubsub/amqp/client'
require 'pubsub'

module Pubsub
  module AMQP
    class DomainEventPublisher < Pubsub::DomainEventPublisher
      def initialize(amqp_client, exchange, serializer)
        @amqp_client = amqp_client
        @exchange = exchange
        @serializer = serializer
      end

      def publish(event)
        serialized = @serializer.serialize(event.to_h)
        @amqp_client.publish(@exchange, serialized)
      end
    end

    class DomainEventListener < Pubsub::DomainEventListener
      def initialize(amqp_client, queue)
        @amqp_client = amqp_client
        @queue = queue
      end

      def listen
        @amqp_client.subscribe(@queue) do |_delivery_info, _metadata, payload|
          yield payload
        end
      end
    end
  end
end
