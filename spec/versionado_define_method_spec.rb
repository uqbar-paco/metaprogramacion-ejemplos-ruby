require 'rspec'

def versionar(clase)
  clase.send :define_method, :versionar do
    @version = self.version + 1
  end

  clase.send :define_method, :version do
    @version || 0
  end
end

describe 'Un versionador con define_method' do

  it 'no versionada a las clases no versionadas' do
    class A
    end
    a = A.new
    expect { a.version }.to raise_error Exception
    expect { a.versionar }.to raise_error Exception
  end

  it 'le agrega versionar y version a las clases versionadas' do
    class B
    end
    b = B.new

    versionar(B)

    b.version.should == 0

    b.versionar

    b.version.should == 1
  end

end