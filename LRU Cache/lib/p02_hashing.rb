class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |i,idx|
      result += i.hash * 898 * idx **987 %1000
      result -= 234567
    end
    result ** 67
  end
end

class String
  def hash
    str = self.chars
    result = 0
    str.each_with_index do |ch,idx|
      result += ch.ord.hash * 898 * idx **987 %1000
      result -= 2349789
    end
    result ** 50
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result =  0
    self.each do |key,val|
      result += (key.to_s).hash * (val.to_s).hash * 89 %100 *98
    end
    result
  end
end
