describe CliMiami::Error do
  describe '.initialize' do
    context 'with valid type error' do
      CliMiami::TYPE_MAP.values.uniq.each do |type|
        case type

        when :array, :multiple_choice
          value_type = [1, nil, :foo, '', (1..2)]
          value_string = '1, empty, foo, empty, and 1-2'
          allowed_values = '1-38'

        when :boolean
          value_type = true
          value_string = 'true'
          allowed_values = (CliMiami::BOOLEAN_TRUE_VALUES + CliMiami::BOOLEAN_FALSE_VALUES).to_sentence

        when :file
          value_type = File.new('.')
          value_string = File.expand_path('.')
          allowed_values = '?'

        when :fixnum
          value_type = 6
          value_string = '6'
          allowed_values = '1-38'

        when :float
          value_type = 6.66
          value_string = '6.66'
          allowed_values = '1-38'

        when :hash
          value_type = { foo: 1, bar: 2 }
          value_string = 'foo: 1 and bar: 2'
          allowed_values = '1-38'

        when :range
          value_type = (4..20)
          value_string = '4-20'
          allowed_values = '1-38'

        when :string
          value_type = 'foo'
          value_string = 'foo'
          allowed_values = '1-38'

        when :symbol
          value_type = :foo
          value_string = 'foo'
          allowed_values = '1-38'
        end

        it "should convert #{type} to string" do
          expect(CliMiami::Error.new(value_type, { type: type, min: 1, max: 38, regexp: /6{3}/ }, :spec).message).to eq "#{type}: #{value_string} - #{allowed_values}"
        end
      end

      it 'should support multiple/nested keys' do
        expect(CliMiami::Error.new('foo', { type: :type }, :nested, :spec).message).to eq 'nested spec'
      end
    end

    context 'with invalid type error' do
      it 'should have a generic error' do
        expect(CliMiami::Error.new('foo', { type: :foo }, :spec).message).to eq 'generic error'
      end
    end

    context 'when no error is found' do
      it 'should have an unknown error' do
        expect(CliMiami::Error.new('foo', { type: :foo }, :bar).message).to eq 'Unknown Error'
      end
    end
  end
end
