# frozen_string_literal: true

module FastCqrs
  RSpec.describe Authorizer do
    subject { described_class.new }

    it 'returns failure monad' do
      result = subject.call
      expect(result).to be_failure
      expect(result.failure).to eq(:authorize)
    end

    context 'when success' do
      subject { DummyAuthorizer.new }

      it 'returns success if authorized' do
        expect(subject.call).to be_success
      end
    end
  end

  class DummyAuthorizer < Authorizer
    protected

    def authorize(_subject, _auth)
      true
    end
  end
end
