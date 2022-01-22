module submarine_v0.1

go 1.16

require (
	events v0.1.0
	github.com/emicklei/go-restful v2.15.0+incompatible
	submarineapi v0.1.0
	usecases v0.1.0
)

replace submarineapi => ./gateway/api

replace usecases => ./usecases

replace domain => ./domain

replace events => ./gateway/events
