describe CliMiami::A do
  describe 'A.sk' do
    before do
      @q = 'who am i?'
      allow(CliMiami::S).to receive(:ay)
      allow(Readline).to receive(:readline).and_return 'user readline'
      allow($stdin).to receive(:gets).and_return 'user gets'
    end

    after do
      allow(CliMiami::S).to receive(:ay).and_call_original
      allow(Readline).to receive(:readline).and_call_original
      allow($stdin).to receive(:gets).and_call_original
    end

    it 'should call S.ay with the question and options' do
      options = { :ask => true }
      expect(CliMiami::S).to receive(:ay).with @q, hash_including(options)

      A.sk @q, options
    end

    it 'should call S.ay multiple times' do
      expect(CliMiami::S).to receive(:ay).with(@q, :readline => false)
      expect(CliMiami::S).to receive(:ay).with(CliMiami::A.prompt, hash_including({ :newline => false }))
      expect(CliMiami::S).to receive(:ay).with(no_args)

      A.sk @q
    end

    it 'should accept a block with the repsonse' do
      A.sk @q do |response|
        expect(response).to eq 'user gets'
      end
    end

    context 'when using readline' do
      it 'should call readline with prompt' do
        expect(Readline).to receive(:readline).with CliMiami::A.prompt

        A.sk @q, :readline => true
      end
    end

    context 'when using stdin' do
      it 'should call stdin' do
        expect($stdin).to receive(:gets)

        A.sk @q, :readline => false
      end
    end
  end
end
