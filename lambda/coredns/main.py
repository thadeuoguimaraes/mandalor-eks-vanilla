import json
import ssl
import urllib.request


def handler(event, context):
    endpoint = event["endpoint"]
    token = event["token"]

    ctx = ssl.create_default_context()
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_NONE

    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/strategic-merge-patch+json",
    }

    patch = json.dumps(
        {
            "spec": {
                "template": {
                    "spec": {
                        "affinity": {},
                        "tolerations": [
                            {
                                "key": "eks.amazonaws.com/compute-type",
                                "operator": "Equal",
                                "value": "fargate",
                                "effect": "NoSchedule",
                            }
                        ],
                    }
                }
            }
        }
    ).encode()

    url = f"{endpoint}/apis/apps/v1/namespaces/kube-system/deployments/coredns"
    req = urllib.request.Request(url, data=patch, headers=headers, method="PATCH")

    with urllib.request.urlopen(req, context=ctx) as response:
        result = json.loads(response.read())

    return {"status": "ok", "name": result.get("metadata", {}).get("name")}
