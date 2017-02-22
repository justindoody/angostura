module TestModule
  include Angostura::Dependencies

  dependency :test
end

module TestModuleDefaults
  include Angostura::Dependencies

  dependency test: 'Bachmanity'
end

class Bachmanity; end

describe TestModule do
  context 'without dependency set' do
    it 'raises an error for missing dependencies' do
      expect { TestModule.setup {} }.to raise_error(Angostura::DependencyError)
    end
  end

  context 'with set dependencies' do
    before do
      TestModule.setup do |config|
        config.test = 'Bachmanity'
      end
    end

    it 'sets up depedencies' do
      expect(TestModule.test).to eq 'Bachmanity'
    end

    it 'returns constantized depedency class' do
      expect(TestModule.test_class).to eq Bachmanity
    end
  end

  context 'with dependency defaults' do
    it 'passes setup' do
      expect { TestModuleDefaults.setup { |c| } }.not_to raise_error
    end

    it 'properly sets defaults' do
      expect(TestModule.test).to eq 'Bachmanity'
    end
  end
end
