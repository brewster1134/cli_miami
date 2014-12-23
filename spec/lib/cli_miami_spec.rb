describe CliMiami do
  describe '.set_preset' do
    it 'should raise an error if invalid options' do
      expect{CliMiami.set_preset(:foo, :bar)}.to raise_error
    end

    it 'should set new preset' do
      CliMiami.set_preset :foo, {
        :bar => :baz
      }

      expect(CliMiami.presets[:foo]).to eq({ :bar => :baz })
    end
  end
end
