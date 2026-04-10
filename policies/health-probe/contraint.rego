package requireprobe

violation contains {"msg" : msg} if{
  some container in input.review.object.spec.containers
  
  not container.livenessProbe 
  not container.readinessProbe

  ns := input.review.object.metadata.namespace
  msg := sprintf("Container(%v, %v) - Missing livenessProbe or readinessProbe", [container.name, ns])
}
