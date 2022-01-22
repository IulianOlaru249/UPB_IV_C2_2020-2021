package main

import (
	"events"
	//"events"
	"log"
	"net/http"
	submarineAPI "submarineapi"
	"usecases"

	"github.com/emicklei/go-restful"
)

func main() {
	//Init globals to keep track of state across the service
	usecases.SubmarineData = *usecases.NewSubmarine()
	usecases.ArtifactData = *usecases.NewArtifact()

	//Init the rpc client to communicate with the TUI
	events.GoRPCClient = *events.NewRPCClient()

	// Start http server
	restful.Add(submarineAPI.NewSubmarineAPI())
	log.Fatal(http.ListenAndServe(":8090", nil))
}
