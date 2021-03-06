require 'rspec'

class Array
  alias :__push__ :push

  def push(object, *smth)
    objects = []
    objects.__push__(object, *smth)
    raise 'No se admiten nils' unless objects.all? { |o| o != nil }
    self.__push__(object, *smth)
  end

end
describe 'Array' do

  it 'should allow non-nils' do
    a = [1]
    a.push(2)
    a.should == [1, 2]
  end

  it 'should reject nils' do
    a = [1]
    expect { a.push(nil) }.to raise_error Exception
  end


  it 'should reject nils in varargs' do
    a = [1]
    expect { a.push(4, 5, nil) }.to raise_error Exception
  end
end