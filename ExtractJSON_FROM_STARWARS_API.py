import requests
import json
 
url = "https://swapi.dev/api/people/"
 
response = requests.get(url)
data = response.text
parsed = json.loads(data)
name = parsed["results"]
#print(name) 
##result='"Results":'
#print (result)
name="result:"+str(name)
f = open('STAR_WARS_API.json', 'w')
#f.write(name)
json.dump(name, f, indent = 6)  
f.close()

