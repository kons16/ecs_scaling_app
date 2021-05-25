package config

import "os"

// IsLocal はローカル環境がどうか返す
func IsLocal() bool {
	return os.Getenv("ENV") == "local"
}

// IsDev はDev環境がどうか返す
func IsDev() bool {
	return os.Getenv("ENV") == "dev"
}
