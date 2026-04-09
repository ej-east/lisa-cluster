package noprivilegedcontainers 

violation contains {"msg" : msg} if{ 
  ns := input.review.object.metadata.namespace
  some container in input.review.object.spec.containers

  container.securityContext.privileged == true

  msg := sprintf("Container(%v, %v) - Is privileged.", [container.name, ns])
}


violation contains {"msg" : msg} if{ 
  ns := input.review.object.metadata.namespace
  deployment_security_context := input.review.object.spec.securityContext.privileged

  deployment_security_context == true

  msg := sprintf("Deployment(%v) - Is privileged.", [ns])
}
