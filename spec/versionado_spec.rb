require 'rspec'


def versionar(clase)
  clase.send :define_method, :versionar do
    @version = self.version + 1
  end

  clase.send :define_method, :version do
    @version || 0
  end
end

describe 'My context' do

  it 'Una clase no versionada no entiende version ni versionar' do
    class A
    end
    a = A.new
    expect { a.version }.to raise_error Exception
    expect { a.versionar }.to raise_error Exception
  end

  it 'should respond to version methods' do
    class B
    end
    b = B.new
    versionar(B)

    b.version.should == 0

    b.versionar

    b.version.should == 1
  end

end