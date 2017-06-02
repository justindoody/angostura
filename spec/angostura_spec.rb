module TestModule
  include Angostura::Dependencies

  dependency :test, type: :class
end

module TestModuleMultiple
  include Angostura::Dependencies

  dependency :hooli, type: :class
  dependency :pied_piper, type: :class
end

module TestModuleDefaults
  include Angostura::Dependencies

  dependency :test, type: :class, default: 'Bachmanity'
end

module TestModuleEnv
  include Angostura::Dependencies

  dependency :jiang_yang, type: :env
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
    }.to raise_error(Angostura::DependencyValueTypeError)
  end

  it 'returns list of dependencies' do
    expect(TestModule.dependencies.map(&:name)).to eq [:test]
  end

  it 'returns list of dependencies' do
    expect(TestModuleMultiple.dependencies.map(&:name)).to eq [:hooli, :pied_piper]
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

    it 'returns constantized dependency class' do
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

describe TestModuleEnv do
  before do
    TestModuleEnv.setup do |config|
      config.env.jiang_yang = 'Ole Man'
    end
  end

  it 'does' do
    expect(TestModuleEnv.env.jiang_yang).to eq 'Ole Man'
  end
end
