# This code sample uses the 'requests' library:
# http://docs.python-requests.org
import requests
from requests.auth import HTTPBasicAuth
import json
from flask import Flask

app = Flask(__name__)

# Define a route that handles GET requests
@app.route('/createJira', methods=['POST'])
def createJira():

    url = "https://osdevops7.atlassian.net/rest/api/3/issue"

    API_TOKEN="ATATT3xFfGF0FSsidDhCHeMYdALVd253cPAyCO6yqa9BNOGZdErCHT-bgwhPBoGLj-hbdbeRBdlfnmOhf-5_B2qx-vLhVadiH5iGjMUeN49Trk3sLkX9zaBtymwQWwZ8Zgla91afidhg4DlMrV25F-q4unXMh8lu-uFbrCmDKcsNBPjpd2w5AZM=E642CF25"

    auth = HTTPBasicAuth("osdevops7@gmail.com", API_TOKEN)

    headers = {
        "Accept": "application/json",
        "Content-Type": "application/json"
    }

    payload = json.dumps( {
        "fields": {
        "description": {
            "content": [
                {
                    "content": [
                        {
                            "text": "Order entry fails when selecting supplier.",
                            "type": "text"
                        }
                    ],
                    "type": "paragraph"
                    }
                ],
            "type": "doc",
             "version": 1
        },
        "project": {
           "key": "KUBE"
        },
        "issuetype": {
            "id": "10014"
        },
        "summary": "Main order flow broken",
    },
    "update": {}
    } )


    response = requests.request(
        "POST",
        url,
        data=payload,
        headers=headers,
        auth=auth
    )

    return json.dumps(json.loads(response.text), sort_keys=True, indent=4, separators=(",", ": "))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
