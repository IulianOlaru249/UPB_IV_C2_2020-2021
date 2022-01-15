package domain

// FishInterface models the behaviour of Fish data
type FishInterface interface {
	GetCoordinates() (int, int)
}
