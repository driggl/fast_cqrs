# frozen_string_literal: true

module FastCqrs
  RSpec.describe Authorizer do
    subject { described_class.new }

    it 'returns success monad' do
      expect(subject.call).to be_success
    end

    context 'when fails' do
      subject { DummyAuthorizer.new }

      it 'returns failure if not authorized' do
        result = subject.call
        expect(result).to be_failure
        expect(result.failure).to eq(:authorize)
      end
    end
  end

  class DummyAuthorizer < Authorizer
    protected

    def authorize
      false
    end
  end
end
