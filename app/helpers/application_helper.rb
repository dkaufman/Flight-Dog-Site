module ApplicationHelper
  
  if ENV['R_HOME'].nil?
    ENV['R_HOME'] = "/Library/Frameworks/R.framework/Versions/2.13/Resources"
  end
  
end
