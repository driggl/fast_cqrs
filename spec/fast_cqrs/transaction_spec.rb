# frozen_string_literal: true

module FastCqrs
  RSpec.describe Transaction do
    describe '#call' do
      subject { described_class.new.call({}) }

      it 'returns success' do
        expect(subject).to be_success
      end
    end
  end
end
