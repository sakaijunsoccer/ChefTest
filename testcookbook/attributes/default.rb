if node.attribute?("apache")
default["testcookbook"]["first_name"] = "jun"
else
default["testcookbook"]["first_name"] = "yuko"
end
normal["testcookbook"]["last_name"] = "sakai"

normal["testcookbook"]["loop"] = [1,2,3]
