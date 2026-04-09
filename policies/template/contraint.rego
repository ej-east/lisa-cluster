package example

violation contains {"msg" : msg} if{ 

  msg := sprintf("<Something>(%v) - <is wrong>", [container.name])
}
