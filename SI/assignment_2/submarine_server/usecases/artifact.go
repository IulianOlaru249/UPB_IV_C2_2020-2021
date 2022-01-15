package usecases

import "domain"

type Artifact struct {
	x int
	y int
}

// Enforce interface
var _ domain.ArtifactInterface = (*Artifact)(nil)

// Global to save the state across the service
var ArtifactData Artifact

//NewArtifact returns an instance of a submarine
func NewArtifact() *Artifact {
	return &Artifact{
		x: 0,
		y: 0,
	}
}

// GetCoordinates returns the position of a submarine
func (s *Artifact) GetCoordinates() (int, int) {
	return s.x, s.y
}

// UpdateCoordinates updates the position of a submarine
func (s *Artifact) UpdateCoordinates(deltaX int, deltaY int) {
	s.x += deltaX
	s.y += deltaY
}
