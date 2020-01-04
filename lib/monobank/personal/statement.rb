require 'monobank/personal/endpoint'

module Monobank
  module Personal
    class Statement < Endpoint
      ENDPOINT = '/personal/statement'.freeze

      def initialize(token:, account_id:, from:, to:)
        @token = token
        @account_id = account_id
        @from = from
        @to = to
      end

      private

      attr_reader :account_id, :from, :to

      def pathname
        path = "#{ENDPOINT}/#{account_id}/#{from}"
        path = "#{path}/#{to}" if to
        path
      end
    end
  end
end