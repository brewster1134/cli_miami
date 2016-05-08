describe CliMiami::A do
  before do
    @q = 'Who am i?'
    allow(CliMiami::S).to receive(:ay).and_call_original
    allow_any_instance_of(CliMiami::A).to receive(:request_string).and_return 'Jane Doe'
  end

  after do
    allow_any_instance_of(CliMiami::A).to receive(:request_string).and_call_original
  end

  describe '.sk' do
    context 'when passed a block' do
      it 'should yield a response' do
        CliMiami::A.sk @q do |response|
          expect(response).to eq 'Jane Doe'
        end
      end
    end

    context 'when not passed a block' do
      it 'should return a response' do
        expect(CliMiami::A.sk(@q).value).to eq 'Jane Doe'
      end
    end
  end

  #
  # COMPLEX REQUEST TYPES
  #
  describe 'ARRAY' do
    it 'should allow user to enter values until they enter an empty string' do
      allow($stdin).to receive(:gets).and_return 'foo', 'bar', ''
      ask = CliMiami::A.sk @q, type: :array
      expect(ask.value).to eq %w(foo bar)
    end

    it 'should prevent user from entering less than the minimum' do
      allow($stdin).to receive(:gets).and_return 'foo', '', 'bar', ''
      ask = CliMiami::A.sk @q, type: :array, min: 2
      expect(ask.value).to eq %w(foo bar)
    end

    it 'should stop prompting user when the maximum is reached' do
      allow($stdin).to receive(:gets).and_return 'foo', 'bar'
      ask = CliMiami::A.sk @q, type: :array, max: 2
      expect(ask.value).to eq %w(foo bar)
    end
  end

  describe 'HASH' do
    it 'should allow user to enter keys & values until they enter an empty key string' do
      allow($stdin).to receive(:gets).and_return 'foo1', '1', 'bar1', '2', ''
      ask = CliMiami::A.sk @q, type: :hash
      expect(ask.value).to eq(foo1: '1', bar1: '2')
    end

    it 'should prevent user from entering less than the minimum' do
      allow($stdin).to receive(:gets).and_return 'foo2', '1', '', 'bar2', '2', ''
      ask = CliMiami::A.sk @q, type: :hash, min: 2
      expect(ask.value).to eq(foo2: '1', bar2: '2')
    end

    it 'should stop prompting user when the maximum is reached' do
      allow($stdin).to receive(:gets).and_return 'foo3', '1'
      ask = CliMiami::A.sk @q, type: :hash, max: 1
      expect(ask.value).to eq(foo3: '1')
    end

    context 'when keys options is set' do
      it 'should prompt for keys first, then user-defined keys' do
        allow($stdin).to receive(:gets).and_return '1', 'bar4', '2', ''
        ask = CliMiami::A.sk @q, type: :hash, keys: [:foo4]
        expect(ask.value).to eq(foo4: '1', bar4: '2')
      end
    end
  end

  describe 'RANGE' do
    it 'should allow user to enter floats or integers for start and end values' do
      allow($stdin).to receive(:gets).and_return '1.1', '3'
      ask = CliMiami::A.sk @q, type: :range
      expect(ask.value).to eq((1.1..3.0))
    end

    it 'should prevent user from entering non-numeric values' do
      allow($stdin).to receive(:gets).and_return 'foo', '1', 'bar', '3'
      ask = CliMiami::A.sk @q, type: :range
      expect(ask.value).to eq((1.0..3.0))
    end

    it 'should re-prompt user if range is invalid' do
      allow($stdin).to receive(:gets).and_return '1', '3', '1', '4'
      ask = CliMiami::A.sk @q, type: :range, min: 4
      expect(ask.value).to eq((1.0..4.0))
    end
  end

  #
  # SIMPLE REQUEST TYPES
  #
  context 'with simple types' do
    shared_examples 'when prompting the user' do |type, invalid_string, valid_string, value|
      it 'should prompt until a valid value is entered' do
        allow($stdin).to receive(:gets).and_return(invalid_string, valid_string)
        allow(Readline).to receive(:readline).and_return(invalid_string, valid_string)
        ask = CliMiami::A.sk type.to_s, type: type
        expect(ask.value).to eq value
      end
    end

    describe 'BOOLEAN' do
      it_behaves_like 'when prompting the user', :boolean, 'foo', 'TrUe', true
    end

    describe 'FILE' do
      it_behaves_like 'when prompting the user', :file, 'foo', '.', Dir.pwd
    end

    describe 'FLOAT' do
      it_behaves_like 'when prompting the user', :float, 'foo', '2.0', 2.0
      it_behaves_like 'when prompting the user', :float, 'foo', '3', 3
    end

    describe 'FIXNUM' do
      it_behaves_like 'when prompting the user', :fixnum, 'foo', '2', 2
      it_behaves_like 'when prompting the user', :fixnum, 'foo', '3.8', 3
    end

    describe 'SYMBOL' do
      it_behaves_like 'when prompting the user', :symbol, '$', '$f_ 0o8<0o', :f_o_o
    end
  end
end
