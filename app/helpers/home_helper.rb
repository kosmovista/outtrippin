module HomeHelper
  def homepage(args)
    return $homepage_copy[@homepage_type][args].html_safe unless args.kind_of? Array
    text = $homepage_copy[@homepage_type]
    ids = args
    begin
      text = text[ids.shift]
    end while !ids.empty?

    return text
  end

  def homepage_pics
    $homepage_copy[@homepage_type]["pics"]
  end
end
