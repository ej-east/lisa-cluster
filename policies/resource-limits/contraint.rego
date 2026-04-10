package requireresourcelimits

violation contains {"msg" : msg} if{
  some container in input.review.object.spec.containers
  not container.resources.limits.cpu 

  msg := sprintf("Container(%v) - Missing CPU limit", [container.name])
}

violation contains {"msg" : msg} if{
  some container in input.review.object.spec.containers
  not container.resources.limits.memory 

  msg := sprintf("Container(%v) - Missing memory limit", [container.name])
}
