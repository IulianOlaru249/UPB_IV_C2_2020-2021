package submarineAPI

import (
	"encoding/json"
	"events"
	"usecases"

	restful "github.com/emicklei/go-restful"
)

const (
	serviceSub  = "Listener.GetLineSub"
	serviceFish = "Listener.GetLineFish"
	serviceArt  = "Listener.GetLineArt"
)

type Coordinates struct {
	X int
	Y int
}

// NewSubmarineAPI returns an instance of a rest api handler
func NewSubmarineAPI() *restful.WebService {
	service := new(restful.WebService)
	service.Path("/api").
		Consumes(restful.MIME_JSON).
		Produces(restful.MIME_JSON)

	service.Route(service.GET("/submarine").To(GetSubmarinePosition))
	service.Route(service.POST("/submarine/move").To(UpdateSubmarinePosition))
	service.Route(service.GET("/fish").To(GetFishList))
	service.Route(service.POST("/fish/add").To(AddNewFish))
	service.Route(service.GET("/artifact").To(GetArtifactPosition))
	service.Route(service.POST("/artifact/update").To(UpdateArtifactPosition))

	return service
}

// GetSubmarinePosition returns the coordinates of the submarine
func GetSubmarinePosition(request *restful.Request, response *restful.Response) {
	x, y := usecases.SubmarineData.GetCoordinates()
	currentCoordinates := Coordinates{
		X: x,
		Y: y,
	}

	err := response.WriteEntity(currentCoordinates)
	if err != nil {
		return
	}
}

// UpdateSubmarinePosition midifies the coordinates of the submarine
func UpdateSubmarinePosition(request *restful.Request, response *restful.Response) {
	var newCoordinates Coordinates
	oldX, oldY := usecases.SubmarineData.GetCoordinates()

	err := request.ReadEntity(&newCoordinates)
	if err != nil {
		return
	}

	usecases.SubmarineData.UpdateCoordinates(newCoordinates.X, newCoordinates.Y)

	newCoordinates.X += oldX
	newCoordinates.Y += oldY

	// Send the message to the RPC TUI server
	newCoordinatesJSON, _ := json.Marshal(newCoordinates)
	err = events.GoRPCClient.SendMessage(serviceSub, newCoordinatesJSON)
	if err != nil {
		err = response.WriteEntity("Failed to send position to RPC TUI server")
		if err != nil {
			return
		}
		return
	}

	err = response.WriteEntity("Sub moved!")
	if err != nil {
		return
	}
}

// GetFishList returns a list of all available fish
func GetFishList(request *restful.Request, response *restful.Response) {
	// This is silly. Should be nil slice not on heap,
	// but it is like this to respect silly api requirement
	fishCoordinates := make([]Coordinates, 0)

	for _, fish := range usecases.FishData {
		x, y := fish.GetCoordinates()
		fishCoordinates = append(fishCoordinates, Coordinates{
			X: x,
			Y: y,
		})
	}

	err := response.WriteEntity(fishCoordinates)
	if err != nil {
		return
	}
}

// AddNewFish adds another fish to the list
func AddNewFish(request *restful.Request, response *restful.Response) {
	var newCoordinates Coordinates
	var allFishCoords []Coordinates

	err := request.ReadEntity(&newCoordinates)
	if err != nil {
		return
	}

	usecases.AddFish(newCoordinates.X, newCoordinates.Y)
	for _, fish := range usecases.FishData {
		x, y := fish.GetCoordinates()
		allFishCoords = append(allFishCoords, Coordinates{X: x, Y: y})
	}
	allFishCoordsJSON, _ := json.Marshal(allFishCoords)
	err = events.GoRPCClient.SendMessage(serviceFish, allFishCoordsJSON)
	if err != nil {
		err = response.WriteEntity("Failed to send position to RPC TUI server")
		if err != nil {
			return
		}
		return
	}

	err = response.WriteEntity("Hello from new fish!")
	if err != nil {
		return
	}
}

// GetArtifactPosition returns the coordinates of an artifact
func GetArtifactPosition(request *restful.Request, response *restful.Response) {
	x, y := usecases.ArtifactData.GetCoordinates()
	currentCoordinates := Coordinates{
		X: x,
		Y: y,
	}

	err := response.WriteEntity(currentCoordinates)
	if err != nil {
		return
	}
}

// UpdateArtifactPosition changes the coordinates of an artifact
func UpdateArtifactPosition(request *restful.Request, response *restful.Response) {
	var newCoordinates Coordinates
	oldX, oldY := usecases.ArtifactData.GetCoordinates()

	// Send the message to the RPC TUI server
	err := request.ReadEntity(&newCoordinates)
	if err != nil {
		return
	}

	usecases.ArtifactData.UpdateCoordinates(newCoordinates.X, newCoordinates.Y)

	newCoordinates.X += oldX
	newCoordinates.Y += oldY

	// Send the message to the RPC TUI server
	newCoordinatesJSON, _ := json.Marshal(newCoordinates)
	err = events.GoRPCClient.SendMessage(serviceArt, newCoordinatesJSON)
	if err != nil {
		err = response.WriteEntity("Failed to send position to RPC TUI server")
		if err != nil {
			return
		}
		return
	}

	err = response.WriteEntity("Artifact moved!")
	if err != nil {
		return
	}
}
