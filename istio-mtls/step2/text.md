You can test connectivity between all these namespaces with:
```bash
for from in "foo" "bar" "legacy"; do for to in "foo" "bar"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl http://httpbin.${to}:8000/ip -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done
```{{copy}}

<br/>

For this step, <strong>configure the `legacy` namespace to auto-inject sidecars in new pods.</strong>.

<details>
  <summary>Hint</summary>
</details>

<details>
  <summary>Solution</summary>
</details>
