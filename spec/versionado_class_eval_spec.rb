require 'rspec'

#Mismo ejemplo que versionado_define_method, pero usando class_eval y def's

def versionar(clase)
  clase.class_eval do
    def versionar
      @numeroVersion = self.version + 1
    end

    def version
      @numeroVersion || 0
    end

  end
end

describe 'Un versionador con eval' do

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
#B.version.should == 0
    b.version.should == 0

    b.versionar

    b.version.should == 1
  end

end