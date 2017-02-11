class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method("#{name}=") do |name_value| #where does name_value come from?
        instance_variable_set("@#{name}", name_value)
      end
      define_method("#{name}") do
        instance_variable_get("@#{name}")
      end
    end
  end
end
