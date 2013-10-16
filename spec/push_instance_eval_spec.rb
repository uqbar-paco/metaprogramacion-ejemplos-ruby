require 'rspec'

#Ejemplo similar al push_alias, pero que le agrega el
# comportamiento a una instancia concreta, usando instance_eval

def make_push_safe(an_array)
  an_array.instance_eval do
    def push(object, *smth)
      objects = []
      objects.push(object, *smth)
      raise 'No se admiten nils' unless objects.all? { |o| o != nil }
      #Aca no nos sirve la tecnica del alias, porque estamos parados
      #en la autoclase del array dado, y no en la clase Array.
      #Entonces lo que podemos hacer es buscar el metodo original en Array,
      #y evaluarlo a mano, especificando self como receptor
      self.class.instance_method(:push).bind(self).call(object, *smth)
    end
  end
  an_array
end


describe 'Push Safe Array' do

  it 'should allow non-nils' do
    a = make_push_safe([1])
    a.push(2)
    a.should == [1, 2]
  end

  it 'should reject nils' do
    a = make_push_safe([1])
    expect { a.push(nil) }.to raise_error Exception
  end


  it 'should reject nils in varargs' do
    a = make_push_safe([1])
    expect { a.push(4, 5, nil) }.to raise_error Exception
  end
end
