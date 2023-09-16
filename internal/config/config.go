package config

import (
	"github.com/ilyakaznacheev/cleanenv"
	"log"
	"os"
)

const configPathEnvName = "CONFIG_PATH"

type Config struct {
	Env        string     `yaml:"env" env-default:"local"`
	HttpServer HttpServer `yaml:"http_server"`
}

type HttpServer struct {
	Address     string `yaml:"address"`
	Timeout     string `yaml:"timeout"`
	IdleTimeout string `yaml:"idle_timeout"`
}

func New() Config {
	configPath := os.Getenv(configPathEnvName)
	if configPath == "" {
		log.Fatalf("%s is not set", configPathEnvName)
	}

	if _, err := os.Stat(configPath); os.IsNotExist(err) {
		log.Fatalf("config file %s does not exist", configPath)
	}

	var cfg Config
	err := cleanenv.ReadConfig(configPath, &cfg)
	if err != nil {
		log.Fatalf("cannot read config: %s", err)
	}
	return cfg
}
