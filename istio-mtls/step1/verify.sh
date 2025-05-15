foo_httpbin=$(kubectl get deploy -n foo httpbin -o yaml | yq '.spec.template.metadata.labels."security.istio.io/tlsMode"')
bar_httpbin=$(kubectl get deploy -n bar httpbin -o yaml | yq '.spec.template.metadata.labels."security.istio.io/tlsMode"')
foo_curl=$(kubectl get deploy -n foo curl -o yaml | yq '.spec.template.metadata.labels."security.istio.io/tlsMode"')
bar_curl=$(kubectl get deploy -n bar curl -o yaml | yq '.spec.template.metadata.labels."security.istio.io/tlsMode"')

# check annotations
if [[ $foo_httpbin != "istio" || $bar_httpbin != "istio" || $foo_curl != "istio" || $bar_curl != "istio" ]]; then
  exit 1;
fi

# check sidecar container
if ! kubectl get deploy -n foo httpbin -o yaml | yq '.spec.template.spec.containers[1].name' | grep -q istio ; then exit 1; fi
if ! kubectl get deploy -n bar httpbin -o yaml | yq '.spec.template.spec.containers[1].name' | grep -q istio ; then exit 1; fi
if ! kubectl get deploy -n foo curl -o yaml | yq '.spec.template.spec.containers[1].name' | grep -q istio ; then exit 1; fi
if ! kubectl get deploy -n bar curl -o yaml | yq '.spec.template.spec.containers[1].name' | grep -q istio ; then exit 1; fi
