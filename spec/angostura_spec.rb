module TestModule
  include Angostura::Dependencies

  dependency :test
end

module TestModuleMultiple
  include Angostura::Dependencies

  dependency :hooli, :pied_piper
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

  it 'raises an error for non String dependencies setup' do
    expect {
      TestModule.setup do |c|
        c.test = Integer
      end
    }.to raise_error(Angostura::DependencyTypeError)
  end

  it 'returns list of dependencies' do
    expect(TestModule.dependencies).to eq [:test]
  end

  it 'returns list of dependencies' do
    expect(TestModuleMultiple.dependencies).to eq [:hooli, :pied_piper]
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
