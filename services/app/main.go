package main

import (
	"github.com/kons16/ecs_scaling_app/services/app/web"
	"os"
)

func main() {
	s := web.NewServer()

	if err := s.Start(":8000"); err != nil {
		os.Exit(1)
	}
}
