There are two deployments in each of the `foo` and `bar` namespaces:
- `curl` to test connectivity between different endpoints using `curl`
- `httpbin` to expose a web server to test connectivity to.

In the third namespace `legacy`, you will find the `curl` deployment only.

You can test connectivity between all these namespaces with:
```bash
for from in "foo" "bar" "legacy"; do
  for to in "foo" "bar"; do
    kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl http://httpbin.${to}:8000/ip -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"
  done
done
```{{copy}}

<br/>

For this step, <strong>configure all deployments in the `foo` and `bar` namespace to use the Istio sidecars</strong>.

<details>
  <summary>Hint</summary>
  ```bash
  istioctl kube-inject -f ...
  ```
</details>

<details>
  <summary>Solution</summary>
  ```bash
  istioctl kube-inject -f ...
  ```
</details>
