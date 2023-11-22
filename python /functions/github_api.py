import requests

response = requests.get("https://api.github.com/repos/kubernetes/kubernetes/pulls")

details = response.json()

print(details[0]["id"]) # 0 defines inex of listed directories "id" defines id of the user in directory one