package main

import (
	"encoding/json"
	"io"
	"net/http"
)

// Router
func LoadRoutes() http.Handler {
	router := http.NewServeMux()

	router.HandleFunc("GET /healthcheck", HomeHandler)

	v1 := http.NewServeMux()
	v1.Handle("/v1/", http.StripPrefix("/v1", router))

	return v1
}

// Handlers
func HomeHandler(w http.ResponseWriter, r *http.Request) {
	response := map[string]string{
		"message": "Hello, World!",
	}

	WriteJSON(w, http.StatusOK, response)
}

// Utils
func WriteJSON(w http.ResponseWriter, status int, v any) error {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(status)

	return json.NewEncoder(w).Encode(v)
}

func DecodeJSON(r io.Reader, v interface{}) error {
	return json.NewDecoder(r).Decode(v)
}
