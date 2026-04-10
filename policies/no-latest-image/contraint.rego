package nolatesttag


valid(img) if{
  contains(img, "@")
}

valid(img) if{
  contains(img, ":")
  not contains(img, "latest")
}

violation contains {"msg" : msg} if{ 
  ns := input.review.object.metadata.namespace
  some container in input.review.object.spec.containers

  not valid(container.image)
  msg := sprintf("Container(%v, %v) - Uses latest tag", [container.name, ns])
}
