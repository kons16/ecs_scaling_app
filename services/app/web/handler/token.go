package handler

import (
	"encoding/json"
	"github.com/kons16/memo_app/services/account/log"
	"github.com/labstack/echo/v4"
	"net/http"
)

// GET /token tokenを取得する
func GetToken(c echo.Context) error {
	logger := log.New()

	res := map[string]string{
		"token": "hello12345",
	}
	resBytes, err := json.Marshal(res)
	if err != nil {
		logger.Error("create token is failed")
		// TODO
		return nil
	}

	return c.JSON(http.StatusOK, resBytes)
}
