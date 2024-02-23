require 'monobank/methods/get'
require 'monobank/resources/personal/statement'

module Monobank
  module Personal
    class Statement < Methods::Get
      ENDPOINT = '/personal/statement'.freeze

      def initialize(account_id:, from:, to:, **rest)
        super(**rest)

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

      def define_resources(attributes)
        attributes.map do |attrs|
          Monobank::Resources::Personal::Statement.new(attrs)
        end
      end
    end
  end
end
