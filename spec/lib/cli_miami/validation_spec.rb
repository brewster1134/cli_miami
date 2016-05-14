describe CliMiami::Validation do
  describe '.initialize' do
    shared_examples 'a valid type' do |type, valid_string, value|
      it "and should return a #{type}" do
        validation = CliMiami::Validation.new valid_string, type: type
        expect(validation.value).to eq value
        expect(validation.valid?).to eq true
      end
    end

    shared_examples 'an invalid type' do |type, invalid_string|
      it 'and should set the error field' do
        validation = CliMiami::Validation.new invalid_string, type: type
        expect(validation.value).to eq invalid_string
        expect(validation.valid?).to eq false
        expect(validation.error).to_not be_empty
      end
    end

    describe 'BOOLEAN' do
      it_behaves_like 'a valid type', :boolean, 'TrUe', true
      it_behaves_like 'an invalid type', :boolean, 'foo'
    end

    describe 'FILE' do
      it_behaves_like 'a valid type', :file, '.', Dir.pwd
      it_behaves_like 'an invalid type', :file, File.join(Dir.pwd, 'foo')
    end

    describe 'FIXNUM' do
      it_behaves_like 'a valid type', :fixnum, '3', 3
      it_behaves_like 'a valid type', :fixnum, '3.8', 3
      it_behaves_like 'an invalid type', :fixnum, 'foo'
    end

    describe 'FLOAT' do
      it_behaves_like 'a valid type', :float, '2.0', 2.0
      it_behaves_like 'a valid type', :float, '3', 3.0
      it_behaves_like 'an invalid type', :float, 'foo'
    end

    describe 'RANGE' do
      it_behaves_like 'a valid type', :range, '2..4', (2..4)
      it_behaves_like 'an invalid type', :range, 'foo'
    end

    describe 'SYMBOL' do
      it_behaves_like 'a valid type', :symbol, '$F 8o*: .o.!', :f_o_o
      it_behaves_like 'an invalid type', :symbol, '$'
    end
  end
end
