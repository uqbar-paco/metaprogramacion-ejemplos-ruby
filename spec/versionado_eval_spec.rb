require 'rspec'


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
#B.version.should == 0
    b.version.should == 0

    b.versionar

    b.version.should == 1
  end

end