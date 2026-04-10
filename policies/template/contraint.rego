package example

violation contains {"msg" : msg} if{ 
  ns := input.review.object.metadata.namespace
  some container in input.review.object.spec.containers

  msg := sprintf("<Something>(%v, %v) - <is wrong>", [container.name, ns])
}
