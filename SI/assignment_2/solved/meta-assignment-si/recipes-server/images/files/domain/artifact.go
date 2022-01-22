package domain

// ArtifactInterface models the behaviour of Artifact data
type ArtifactInterface interface {
	GetCoordinates() (int, int)
	UpdateCoordinates(deltaY int, deltaX int)
}
