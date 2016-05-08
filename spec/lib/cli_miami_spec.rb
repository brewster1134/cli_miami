describe CliMiami do
  subject { CliMiami }

  describe '.set_preset' do
    it 'should raise an error if invalid options' do
      expect { subject.set_preset(:foo, :bar) }.to raise_error ArgumentError
    end

    it 'should set new preset' do
      subject.set_preset :foo,
        bar: :baz

      expect(subject.class_variable_get(:@@presets)[:foo]).to eq(bar: :baz)
    end

    it 'should extend an existing preset' do
      subject.set_preset :foo,
        color: :red,
        bg_color: :blue

      subject.set_preset :bar,
        preset: :foo,
        bg_color: :green

      expect(subject.class_variable_get(:@@presets)[:bar]).to eq(
        color: :red,
        bg_color: :green
      )
    end
  end

  describe '.get_options' do
    before do
      subject.set_preset :foo,
        color: 'red',
        bg_color: 'blue'
    end

    it 'should handle `required`' do
      # should replaced `required` with altered minimum value
      expect(subject.get_options(required: true)).to_not include(:required)

      # should set min from 0 to 1
      expect(subject.get_options(required: true)).to include(min: 1)
    end

    context 'when passing a preset symbol' do
      context 'when preset is valid' do
        it 'should return the preset options' do
          expect(subject.get_options(:foo)).to include(
            color: 'red',
            bg_color: 'blue'
          )
        end
      end

      context 'when preset is invalid' do
        it 'should still return default options' do
          expect(subject.get_options(:bar)).to_not be_empty
        end
      end
    end

    context 'when passing an options hash' do
      context 'when hash has a valid preset key' do
        it 'should return the preset options' do
          expect(subject.get_options(preset: :foo)).to include(
            color: 'red',
            bg_color: 'blue'
          )
        end

        it 'should extend preset options with additional passed options' do
          expect(subject.get_options(preset: :foo, style: 'bold')).to include(
            color: 'red',
            bg_color: 'blue',
            style: ['bold']
          )
        end

        it 'should override preset options with additional passed options' do
          expect(subject.get_options(preset: :foo, bg_color: 'green')).to include(
            color: 'red',
            bg_color: 'green'
          )
        end
      end

      context 'when hash has an invalid preset key' do
        it 'should still return default options' do
          expect(subject.get_options(preset: :bar)).to_not be_empty
        end
      end
    end
  end
end
