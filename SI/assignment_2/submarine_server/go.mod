module submarine_v0.1

go 1.16

require (
	github.com/emicklei/go-restful v2.15.0+incompatible
	submarineapi v0.1.0
	usecases v0.0.0-00010101000000-000000000000
)

replace submarineapi => ./gateway/api

replace usecases => ./usecases

replace domain => ./domain
