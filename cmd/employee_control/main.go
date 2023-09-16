package main

import (
	"employee-control/internal/config"
	"employee-control/internal/logger"
	"fmt"
	"log/slog"
)

func main() {

	// TODO: init config: cleanenv
	cfg := config.New()
	fmt.Println(cfg)

	// TODO: init logger: slog

	log := logger.New(cfg.Env)

	log.Info("starting employee-control", slog.String("env", cfg.Env))
	log.Debug("debug messages enabled")

	// TODO: init storage: postgres

	// TODO: init router: echo

	// TODO: run server
}
