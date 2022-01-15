package main

import (
	"log"
	"os"

	"github.com/gdamore/tcell/v2"
)

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

func main() {
	defStyle := tcell.StyleDefault.Background(tcell.ColorReset).Foreground(tcell.ColorReset)
	submarineStyle := tcell.StyleDefault.Foreground(tcell.ColorYellow)
	fishStyle := tcell.StyleDefault.Foreground(tcell.ColorWhite)
	artifactStyle := tcell.StyleDefault.Foreground(tcell.ColorBlack).Background(tcell.ColorOrange)

	// Initialize screen
	s, err := tcell.NewScreen()
	if err != nil {
		log.Fatalf("%+v", err)
	}
	if err := s.Init(); err != nil {
		log.Fatalf("%+v", err)
	}
	s.SetStyle(defStyle)
	s.EnableMouse()
	s.EnablePaste()
	s.Clear()

	// Draw  submarine
	x, y := 0, 0
	drawSubmarine(s, x, y, submarineStyle)
	drawFish(s, x+30, y, fishStyle)
	drawArtifact(s, x+36, y, artifactStyle)

	// Event loop
	quit := func() {
		s.Fini()
		os.Exit(0)
	}
	for {
		// Update screen
		s.Show()

		// Poll event
		ev := s.PollEvent()

		// Process event
		switch ev := ev.(type) {
		case *tcell.EventResize:
			s.Sync()
		case *tcell.EventKey:
			if ev.Key() == tcell.KeyEscape || ev.Key() == tcell.KeyCtrlC {
				quit()
			} else if ev.Key() == tcell.KeyCtrlL {
				s.Sync()
			} else if ev.Key() == tcell.KeyUp {
				// } else if ev.Rune() == 'C' || ev.Rune() == 'c' {
				s.Clear()
				if y > 0 {
					y--
				}
				drawSubmarine(s, x, y, submarineStyle)
			} else if ev.Key() == tcell.KeyDown {
				s.Clear()
				y++
				drawSubmarine(s, x, y, submarineStyle)
			} else if ev.Key() == tcell.KeyRight {
				s.Clear()
				x++
				drawSubmarine(s, x, y, submarineStyle)
			} else if ev.Key() == tcell.KeyLeft {
				s.Clear()
				x--
				drawSubmarine(s, x, y, submarineStyle)
			}
		}
	}
}
