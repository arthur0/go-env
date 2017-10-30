package main

import (
	"io"
	"net/http"
	"os"

	"github.com/julienschmidt/httprouter"
)

func getEnv(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}

func indexHandler(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	io.WriteString(w, getEnv("ENV_NAME", "DEFAULT ENV"))
	io.WriteString(w, ": ")
	io.WriteString(w, getEnv("ENV_VALUE", "DEFAULT VALUE"))
}

func main() {
	router := httprouter.New()
	router.GET("/", indexHandler)
	http.ListenAndServe(":80", router)
}
