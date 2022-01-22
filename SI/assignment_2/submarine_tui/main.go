package main

import (
	"encoding/json"
	"github.com/gdamore/tcell/v2"
	"log"
	"net"
	"net/rpc"
	"os"
)

var s tcell.Screen
var styles *MyStyles
var submarineCoords *Coordinates
var artifactCoords *Coordinates
var fishCoords []Coordinates
var fishExists bool
var artifactExists bool

//Coordinates models the position of an object on screen
type Coordinates struct {
	X int
	Y int
}

//MyStyles encapsulates a list of style for each object
type MyStyles struct {
	DefStyle       tcell.Style
	SubmarineStyle tcell.Style
	FishStyle      tcell.Style
	ArtifactStyle  tcell.Style
}

//Listener gets updates for each object on screen
type Listener int

//initStyles sets default stylees for objects
func initStyles() *MyStyles {
	return &MyStyles{
		DefStyle:       tcell.StyleDefault.Background(tcell.ColorReset).Foreground(tcell.ColorReset),
		SubmarineStyle: tcell.StyleDefault.Foreground(tcell.ColorYellow),
		FishStyle:      tcell.StyleDefault.Foreground(tcell.ColorWhite),
		ArtifactStyle:  tcell.StyleDefault.Foreground(tcell.ColorBlack).Background(tcell.ColorOrange),
	}
}

//        |_
//  _____|~ |____
// (  --         ~~~~--_,
//  ~~~~~~~~~~~~~~~~~~~'`
//
func drawSubmarine(s tcell.Screen, x, y int, style tcell.Style) {
	s.SetContent(x+7, y, '|', nil, style)
	s.SetContent(x+8, y, '_', nil, style)
	y++

	s.SetContent(x+1, y, '_', nil, style)
	s.SetContent(x+2, y, '_', nil, style)
	s.SetContent(x+3, y, '_', nil, style)
	s.SetContent(x+4, y, '_', nil, style)
	s.SetContent(x+5, y, '_', nil, style)
	s.SetContent(x+6, y, '|', nil, style)
	s.SetContent(x+7, y, '~', nil, style)
	s.SetContent(x+8, y, ' ', nil, style)
	s.SetContent(x+9, y, '|', nil, style)
	s.SetContent(x+10, y, '_', nil, style)
	s.SetContent(x+11, y, '_', nil, style)
	s.SetContent(x+12, y, '_', nil, style)
	s.SetContent(x+13, y, '_', nil, style)
	y++

	s.SetContent(x, y, '(', nil, style)
	s.SetContent(x+1, y, ' ', nil, style)
	s.SetContent(x+2, y, ' ', nil, style)
	s.SetContent(x+3, y, '-', nil, style)
	s.SetContent(x+4, y, '-', nil, style)
	for i := 5; i <= 13; i++ {
		s.SetContent(x+i, y, ' ', nil, style)
	}
	s.SetContent(x+14, y, '~', nil, style)
	s.SetContent(x+15, y, '~', nil, style)
	s.SetContent(x+16, y, '~', nil, style)
	s.SetContent(x+17, y, '~', nil, style)
	s.SetContent(x+18, y, '-', nil, style)
	s.SetContent(x+19, y, '-', nil, style)
	s.SetContent(x+20, y, '_', nil, style)
	s.SetContent(x+21, y, ',', nil, style)
	y++

	for i := 1; i <= 19; i++ {
		s.SetContent(x+i, y, '~', nil, style)
	}
	s.SetContent(x+20, y, '\'', nil, style)
	s.SetContent(x+21, y, '`', nil, style)
}

//   _
// ><_>
//
func drawFish(s tcell.Screen, x, y int, style tcell.Style) {
	s.SetContent(x+2, y, '_', nil, style)
	y++

	s.SetContent(x, y, '>', nil, style)
	s.SetContent(x+1, y, '<', nil, style)
	s.SetContent(x+2, y, '_', nil, style)
	s.SetContent(x+3, y, '>', nil, style)
}

//[*]
func drawArtifact(s tcell.Screen, x, y int, style tcell.Style) {
	s.SetContent(x, y, '[', nil, style)
	s.SetContent(x+1, y, '*', nil, style)
	s.SetContent(x+2, y, ']', nil, style)
}

func updateScreen() {
	// Update screen
	s.Clear()
	s.Sync()

	// Draw ASCII art
	if artifactExists {
		drawArtifact(s, artifactCoords.X, artifactCoords.Y, styles.ArtifactStyle)
	}
	for _, fish := range fishCoords {
		drawFish(s, fish.X, fish.Y, styles.FishStyle)
	}
	drawSubmarine(s, submarineCoords.X, submarineCoords.Y, styles.SubmarineStyle)

	s.Show()
}

func initScreen(styles *MyStyles) tcell.Screen {
	//Redirect to new tty
	tty, err := tcell.NewDevTtyFromDev("/dev/ttyAMA0")
	if err != nil {
		log.Fatalf("%+v", err)
	}

	//open screen on new tty
	s, err = tcell.NewTerminfoScreenFromTty(tty)
	if err != nil {
		log.Fatalf("%+v", err)
	}

	if err := s.Init(); err != nil {
		log.Fatalf("%+v", err)
	}
	s.SetStyle(styles.DefStyle)
	s.EnableMouse()
	s.EnablePaste()
	s.Clear()

	return s
}

func initListener() {
	addy, err := net.ResolveTCPAddr("tcp", "0.0.0.0:42586")
	if err != nil {
		log.Fatal(err)
	}

	inbound, err := net.ListenTCP("tcp", addy)
	if err != nil {
		log.Fatal(err)
	}

	listener := new(Listener)
	rpc.Register(listener)
	rpc.Accept(inbound)
}

func quit() {
	s.Fini()
	os.Exit(0)
}

func (l *Listener) GetLineSub(payload []byte, ack *bool) error {
	//Get payload
	if err := json.Unmarshal(payload, &submarineCoords); err != nil {
		return err
	}
	updateScreen()

	return nil
}

func (l *Listener) GetLineFish(payload []byte, ack *bool) error {
	//Get payload
	if err := json.Unmarshal(payload, &fishCoords); err != nil {
		return err
	}

	updateScreen()

	return nil
}

func (l *Listener) GetLineArt(payload []byte, ack *bool) error {
	artifactExists = true

	//Get payload
	if err := json.Unmarshal(payload, &artifactCoords); err != nil {
		return err
	}

	return nil
}

func main() {
	//Init styles
	styles = initStyles()

	// Initialize screen
	s = initScreen(styles)

	//Init global coords
	submarineCoords = new(Coordinates)
	artifactCoords = new(Coordinates)
	//fishCoords = new(Coordinates)

	//Sub must always be on screen
	submarineCoords.X, submarineCoords.Y = 0, 0
	drawSubmarine(s, submarineCoords.X, submarineCoords.Y, styles.SubmarineStyle)

	// Init rpc listeners
	initListener()
}
