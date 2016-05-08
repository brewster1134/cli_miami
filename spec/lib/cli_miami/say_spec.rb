describe CliMiami::S do
  subject { CliMiami::S }

  describe '.ay' do
    it 'should not accept no arguments' do
      expect { subject.ay 'no arguments' }.to_not raise_error
    end

    context 'with options' do
      it 'should accept color' do
        expect($stdout).to receive(:puts).with "\e[31mcolor\e[0m"
        subject.ay 'color', color: :red
      end

      it 'should accept bgcolor' do
        expect($stdout).to receive(:puts).with "\e[41mbgcolor\e[0m"
        subject.ay 'bgcolor', bgcolor: :red
      end

      it 'should accept justify / padding' do
        expect($stdout).to receive(:puts).with(/^\s{1}justify\s{2}$/)
        subject.ay 'justify', justify: :center, padding: 10
      end

      it 'should accept indent' do
        expect($stdout).to receive(:puts).with(/^\s{10}indent$/)
        subject.ay 'indent', indent: 10
      end

      it 'should accept newline' do
        # when true, use puts
        expect($stdout).to receive(:puts).with 'newline'
        subject.ay 'newline', newline: true

        # when false, use print
        expect($stdout).to receive(:print).with 'newline '
        subject.ay 'newline', newline: false
      end

      it 'should accept overwrite' do
        expect($stdout).to receive(:print).with "overwrite\r "
        subject.ay 'overwrite', overwrite: true
      end

      context 'with style' do
        it 'should accept style' do
          expect($stdout).to receive(:puts).with "\e[4mstyle\e[0m"
          subject.ay 'style', style: :underline
        end

        it 'should apply bright style to color' do
          expect($stdout).to receive(:puts).with "\e[91mbright\e[0m"
          subject.ay 'bright', color: :red, style: :bright
        end

        it 'should accept multiple styles' do
          expect($stdout).to receive(:puts).with "\e[4m\e[1m\e[91mmultiple\e[0m\e[0m\e[0m"
          subject.ay 'multiple', color: :red, style: [:bright, :bold, :underline]
        end
      end
    end

    context 'with preset' do
      before do
        CliMiami.set_preset :preset_symbol,
          color: :blue,
          bgcolor: :white,
          style: :underline
      end

      it 'should apply preset as symbol' do
        expect($stdout).to receive(:puts).with "\e[4m\e[47m\e[34mpreset\e[0m\e[0m\e[0m"
        subject.ay 'preset', :preset_symbol
      end

      it 'should apply preset as option' do
        expect($stdout).to receive(:puts).with "\e[4m\e[47m\e[34mpreset\e[0m\e[0m\e[0m"
        subject.ay 'preset', preset: :preset_symbol
      end

      it 'should override presets with additional options' do
        expect($stdout).to receive(:puts).with "\e[4m\e[47m\e[31mpreset\e[0m\e[0m\e[0m"
        subject.ay 'preset', preset: :preset_symbol, color: :red
      end
    end
  end
end
