package explicitlynoautomountsa

violation contains {"msg" : msg} if{ 
  ns := input.review.object.metadata.namespace
  pod_sa_token := input.review.object.spec.automountServiceAccountToken
  
  not pod_sa_token == false

  msg := sprintf("Pod(%v) - Must explicitly set `spec.automountServiceAccountToken` to false", [ns])
}
