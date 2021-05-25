package log

import (
	"github.com/kons16/memo_app/services/account/config"
	"github.com/labstack/gommon/log"
)

// New はロガーを生成する
func New() *log.Logger {
	logger := log.New("application")
	logger.SetLevel(log.INFO)
	if config.IsLocal() || config.IsDev() {
		logger.SetLevel(log.DEBUG)
	}
	return logger
}
