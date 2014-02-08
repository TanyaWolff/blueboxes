class String
  # unicode_str.initial_caps => new_str
  # returns a copy of a string with initial capitals
  # "Jules-�douard".initial_caps => "J.�."
  def initial_caps
    self.tr('-', ' ').split(' ').map { |word| word.chars.first.upcase.to_s }.join
  end
  
end
