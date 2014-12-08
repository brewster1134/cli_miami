describe CliMiami::S do
  describe 'S.ay' do
    before do
      allow($stdout).to receive(:print)
      allow($stdout).to receive(:puts)
    end

    after do
      allow($stdout).to receive(:print).and_call_original
      allow($stdout).to receive(:puts).and_call_original
    end

    context 'with options' do
      it 'should accept color' do
        expect($stdout).to receive(:puts).with "\e[31mcolor\e[0m"
        S.ay 'color', :color => :red
      end

      it 'should accept bgcolor' do
        expect($stdout).to receive(:puts).with "\e[41mbgcolor\e[0m"
        S.ay 'bgcolor', :bgcolor => :red
      end

      it 'should accept style' do
        expect($stdout).to receive(:puts).with "\e[4mstyle\e[0m"
        S.ay 'style', :style => :underline
      end

      it 'should apply bright style to color' do
        expect($stdout).to receive(:puts).with "\e[91mbright\e[0m"
        S.ay 'bright', :color => :red, :style => :bright
      end

      it 'should accept multiple styles' do
        expect($stdout).to receive(:puts).with "\e[4m\e[1m\e[91mmultiple\e[0m\e[0m\e[0m"
        S.ay 'multiple', :color => :red, :style => [:bright, :bold, :underline]
      end

      it 'should accept justify / padding' do
        expect($stdout).to receive(:puts).with(/^\s{1}justify\s{2}$/)
        S.ay 'justify', :justify => :center, :padding => 10
      end

      it 'should accept indent' do
        expect($stdout).to receive(:puts).with(/^\s{10}indent$/)
        S.ay 'indent', :indent => 10
      end

      it 'should accept newline' do
        # when true, use puts
        expect($stdout).to receive(:puts).with 'newline'
        S.ay 'newline', :newline => true

        # when false, use print
        expect($stdout).to receive(:print).with 'newline'
        S.ay 'newline', :newline => false
      end

      it 'should accept overwrite' do
        expect($stdout).to receive(:print).with "overwrite\r"
        S.ay 'overwrite', :overwrite => true
      end
    end

    context 'with preset' do
      before do
        S.set_preset :preset_symbol, {
          :color => :blue,
          :bgcolor => :white,
          :style => :underline
        }
      end

      it 'should apply preset as symbol' do
        expect($stdout).to receive(:puts).with "\e[4m\e[47m\e[34mpreset\e[0m\e[0m\e[0m"
        S.ay 'preset', :preset_symbol
      end

      it 'should apply preset as option' do
        expect($stdout).to receive(:puts).with "\e[4m\e[47m\e[34mpreset\e[0m\e[0m\e[0m"
        S.ay 'preset', :preset => :preset_symbol
      end
    end
  end

  describe '.set_preset' do
    it 'should raise an error if invalid options' do
      expect{S.set_preset(:foo, :bar)}.to raise_error
    end

    it 'should set new preset' do
      S.set_preset :foo, {
        :bar => :baz
      }

      expect(S.presets[:foo]).to eq({ :bar => :baz })
    end
  end
end
