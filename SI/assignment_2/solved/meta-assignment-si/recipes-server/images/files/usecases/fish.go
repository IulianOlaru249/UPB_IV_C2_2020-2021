package usecases

import "domain"

type Fish struct {
	x int
	y int
}

// Enforce interface
var _ domain.FishInterface = (*Fish)(nil)

// Global to save the state across the service
var FishData []Fish

//NewFish returns an instance of a fish
func NewFish(x int, y int) *Fish {
	return &Fish{
		x: x,
		y: y,
	}
}

//GetCoordinates returns the position of a fish
func (s *Fish) GetCoordinates() (int, int) {
	return s.x, s.y
}

// AddFish updates the position of a submarine
func AddFish(x int, y int) {
	FishData = append(FishData, *NewFish(x, y))
	if len(FishData) > 5 {
		FishData = FishData[1:]
	}
}
