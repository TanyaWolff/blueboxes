module AreasHelper
def pretty_list(l)
return "<textarea rows=15 disabled=\"disabled\">" + l + "</textarea>"


end

def profile(vid)
return "link_to (:controller=>'volunteers',:action=>'edit', :id=>vid)"
end


end
