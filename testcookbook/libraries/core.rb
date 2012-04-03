module Core
  def core_func(&block)
    @node["testcookbook"]["loop"].each do | c |
       block.call(c)
    end
  end
end
