package domain

// SubmarineInterface models the behaviout of submarine data
type SubmarineInterface interface {
	GetCoordinates() (int, int)
	UpdateCoordinates(deltaY int, deltaX int)
}
