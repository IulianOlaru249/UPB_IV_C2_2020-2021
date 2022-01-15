package usecases

import "domain"

type Submarine struct {
	x int
	y int
}

// Enforce interface
var _ domain.SubmarineInterface = (*Submarine)(nil)

// Global to save the state across the service
var SubmarineData Submarine

//NewSubmarine returns an instance of a submarine
func NewSubmarine() *Submarine {
	return &Submarine{
		x: 0,
		y: 0,
	}
}

// GetCoordinates returns the position of a submarine
func (s *Submarine) GetCoordinates() (int, int) {
	return s.x, s.y
}

// UpdateCoordinates updates the position of a submarine
func (s *Submarine) UpdateCoordinates(deltaX int, deltaY int) {
	s.x += deltaX
	s.y += deltaY
}
