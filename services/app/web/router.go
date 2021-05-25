package web

import (
	"github.com/kons16/memo_app/services/account/web/handler"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

// NewServer はechoの構造体を返す
func NewServer() *echo.Echo {
	e := echo.New()

	e.Use(middleware.Recover())
	e.Use(middleware.SecureWithConfig(middleware.SecureConfig{
		XSSProtection:         "1; mode=block",
		ContentTypeNosniff:    "nosniff",
		XFrameOptions:         "DENY",
		HSTSMaxAge:            3600,
		ContentSecurityPolicy: "default-src 'self'",
	}))

	v1 := e.Group("/api/v1")

	v1.GET("/token", handler.GetToken)

	return e
}
