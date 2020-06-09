# frozen_string_literal: true

require 'fast_cqrs/deserializer/json_api'

module FastCqrs
  RSpec.describe Request do
    describe "#call" do
      let(:deserializer) { double('deserializer') }

      context 'when valid request' do
        before do
          allow(deserializer).to receive(:call) do |hash={}|
            { foo: 'foo', bar: 'bar' }
          end
        end
        subject { described_class.new(deserializer: deserializer) }

        it 'returns success' do
          expect(subject.call({})).to be_success
        end
      end

      context 'when invalid request' do
        before do
          allow(deserializer).to receive(:call) do |hash={}|
            raise "Invalid request"
          end
        end
        subject { described_class.new(deserializer: deserializer) }

        it 'returns Failure(:deserialized)' do
          result = subject.call({})
          expect(result).to be_failure
          expect(result.failure).to eq(:deserialize)
        end
      end


      context 'inherited invalid request' do
        subject { InvalidRequest.new(deserializer: Deserializer::JsonApi.new).call({}) }

        it 'returns failure' do
          expect(subject).to be_failure
          expect(subject.failure).to eq(:deserialize)
        end
      end

      context 'inherited valid request' do
        subject { ValidRequest.new(deserializer: Deserializer::JsonApi.new).call({}) }

        it 'returns success' do
          expect(subject).to be_success
          expect(subject.value!).to eq(foo: 'foo', bar: 'bar')
        end
      end
    end
  end

  class InvalidRequest < Request
    protected

    def model(_input)
      return
    end
  end

  class ValidRequest < Request
    protected

    def model(_input)
      return { foo: 'foo', bar: 'bar' }
    end
  end
end
