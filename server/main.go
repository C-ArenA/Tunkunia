package main

import (
	"fmt"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("Accessed: %s\n", r.URL.Path)
	fmt.Fprintf(w, "Tunkunia UP! %s", r.URL.Path)
}

func main() {
	fmt.Println("Tunkunia UP!")
	http.HandleFunc("/health", handler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
